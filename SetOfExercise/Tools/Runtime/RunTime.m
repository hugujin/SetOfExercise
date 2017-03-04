//
//  RunTime.m
//  test
//
//  Created by 胡古斤 on 2017/2/17.
//  Copyright © 2017年 胡古斤. All rights reserved.
//

#import "RunTime.h"
#import <objc/runtime.h>

@implementation RunTime

+ (void)getIvarList: (Class)class {
    
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList(class, &count);
    
    
    for (int i = 0; i < count; ++i) {
        
        Ivar ivar = ivars[i];
        
        NSString * name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString * type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        NSLog(@"%@,%@", name, type);
    }
    
}

+ (void)getMethodList: (Class)class {
    
    unsigned int count = 0;
    
    Method * methods = class_copyMethodList(class, &count);
    
    for (int i = 0; i < count; ++i) {
        
        Method method = methods[i];
        
        
        NSString * name = [NSString stringWithUTF8String:sel_getName(method_getName(method))];
        NSString * type = [NSString stringWithUTF8String:method_getTypeEncoding(method)];
        
        NSLog(@"%@, %@", name, type);
    }
    
    
}

@end
