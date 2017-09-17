//
//  Adresse.m
//  PhotoExpresso
//
//  Created by laurine baillet on 05/12/2016.
//  Copyright © 2016 Laurine Baillet. All rights reserved.
//

#import "Adresse.h"

@implementation Adresse

- (void)configureWithIntitule:(NSString*)intitule andNom:(NSString*)nom andPrenom:(NSString*)prenom andAdresse1:(NSString*)adresse1 andAdresse2:(NSString*)adresse2 andCode:(NSString*)code andVille:(NSString*)ville andPays:(NSString*)pays
{
    self.intitule = intitule;
    self.nom = nom;
    self.prenom = prenom;
    self.adresse1 = adresse1;
    self.adresse2 = adresse2;
    self.codePostal = code;
    self.ville = ville;
    self.pays = pays;
    self.message = @"";
}


@end
