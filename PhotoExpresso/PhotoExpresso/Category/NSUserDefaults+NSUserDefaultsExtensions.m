//
//  NSUserDefaults+NSUserDefaultsExtensions.m
//  PhotoExpresso
//
//  Created by Laurine Baillet on 15/03/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import "NSUserDefaults+NSUserDefaultsExtensions.h"

@implementation NSUserDefaults (NSUserDefaultsExtensions)

- (void)saveCustomObject:(id<NSCoding>)object
                     key:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    [self setObject:encodedObject forKey:key];
    [self synchronize];
    
}
//----------------------------------------------------------------------------
- (id<NSCoding>)loadCustomObjectWithKey:(NSString *)key {
    NSData *encodedObject = [self objectForKey:key];
    id<NSCoding> object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}
//----------------------------------------------------------------------------
/// @brief return YES is key exist
- (BOOL)objectExistForKey:(NSString*)key
{
    if([self objectForKey:key])
    {
        return true;
    } else {
        return false;
    }
}
@end
