//
//  DDGif2VideoTransformer.h
//  Demo
//
//  Created by hzduanjiashun on 2017/11/17.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDVideoData.h"
#import "DDGifImage.h"

@interface DDGif2VideoTransformer : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, assign) BOOL forceUpdateVideo;

- (void)generateVideoFromGif:(DDGifImage *)gif complete:(void(^)(DDVideoData *))complete;

@end
