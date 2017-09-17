//
//  NSDictionnary+Utils.m
//  PhotoExpresso
//
//  Created by lad-dev on 11/03/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import "NSDictionnary+Utils.h"
#import "NSString+Utils.h"

@implementation NSDictionary (Utils)

/// @brief check if NSDictionnary objects not nil
/// @return YES if check success
- (BOOL)isValidDictionary
{
    if(self != nil && [self isKindOfClass:[NSDictionary class]])
    {
        NSArray* keys = [self allKeys];
        
        for (int i = 0; i < [keys count]; i++) {
           if(![self objectForKey:keys[i]])
           {
               return false;
           }
        }
    }
    return true;
}
//---------------------------------------------------------------------
/// @brief if objectforkey == nil return empty string
/// @param aKey key/index of NSDictionnary
/// @return object or empty string
- (NSString*)stringForKey:(NSString*)aKey
{
    if([self isValidDictionary] && [aKey isValidString])
    {
        NSString* object = [self objectForKey:aKey];
        if(object != nil)
            return object;
    }
    return @"";
}
@end
