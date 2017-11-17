//
//  DDVideoCache.h
//  Demo
//
//  Created by hzduanjiashun on 2017/11/17.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDVideoCache : NSObject

+ (instancetype)defaultCache;

- (NSString *)pathForVideo:(NSString *)name;

- (NSInteger)loopCountForVideo:(NSString *)name;
- (void)setLoopCount:(NSInteger)loopCount forKey:(NSString *)name;
- (void)removeInfoForKey:(NSString *)name;

@end
