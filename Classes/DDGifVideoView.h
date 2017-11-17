//
//  DDGifVideoView.h
//  Demo
//
//  Created by hzduanjiashun on 2017/11/17.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDGifImage.h"
#import "DDVideoData.h"

@interface DDGifVideoView : UIView

- (void)setGifPath:(NSString *)path;
- (void)setGif:(DDGifImage *)gif;

- (void)setVideo:(DDVideoData *)video;

- (void)start;
- (void)stop;
- (void)pause;

@end
