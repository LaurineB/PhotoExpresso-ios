//
//  PhotoExpressoViewController.h
//  PhotoExpresso
//
//  Created by Laurine Baillet on 15/03/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoExpressoViewController : UIViewController

//---------------------------------------------------------------------
#pragma mark - Memory Methods
//---------------------------------------------------------------------
- (void)didReceiveMemoryWarning;

//----------------------------------------------------------------------------
#pragma mark - Navigation methods
//----------------------------------------------------------------------------
- (void)setBackButton;
- (void)goBack;
- (void)setHomeButton;
- (void)goToMainPage;
- (void)setShoppingCartButton;
- (void)goToCart;

@end
