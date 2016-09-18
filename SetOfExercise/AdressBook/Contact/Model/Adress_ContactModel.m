//
//  Adress_ContactModel.m
//  SetOfExercise
//
//  Created by 胡古斤 on 16/8/12.
//  Copyright © 2016年 胡古斤. All rights reserved.
//

#import "Adress_ContactModel.h"

@implementation Adress_ContactModel



+ (instancetype)contactWithName:(NSString *)name phone:(NSString *)phone {
    
    Adress_ContactModel * contact = [[self alloc]init];
    
    contact.name = name;
    contact.phone = phone;
    
    return contact;
}


+ (instancetype)contactWithDic:(NSDictionary *)dic {
    
    Adress_ContactModel * contact = [[self alloc]init];
    
    [contact setValuesForKeysWithDictionary:dic];
    
    return contact;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.phone = [aDecoder decodeObjectForKey:@"phone"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
}


@end
