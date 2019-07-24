//
//  AppDelegate.m
//  RealmDemo
//
//  Created by mm on 2019/7/24.
//  Copyright © 2019 mm. All rights reserved.
//

#import "AppDelegate.h"
#import <Realm/Realm.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //获取默认配置,迁移数据库
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    
    //    config.fileURL = [NSURL URLWithString:filePath];
    
    //    config.readOnly = NO;
    
    //设置新的版本架构,这个版本必须高于之前设置过得版本(如果以前未设置过,则设为0)
    int newVersion = 0;
    
    config.schemaVersion = newVersion;
    
    //这个 block 会在打开低于上面所设置的本号的 Realm数据库时自动调用
    [config setMigrationBlock:^(RLMMigration * _Nonnull migration, uint64_t oldSchemaVersion) {
        
        if (oldSchemaVersion <newVersion) {
            
            /*
             数据结构会自动进行迁移
             */
            
            if (oldSchemaVersion < 1) {
                
                // 什么都不要做！Realm 会自行检测新增和需要移除的属性，然后自动更新硬盘上的数据库架构
                
            }
            
        }
        
    }];
    
    
    //告诉 Realm为默认 Realm数据库使用这个新的配置对象
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    //让 Realm自动执行迁移
    [RLMRealm defaultRealm];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    NSLog(@"%@",realm.configuration.fileURL);
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
