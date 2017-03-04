//
//  HGJChattingModel.m
//  HGJChatting
//
//  Created by 胡古斤 on 16/7/9.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import "HGJChattingModel.h"

@implementation HGJChattingModel

+ (instancetype)modelWithDic: (NSDictionary *)dic {
    
    HGJChattingModel * model = [[HGJChattingModel alloc]init];
    [model setValuesForKeysWithDictionary:dic];

    return model;
}

+ (instancetype)modelWithText:(NSString *)text {
    
    HGJChattingModel * model = [[HGJChattingModel alloc]init];
    model.text = text;
    model.type = arc4random_uniform(2);
    
    //时间
    NSDate * date = [NSDate date];
    NSDateFormatter * formate = [[NSDateFormatter alloc]init];
    formate.dateFormat = @"今天 hh:mm";
    NSString * dateStr = [formate stringFromDate:date];
    
    model.time = dateStr;
    
    return model;
}


+ (NSDictionary *)dicFromModel: (HGJChattingModel *)model {
    
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:model.text, @"text", model.time, @"time", [NSString stringWithFormat:@"%d", model.type], @"type", nil];
    return dic;
}

@end
