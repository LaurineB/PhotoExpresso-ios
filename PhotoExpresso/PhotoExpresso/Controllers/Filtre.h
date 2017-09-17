//
//  Filtre.h
//  PhotoExpresso
//
//  Created by laurine baillet on 02/02/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Filtre : NSObject <NSCoding>

@property                       int         idFiltre;
@property   (strong,nonatomic)  NSString*   intitule;
@property   (nonatomic)         float       tarif;
@property   (nonatomic)         BOOL        actif;

@end
