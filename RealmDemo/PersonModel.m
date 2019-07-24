//
//  PersonModel.m
//  RealmDemo
//
//  Created by mm on 2019/7/24.
//  Copyright © 2019 mm. All rights reserved.
//

#import "PersonModel.h"

@implementation PersonModel

//这个方法规定表的主键(如无此方法,则该张表没有主键)
+(NSString *)primaryKey{
    return @"carID";
}

//该方法为表中的字段添加默认值
+(NSDictionary *)defaultPropertyValues{
    
    return @{@"name":@"",@"age":@(0)};
    
}
@end
