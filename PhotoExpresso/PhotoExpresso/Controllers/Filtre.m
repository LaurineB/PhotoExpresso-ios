//
//  Filtre.m
//  PhotoExpresso
//
//  Created by laurine baillet on 02/02/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import "Filtre.h"

@implementation Filtre

//---------------------------------------------------------------------
#pragma mark - NSCoding delegate methods
//---------------------------------------------------------------------

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.idFiltre = [decoder decodeIntForKey:@"PEFiltreId"];
        self.intitule = [decoder decodeObjectForKey:@"PEFiltreIntitule"];
        self.tarif = [decoder decodeFloatForKey:@"PEFiltreTarif"];
    }
    return self;
}
//---------------------------------------------------------------------
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt:self.idFiltre forKey:@"PEFiltreId"];
    [encoder encodeObject:self.intitule forKey:@"PEFiltreIntitule"];
    [encoder encodeFloat:self.tarif forKey:@"PEFiltreTarif"];
}

@end
