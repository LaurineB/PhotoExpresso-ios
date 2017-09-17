//
//  NSString+Utils.m
//  PhotoExpresso
//
//  Created by lad-dev on 11/03/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import "NSString+Utils.h"

@class NSString;

@implementation NSString (Utils)

/// @brief determine if object is a NSString with length > 0
- (bool)isValidString
{
    if(self != nil && [self isKindOfClass:[NSString class]] && self.length > 0)
    {
        return true;
    }
        
    return false;
}

@end
