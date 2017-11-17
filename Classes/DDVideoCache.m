//
//  DDVideoCache.m
//  Demo
//
//  Created by hzduanjiashun on 2017/11/17.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "DDVideoCache.h"

@implementation DDVideoCache

+ (instancetype)defaultCache {
    static dispatch_once_t onceToken;
    static DDVideoCache *cache;
    dispatch_once(&onceToken, ^{
        cache = [[DDVideoCache alloc] init];
    });
    return cache;
}

- (NSString *)pathForVideo:(NSString *)name {
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    return [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4", name]];
}

@end
