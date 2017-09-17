//
//  Tirage.h
//  PhotoExpresso
//
//  Created by laurine baillet on 02/02/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Filtre.h"
#import "Format.h"

@interface Tirage : NSObject <NSCoding>

@property   (strong,nonatomic)  UIImage*        photo;
@property   (strong,nonatomic)  Format*         format;
@property   (strong,nonatomic)  Filtre*         filtre;
@property   (nonatomic)         int             nbExemplairePhoto;
@property   (nonatomic)         float           montantTotal;
@property   (strong,nonatomic)  NSArray*        adresses;

//With custom message per Adresse, we need a NSMutableArray but for NSUserDefault save, we need NSArray, so we have the two ones
@property   (strong,nonatomic)  NSMutableArray* adressesMA;

/// @brief format + filtre * nbExemplaire
- (void)updateMontantTotal;

- (void)transferAdressesMAToAdresses;
@end
