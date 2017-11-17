//
//  DDVideoData.m
//  Demo
//
//  Created by hzduanjiashun on 2017/11/17.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "DDVideoData.h"
#import "DDVideoCache.h"

@implementation DDVideoData

- (instancetype)initWithPath:(NSString *)path
{
    self = [super init];
    if (self) {
        _path = path;
        
        _loopCount = [[DDVideoCache defaultCache] loopCountForVideo:path.lastPathComponent.stringByDeletingPathExtension];
        
    }
    return self;
}

@end
