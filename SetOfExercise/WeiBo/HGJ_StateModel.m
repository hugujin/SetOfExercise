//
//  HGJ_StateModel.m
//  mytest
//
//  Created by 胡古斤 on 16/7/5.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import "HGJ_StateModel.h"

@implementation HGJ_StateModel

+ (instancetype)stateModel: (NSDictionary *)cellDic
{
    HGJ_StateModel * model = [[HGJ_StateModel alloc]init];
    [model setValuesForKeysWithDictionary:cellDic];
    return model;
}

@end
