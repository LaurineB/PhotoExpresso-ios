//
//  AppDelegate.m
//  PhotoExpresso
//
//  Created by lad-dev on 23/11/2016.
//  Copyright © 2016 Laurine Baillet. All rights reserved.
//

#import "AppDelegate.h"
#import "Tirage.h"

#import "NSUserDefaults+NSUserDefaultsExtensions.h"

//#import "DataManager.h"
#import "PayPalMobile.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
// data manager method 
//    id data = [[DataManager sharedInstance] loadDataWithKey:@"PECart"];
//    if(data == nil || ![data isKindOfClass:[Panier class]])
//    {
//        self.panier = [[Panier alloc] init];
//
//    } else
//    {
//        self.panier = (Panier*)data;
//    }
    
//    nsUserDefault category method
    if([[NSUserDefaults standardUserDefaults] objectExistForKey:@"PECart"])
    {
        Panier* savedCart = (Panier*)[[NSUserDefaults standardUserDefaults] loadCustomObjectWithKey:@"PECart"];
        self.cartArray = [[NSMutableArray alloc] initWithArray:savedCart.cartArray];
    }
    else
    {
        self.cartArray = [[NSMutableArray alloc]init];
    }
//    test mode
//    self.cartArray = [[NSMutableArray alloc] init];
    
    self.totalCommande = 0.00;
    
#warning "Enter your credentials for Paypal Payment"
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"YOUR_CLIENT_ID_FOR_PRODUCTION",
                                                           PayPalEnvironmentSandbox : @"YOUR_CLIENT_ID_FOR_SANDBOX"}];
    
    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    // data manager method
//    [[DataManager sharedInstance] saveData:self.panier withKey:@"PECart"];
    
//    nsUserDefault category method
    Panier* cartToSave = [[Panier alloc] init];
    cartToSave.cartArray = [self.cartArray copy];
    [[NSUserDefaults standardUserDefaults] saveCustomObject:cartToSave key:@"PECart"];
    
}


//----------------------------------------------------------------------------
#pragma mark - Cart Methods
//----------------------------------------------------------------------------
/// @brief update the price of the order
- (void)updateTotalCommande
{
    float total = 0.0;
    
    for (Tirage *tirage in self.cartArray) {
        [tirage updateMontantTotal];
        total += tirage.montantTotal;
    }
    NSString* totalString2f = [NSString stringWithFormat:@"%.2f",total];
    self.totalCommande = [totalString2f floatValue];
}
//----------------------------------------------------------------------------
/// @brief reset the cart & commandeEnCours, use after payment complete
- (void)resetCart
{
    self.cartArray = [[NSMutableArray alloc] init];
    self.totalCommande = 0.0;
    self.commandeEnCours = [[Commande alloc] init];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"PECart"];
}
//---------------------------------------------------------------------
/// @brief return YES if all tirages have at least one Adresse
- (BOOL)allTiragesHaveAdresse
{
    BOOL retour = false;
    for (int c = 0; c < [self.cartArray count]; c ++) {
        Tirage* tirage = self.cartArray[c];
        if(tirage.adresses == nil || [tirage.adresses count] == 0)
        {
            retour = retour & false;
        }
    }
    return retour;
}
@end
