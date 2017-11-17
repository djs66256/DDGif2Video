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
    NSString *_videoInfoPath;
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
        _videoInfoPath = [[DDVideoCache rootPath] stringByAppendingPathComponent:@"info.plist"];
        _videoInfo = [NSDictionary dictionaryWithContentsOfFile:_videoInfoPath].mutableCopy;
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
    _videoInfo[name] = @{DDVideoLoopCountKey: @(loopCount)};
    [_videoInfo writeToFile:_videoInfoPath atomically:YES];
}

- (void)removeInfoForKey:(NSString *)name {
    [_videoInfo removeObjectForKey:name];
    [_videoInfo writeToFile:_videoInfoPath atomically:YES];
}

- (NSString *)pathForVideo:(NSString *)name {
    return [[DDVideoCache rootPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4", name]];
}

@end
