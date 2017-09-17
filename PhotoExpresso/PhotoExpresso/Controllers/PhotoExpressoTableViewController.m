//
//  PhotoExpressoTableViewController.m
//  PhotoExpresso
//
//  Created by lad-dev on 15/03/2017.
//  Copyright © 2017 Estiam. All rights reserved.
//

#import "PhotoExpressoTableViewController.h"
#import "TabBarViewController.h"

#import "Constant.h"

@interface PhotoExpressoTableViewController ()

@end

@implementation PhotoExpressoTableViewController


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
//---------------------------------------------------------------------
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
@end
