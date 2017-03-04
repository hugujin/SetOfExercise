//
//  RunTime.h
//  test
//
//  Created by 胡古斤 on 2017/2/17.
//  Copyright © 2017年 胡古斤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunTime : NSObject

+ (void)getIvarList: (Class)class;
+ (void)getMethodList: (Class)class;

@end
