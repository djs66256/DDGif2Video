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

- (instancetype)initWithPath:(NSString *)path;
- (instancetype)initWithGif:(DDGifImage *)gif;
- (instancetype)initWithVideo:(DDVideoData *)video;

@end
