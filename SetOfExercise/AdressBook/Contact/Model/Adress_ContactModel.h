//
//  Adress_ContactModel.h
//  SetOfExercise
//
//  Created by 胡古斤 on 16/8/12.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Adress_ContactModel : NSObject <NSCoding>

/** 姓名 */
@property (nonatomic, strong) NSString * name;

/** 电话 */
@property (nonatomic, strong) NSString * phone;


+ (instancetype)contactWithName: (NSString *)name phone: (NSString *)phone;
+ (instancetype)contactWithDic: (NSDictionary *)dic;


@end
