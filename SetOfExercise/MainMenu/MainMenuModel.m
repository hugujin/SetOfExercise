//
//  MainMenuModel.m
//  SetOfExercise
//
//  Created by 胡古斤 on 16/8/5.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import "MainMenuModel.h"

@implementation MainMenuModel

+ (instancetype)modelWithDic:(NSDictionary *)dic
{
    MainMenuModel * model = [[self alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

@end
