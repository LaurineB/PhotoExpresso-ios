//
//  Tirage.m
//  PhotoExpresso
//
//  Created by laurine baillet on 02/02/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import "Tirage.h"

@implementation Tirage

//---------------------------------------------------------------------
#pragma mark - NSCoding delegate methods
//---------------------------------------------------------------------
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.photo = [decoder decodeObjectForKey:@"PETiragePhoto"];
        self.format = [decoder decodeObjectForKey:@"PETirageFormat"];
        self.filtre = [decoder decodeObjectForKey:@"PETirageFiltre"];
        self.nbExemplairePhoto = [decoder decodeIntForKey:@"PETirageExemplaire"];
        self.montantTotal = [decoder decodeFloatForKey:@"PETirageMontant"];
        self.adresses = [decoder decodeObjectForKey:@"PETirageAdresses"];
        self.adressesMA = [decoder decodeObjectForKey:@"PETirageAdressesMA"];
    }
    return self;
}
//---------------------------------------------------------------------
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.photo forKey:@"PETiragePhoto"];
    [encoder encodeObject:self.format forKey:@"PETirageFormat"];
    [encoder encodeObject:self.filtre forKey:@"PETirageFiltre"];
    [encoder encodeInt:self.nbExemplairePhoto forKey:@"PETirageExemplaire"];
    [encoder encodeFloat:self.montantTotal forKey:@"PETirageMontant"];
    [encoder encodeObject:self.adresses forKey:@"PETirageAdresses"];
    [encoder encodeObject:self.adressesMA forKey:@"PETirageAdressesMA"];
}
//---------------------------------------------------------------------
#pragma mark - Initialization Method
//---------------------------------------------------------------------
- (instancetype)init
{
    self = [super init];

    self.adresses = [[NSArray alloc] init];
    self.adressesMA = [[NSMutableArray alloc] init];
    
    return self;
}
//---------------------------------------------------------------------
#pragma mark - Utils
//---------------------------------------------------------------------
/// @brief format + filtre * nbExemplaire
- (void)updateMontantTotal
{
    float nbAdresses = (float)[self.adresses count];
    if(nbAdresses == 0.0)
        nbAdresses = 1.0;
    
    self.montantTotal = (_format.tarif + _filtre.tarif) * _nbExemplairePhoto * nbAdresses;
}
//---------------------------------------------------------------------
- (void)transferAdressesMAToAdresses
{
    self.adresses = [self.adressesMA copy];
}

@end
