//
//  Panier.m
//  PhotoExpresso
//
//  Created by lad-dev on 13/03/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import "Panier.h"

@implementation Panier
//---------------------------------------------------------------------
#pragma mark - NSCoding delegate methods
//---------------------------------------------------------------------
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.cartArray = [decoder decodeObjectForKey:@"PECartArray"];
    }
    return self;
}
//---------------------------------------------------------------------
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.cartArray forKey:@"PECartArray"];
    
}

@end
