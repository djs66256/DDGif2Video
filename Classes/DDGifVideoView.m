//
//  DDGifVideoView.m
//  Demo
//
//  Created by hzduanjiashun on 2017/11/17.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "DDGifVideoView.h"

@implementation DDGifVideoView

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayerLayer *)avLayer {
    return (AVPlayerLayer *)self.layer;
}

- (instancetype)initWithPath:(NSString *)path
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithGif:(DDGifImage *)gif
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithVideo:(DDVideoData *)video {
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end
