//
//  DDVideoData.h
//  Demo
//
//  Created by hzduanjiashun on 2017/11/17.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface DDVideoData : NSObject

@property (nonatomic, strong, readonly) NSString *path;

@property (nonatomic, assign, readonly) NSInteger loopCount;

- (instancetype)initWithPath:(NSString *)path;

@end
