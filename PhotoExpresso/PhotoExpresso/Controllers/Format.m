//
//  Format.m
//  PhotoExpresso
//
//  Created by laurine baillet on 02/02/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import "Format.h"

@implementation Format
//---------------------------------------------------------------------
#pragma mark - NSCoding delegate methods
//---------------------------------------------------------------------
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.idFormat = [decoder decodeIntForKey:@"PEFormatId"];
        self.intitule = [decoder decodeObjectForKey:@"PEFormatIntitule"];
        self.tarif = [decoder decodeFloatForKey:@"PEFormatTarif"];
        self.width = [decoder decodeFloatForKey:@"PEFormatWidth"];
        self.length = [decoder decodeFloatForKey:@"PEFormatLength"];
    }
    return self;
}
//---------------------------------------------------------------------
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt:self.idFormat forKey:@"PEFormatId"];
    [encoder encodeObject:self.intitule forKey:@"PEFormatIntitule"];
    [encoder encodeFloat:self.tarif forKey:@"PEFormatTarif"];
    [encoder encodeFloat:self.width forKey:@"PEFormatWidth"];
    [encoder encodeFloat:self.length forKey:@"PEFormatLength"];
}

@end
