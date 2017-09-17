//
//  NSUserDefaults+NSUserDefaultsExtensions.h
//  PhotoExpresso
//
//  Created by Laurine Baillet on 15/03/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (NSUserDefaultsExtensions)

- (void)saveCustomObject:(id<NSCoding>)object
                     key:(NSString *)key;
- (id<NSCoding>)loadCustomObjectWithKey:(NSString *)key;

/// @brief return YES is key exist
- (BOOL)objectExistForKey:(NSString*)key;
@end
