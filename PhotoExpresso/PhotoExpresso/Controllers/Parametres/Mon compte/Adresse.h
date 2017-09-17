//
//  Adresse.h
//  PhotoExpresso
//
//  Created by laurine baillet on 05/12/2016.
//  Copyright © 2016 Laurine Baillet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Adresse : NSObject

@property   NSString*   intitule;
@property   NSString*   prenom;
@property   NSString*   nom;
@property   NSString*   adresse1;
@property   NSString*   adresse2;
@property   NSString*   codePostal;
@property   NSString*   ville;
@property   NSString*   pays;
@property   NSString*   message;

- (void)configureWithIntitule:(NSString*)intitule andNom:(NSString*)nom andPrenom:(NSString*)prenom andAdresse1:(NSString*)adresse1 andAdresse2:(NSString*)adresse2 andCode:(NSString*)code andVille:(NSString*)ville andPays:(NSString*)pays;


@end
