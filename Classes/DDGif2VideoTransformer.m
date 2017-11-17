//
//  DDGif2VideoTransformer.m
//  Demo
//
//  Created by hzduanjiashun on 2017/11/17.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <CoreImage/CoreImage.h>
#import "DDGif2VideoTransformer.h"
#import "DDVideoCache.h"
#import "DDMacro.h"

@implementation DDGif2VideoTransformer

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static DDGif2VideoTransformer *transformer;
    dispatch_once(&onceToken, ^{
        transformer = [[DDGif2VideoTransformer alloc] init];
    });
    return transformer;
}

- (void)generateVideoFromGif:(DDGifImage *)gif complete:(void (^)(DDVideoData *))complete {
    NSString *path = [[DDVideoCache defaultCache] pathForVideo:gif.name];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        if (self.forceUpdateVideo) {
            NSError *error;
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            if (error) {
                DDDebugInfo(@"[Error] %@", error.localizedDescription);
            }
        }
        else {
            complete([[DDVideoData alloc] initWithPath:path]);
            return ;
        }
    }
    
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    AVAssetWriter *assertWriter = [[AVAssetWriter alloc] initWithURL:url fileType:AVFileTypeMPEG4 error:&error];
    if (error) {
        DDDebugInfo(@"[Error] %@", error.localizedDescription);
        complete(nil);
        return ;
    }
    
    NSDictionary *writerSettings = @{
                                     AVVideoCodecKey: AVVideoCodecTypeH264,
                                     AVVideoWidthKey: @(gif.width),
                                     AVVideoHeightKey: @(gif.height)
                                     };
    AVAssetWriterInput *writerInput = [[AVAssetWriterInput alloc] initWithMediaType:AVMediaTypeVideo outputSettings:writerSettings];
    [assertWriter addInput:writerInput];
    
    NSDictionary *pixelBufferAttributes = @{
                                            (id)kCVPixelBufferPixelFormatTypeKey: @(kCVPixelFormatType_32BGRA),
                                            (id)kCVPixelBufferWidthKey: @(gif.width),
                                            (id)kCVPixelBufferHeightKey: @(gif.height)
                                            };
    AVAssetWriterInputPixelBufferAdaptor *writerInputAdaptor = [[AVAssetWriterInputPixelBufferAdaptor alloc] initWithAssetWriterInput:writerInput sourcePixelBufferAttributes:pixelBufferAttributes];
    
    
    NSEnumerator<CIImage *> *enumerator = gif.CIImageEnumerator;
    CIContext *ctx = [CIContext context];
    __block CMTime time = CMTimeMake(0, 10);
    CMTime frameTime = CMTimeMake(1, 10);
    
    if ([assertWriter startWriting]) {
        [assertWriter startSessionAtSourceTime:time];
        [writerInput requestMediaDataWhenReadyOnQueue:dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT) usingBlock:^{
            while (writerInput.isReadyForMoreMediaData) {
                CIImage *ciImage = [enumerator nextObject];
                if (ciImage == nil) {
                    [writerInput markAsFinished];
                    [assertWriter finishWritingWithCompletionHandler:^{
                        DDVideoData *video = [[DDVideoData alloc] initWithPath:path];
                        complete(video);
                    }];
                    return ;
                }
                
                CVPixelBufferRef pixelBuffer;
                CVReturn ret = CVPixelBufferPoolCreatePixelBuffer(NULL, writerInputAdaptor.pixelBufferPool, &pixelBuffer);
                if (ret != kCVReturnSuccess) {
                    DDDebugInfo(@"[Error] CVPixelBuffer create error with code (%zd)!", ret);
                    complete(nil);
                    if (pixelBuffer) CVPixelBufferRelease(pixelBuffer);
                    return;
                }
                if (pixelBuffer) {
                    [ctx render:ciImage toCVPixelBuffer:pixelBuffer];
                    
                    if (![writerInputAdaptor appendPixelBuffer:pixelBuffer withPresentationTime:time]) {
                        DDDebugInfo(@"[Error] Assert write error!");
                        complete(nil);
                        CVPixelBufferRelease(pixelBuffer);
                        return;
                    }
                    CVPixelBufferRelease(pixelBuffer);
                    time = CMTimeAdd(time, frameTime);
                }
            }
        }];
    }
}

@end
