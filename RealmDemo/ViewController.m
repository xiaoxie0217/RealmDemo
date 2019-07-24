//
//  ViewController.m
//  RealmDemo
//
//  Created by mm on 2019/7/24.
//  Copyright © 2019 mm. All rights reserved.
//

#import "ViewController.h"
#import "Realm.h"
#import "PersonModel.h"
#import "DogModel.h"
@interface ViewController ()

@property (nonatomic,strong) RLMRealm *rl;;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //进行数据库任何操作,第一件事就是先打开表
    self.rl = [RLMRealm defaultRealm];
}
#pragma mark 增
/*
 当含有主键的表增加数据  如果主键相同则不会增加,只会更新表中该主键的数据
 */
-(void)addData{
    //弱引用
    __weak typeof(self) weakself = self;
    //循环往表中添加数据
    for (int i = 0; i<10; i++) {
        //初始化表
        PersonModel *person = [[PersonModel alloc] init];
        //关联表初始化的时候,只能是点出来主表中的关联表进行初始化 如果直接初始化会存不进去数据
        person.dogModel = [[DogModel alloc] init];
        
        person.carID = i;
        person.name = [NSString stringWithFormat:@"%@%d",@"小明",i];
        person.age = 10+i;
        person.Dog = YES;
        person.dogModel.carID = person.carID;
        person.dogModel.name = @"小白";
        [self.rl transactionWithBlock:^{
            [weakself.rl addOrUpdateObject:person];
        }];
    }
}

#pragma mark 查
-(void)examineData{
    //条件查的时候必须 字段名字和类型对应 要不然程序会崩溃
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name =%@ AND age =%d",@"小明1",11];
    //查询返回的result 类似于数组类型,可以直接取count
    RLMResults *result = [PersonModel objectsWithPredicate:pre];
    //取出查询的表的数据
    PersonModel *person = result.firstObject;
    
//    NSLog(@"%d💕%@",person.carID,person.dogModel.name);
    
    
    //整体查询
    RLMResults *results = [PersonModel allObjects];
    NSLog(@"%lu",(unsigned long)results.count);
}
#pragma mark 改
-(void)changeData{
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name =%@ AND age =%d",@"小明2",12];
    RLMResults *result = [PersonModel objectsWithPredicate:pre];
    PersonModel *person = result.firstObject;
    
    [self.rl transactionWithBlock:^{
        //修改的时候只需把查找的数据更改就行,无需在初始化表
        person.name = @"小红";
        person.age = 20;
    }];
    
}
#pragma mark 删
-(void)deleteData{
    //弱引用
    __weak typeof(self) weakself = self;
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name =%@ AND age =%d",@"小明3",13];
    
    RLMResults *result = [PersonModel objectsWithPredicate:pre];
    
    PersonModel *person = result.firstObject;
    //删除条件查询的表中数据
//    [self.rl transactionWithBlock:^{
//        [weakself.rl deleteObject:person];
//    }];
    
    [self.rl transactionWithBlock:^{
        //删除realm数据库中所有表的所有数据(慎用)
        [weakself.rl deleteAllObjects];
    }];
}


#pragma mark  按钮点击方法
- (IBAction)buttoClick:(UIButton *)sender {
    if (sender.tag == 10) {//增
        [self addData];
    }else if (sender.tag == 11){//删
        [self deleteData];
    }else if (sender.tag == 12){//改
        [self changeData];
    }else if (sender.tag == 13){//查
        [self examineData];
    }
}

@end
