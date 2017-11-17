//
//  DDVideoCache.m
//  Demo
//
//  Created by hzduanjiashun on 2017/11/17.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "DDVideoCache.h"

const NSString *DDVideoLoopCountKey = @"DDVideoLoopCountKey";

@implementation DDVideoCache {
    NSMutableDictionary *_videoInfo;
}

+ (instancetype)defaultCache {
    static dispatch_once_t onceToken;
    static DDVideoCache *cache;
    dispatch_once(&onceToken, ^{
        cache = [[DDVideoCache alloc] init];
    });
    return cache;
}

+ (NSString *)rootPath {
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    cachePath = [cachePath stringByAppendingPathComponent:@"gif_video"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return cachePath;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _videoInfo = [NSDictionary dictionaryWithContentsOfFile:[[DDVideoCache rootPath] stringByAppendingPathComponent:@"info.plist"]].mutableCopy;
        if (_videoInfo == nil) {
            _videoInfo = [NSMutableDictionary new];
        }
    }
    return self;
}

- (NSInteger)loopCountForVideo:(NSString *)name {
    return [_videoInfo[name][DDVideoLoopCountKey] integerValue];
}

- (void)setLoopCount:(NSInteger)loopCount forKey:(NSString *)name {
    
}

- (NSString *)pathForVideo:(NSString *)name {
    return [[DDVideoCache rootPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4", name]];
}

@end
