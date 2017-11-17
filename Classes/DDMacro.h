//
//  DDMacro.h
//  Demo
//
//  Created by hzduanjiashun on 2017/11/17.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#ifndef DDMacro_h
#define DDMacro_h

#if DEBUG
#define DDDebugInfo(...) NSLog(@"[DDGif2Video]" __VA_ARGS__)
#else
#define DDDebugInfo(...)
#endif


#endif /* DDMacro_h */
