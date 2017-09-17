//
//  PhotoExpressoViewController.m
//  PhotoExpresso
//
//  Created by Laurine Baillet on 15/03/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import "PhotoExpressoViewController.h"
#import "TabBarViewController.h"
#import "CommandeTableViewController.h"

#import "Constant.h"

@interface PhotoExpressoViewController ()

@end

@implementation PhotoExpressoViewController

//---------------------------------------------------------------------
#pragma mark - Memory Methods
//---------------------------------------------------------------------
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//----------------------------------------------------------------------------
#pragma mark - Navigation methods
//----------------------------------------------------------------------------
- (void)setBackButton
{
    UIImage* arrowLeft = [UIImage imageNamed:@"arrowLeft"];
    UIBarButtonItem* backBarButton = [[UIBarButtonItem alloc] initWithImage:arrowLeft style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [backBarButton setTintColor:kOrange4Color];
    
    [[self navigationItem] setLeftBarButtonItem:backBarButton];
}
//---------------------------------------------------------------------
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
//----------------------------------------------------------------------------
- (void)setHomeButton
{
    UIImage* home = [UIImage imageNamed:@"home"];
    UIBarButtonItem* leftBarButton = [[UIBarButtonItem alloc] initWithImage:home style:UIBarButtonItemStylePlain target:self action:@selector(goToMainPage)];
    [leftBarButton setTintColor:kOrange4Color];
    
    [[self navigationItem] setLeftBarButtonItem:leftBarButton];
    
}
//----------------------------------------------------------------------------
- (void)goToMainPage
{
    TabBarViewController* tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"tabBarVC"];
    [self.navigationController pushViewController:tabBarVC animated:YES];
}
//---------------------------------------------------------------------
- (void)setShoppingCartButton
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultTirageKey] != nil)
    {
        UIImage* shoppingCart = [UIImage imageNamed:@"shoppingCart"];
        UIBarButtonItem* SCBarButton = [[UIBarButtonItem alloc] initWithImage:shoppingCart style:UIBarButtonItemStylePlain target:self action:@selector(goToCart)];
        
        [SCBarButton setTintColor:kOrange4Color];
        [self.navigationItem setRightBarButtonItem:SCBarButton];
    }
}
//---------------------------------------------------------------------
- (void)goToCart
{
    CommandeTableViewController* commandeVC = [[CommandeTableViewController alloc] init];
    [self.navigationController pushViewController:commandeVC animated:YES];
}

@end
