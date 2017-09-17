//
//  AppDelegate.h
//  PhotoExpresso
//
//  Created by lad-dev on 23/11/2016.
//  Copyright © 2016 Laurine Baillet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Panier.h"
#import "Commande.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic)   UIWindow*           window;
@property (strong,nonatomic)    NSMutableArray*     cartArray;
@property (nonatomic)           float               totalCommande;
@property (strong, nonatomic)   Commande*           commandeEnCours;

//----------------------------------------------------------------------------
#pragma mark - Cart Methods
//----------------------------------------------------------------------------
/// @brief update the price of the order
- (void)updateTotalCommande;
/// @brief reset the cart & commandeEnCours, use after payment complete
- (void)resetCart;
/// @brief return YES if all tirages have at least one Adresse
- (BOOL)allTiragesHaveAdresse;
@end

