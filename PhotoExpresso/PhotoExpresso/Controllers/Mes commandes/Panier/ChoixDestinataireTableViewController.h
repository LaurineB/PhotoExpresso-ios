//
//  ChoixDestinataireTableViewController.h
//  PhotoExpresso
//
//  Created by Laurine Baillet on 22/02/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tirage.h"
#import "PhotoExpressoTableViewController.h"

@interface ChoixDestinataireTableViewController : PhotoExpressoTableViewController

// Array of Adresse object from adresseArray
@property   (nonatomic) NSMutableArray*     adressesObjectMA;
// Array of Adresse object selected in choixDestinataireTVC
@property   (nonatomic) NSMutableArray*     adressesSelectedMA;

// Tirage we retreive/selected from/in commande TVC
@property   (nonatomic) Tirage*             tirage;

@end
