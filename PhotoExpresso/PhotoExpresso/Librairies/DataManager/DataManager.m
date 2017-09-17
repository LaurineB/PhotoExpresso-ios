//
//  DataManager.m
//  DataStore
//
//  Created by odile bellerose on 13/03/2017.
//  Copyright © 2017 odile bellerose. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

+ (id)sharedInstance {
    static DataManager *sharedDataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataManager = [[self alloc] init];
    });
    return sharedDataManager;
}

- (void)saveData:(id)data withKey:(NSString*)key{
    NSData *dataToSave = [NSKeyedArchiver archivedDataWithRootObject:data];
    [[NSUserDefaults standardUserDefaults] setObject:dataToSave forKey:key];
}

- (id) loadDataWithKey:(NSString*)key{
    NSData *datas = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    id object = [NSKeyedUnarchiver unarchiveObjectWithData:datas];
    
    return object;
}
@end
