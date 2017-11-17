//
//  DDGifVideoView.m
//  Demo
//
//  Created by hzduanjiashun on 2017/11/17.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "DDGifVideoView.h"
#import "DDGif2VideoTransformer.h"

@implementation DDGifVideoView {
    NSInteger _currentLoopCount;
    DDVideoData *_video;
}

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AVPlayerItemDidPlayToEndTimeNotification:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return self;
}

- (AVPlayerLayer *)avLayer {
    return (AVPlayerLayer *)self.layer;
}

- (void)setGifPath:(NSString *)path {
    DDGifImage *image = [[DDGifImage alloc] initWithPath:path];
    [self setGif:image];
}

- (void)setGif:(DDGifImage *)gif {
    __weak DDGifVideoView *weak_self = self;
    [[DDGif2VideoTransformer sharedInstance] generateVideoFromGif:gif complete:^(DDVideoData *video) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weak_self setVideo:video];
        });
    }];
}

- (void)setVideo:(DDVideoData *)video {
    _video = video;
    NSURL *url = [NSURL fileURLWithPath:video.path isDirectory:NO];
    self.avLayer.player = [AVPlayer playerWithURL:url];
    [self start];
}

- (void)start {
    [self.avLayer.player play];
}

- (void)pause {
    [self.avLayer.player pause];
}

- (void)stop {
    [self.avLayer.player pause];
    _currentLoopCount = 0;
    [self.avLayer.player seekToTime:kCMTimeZero];
}

- (void)restart {
    [self.avLayer.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        [self.avLayer.player play];
    }];
}

- (void)AVPlayerItemDidPlayToEndTimeNotification:(NSNotification *)noti {
    if (noti.object == self.avLayer.player.currentItem) {
        _currentLoopCount ++;
        if (_video.loopCount <= 0) {
            [self restart];
        }
        if (_currentLoopCount < _video.loopCount) {
            [self restart];
        }
        else {
            [self stop];
        }
    }
}

@end
