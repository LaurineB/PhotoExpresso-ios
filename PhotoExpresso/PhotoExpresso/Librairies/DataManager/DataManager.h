//
//  DataManager.h
//  DataStore
//
//  Created by odile bellerose on 13/03/2017.
//  Copyright © 2017 odile bellerose. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject
+ (id)sharedInstance;
- (id) loadDataWithKey:(NSString*)key;
- (void)saveData:(id)data withKey:(NSString*)key;
@end
