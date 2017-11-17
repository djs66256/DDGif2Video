//
//  DDVideoData.h
//  Demo
//
//  Created by hzduanjiashun on 2017/11/17.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDGifImage.h"

@interface DDVideoData : NSObject

@property (nonatomic, strong, readonly) NSString *path;

- (instancetype)initWithPath:(NSString *)path;

@end
