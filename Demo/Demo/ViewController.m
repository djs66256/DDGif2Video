//
//  ViewController.m
//  Demo
//
//  Created by hzduanjiashun on 2017/11/17.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "ViewController.h"
#import "DDGif2VideoTransformer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DDGifImage *image = [[DDGifImage alloc] initWithPath:[NSBundle.mainBundle pathForResource:@"test1" ofType:@"gif"]];
    [DDGif2VideoTransformer sharedInstance].forceUpdateVideo = YES;
    [[DDGif2VideoTransformer sharedInstance] generateVideoFromGif:image complete:^(DDVideoData *video) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
