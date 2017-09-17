//
//  NSDictionnary+Utils.h
//  PhotoExpresso
//
//  Created by lad-dev on 11/03/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSDictionary;

@interface NSDictionary (Utils)

/// @brief check if NSDictionnary objects not nil
/// @return YES if check success
- (BOOL)isValidDictionary;

/// @brief if objectforkey == nil return empty string
/// @param aKey key/index of NSDictionnary
/// @return object or empty string
- (NSString*)stringForKey:(NSString*)aKey;

@end
