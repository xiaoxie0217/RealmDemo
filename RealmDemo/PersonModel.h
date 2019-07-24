//
//  PersonModel.h
//  RealmDemo
//
//  Created by mm on 2019/7/24.
//  Copyright © 2019 mm. All rights reserved.
//

#import "RLMObject.h"
#import "DogModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PersonModel : RLMObject
//作为主键,保证唯一性
@property  int carID;
@property  NSString *name;
@property  int age;
//是否养有狗/为了和狗的表关联
@property  BOOL Dog;
//关联dog表
@property  DogModel *dogModel;
@end

NS_ASSUME_NONNULL_END
