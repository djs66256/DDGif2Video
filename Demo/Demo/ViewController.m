//
//  ViewController.m
//  Demo
//
//  Created by hzduanjiashun on 2017/11/17.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "ViewController.h"
#import "DDGif2VideoTransformer.h"
#import "DDGifVideoView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DDGifImage *image = [[DDGifImage alloc] initWithPath:[NSBundle.mainBundle pathForResource:@"test1" ofType:@"gif"]];
//    [DDGif2VideoTransformer sharedInstance].forceUpdateVideo = YES;
//    [[DDGif2VideoTransformer sharedInstance] generateVideoFromGif:image complete:^(DDVideoData *video) {
//
//    }];
    
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2);
    DDGifVideoView *view1 = [[DDGifVideoView alloc] initWithFrame:frame];
    view1.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:view1];
    [view1 setGif:image];
    
    
    frame.origin.y = self.view.frame.size.height/2;
    DDGifVideoView *view2 = [[DDGifVideoView alloc] initWithFrame:frame];
    view2.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:view2];
    [view2 setGifPath:[NSBundle.mainBundle pathForResource:@"test2" ofType:@"gif"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
