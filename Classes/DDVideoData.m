//
//  DDVideoData.m
//  Demo
//
//  Created by hzduanjiashun on 2017/11/17.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "DDVideoData.h"

@implementation DDVideoData

- (instancetype)initWithPath:(NSString *)path
{
    self = [super init];
    if (self) {
        _path = path;
    }
    return self;
}

@end
