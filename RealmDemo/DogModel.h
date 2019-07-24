//
//  DogModel.h
//  RealmDemo
//
//  Created by mm on 2019/7/24.
//  Copyright © 2019 mm. All rights reserved.
//

#import "RLMObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface DogModel : RLMObject
//这使用person表中主键作为dog表中的主键
@property  int carID;

@property  NSString *name;

@property  int age;

@end

NS_ASSUME_NONNULL_END
