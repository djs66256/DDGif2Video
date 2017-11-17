//
//  DDGifImage.h
//  Demo
//
//  Created by hzduanjiashun on 2017/11/17.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>

@interface DDGifImage : NSObject

@property (nonatomic, strong, readonly) NSString *path;
@property (nonatomic, strong, readonly) NSString *name;

@property (assign, nonatomic) BOOL isGif;

@property (nonatomic, assign) NSInteger loopCount;
@property (nonatomic, assign) NSTimeInterval delayTime;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign, readonly) NSInteger imageCount;

- (NSEnumerator<CIImage *> *)CIImageEnumerator;

- (instancetype)initWithPath:(NSString *)path;

@end
