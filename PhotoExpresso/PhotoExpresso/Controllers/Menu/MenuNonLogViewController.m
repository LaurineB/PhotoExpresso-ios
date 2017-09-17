//
//  MenuNonLogViewController.m
//  PhotoExpresso
//
//  Created by lad-dev on 23/11/2016.
//  Copyright © 2016 Laurine Baillet. All rights reserved.
//

#import "MenuNonLogViewController.h"

#import "TabBarViewController.h"

#import "Constant.h"

@interface MenuNonLogViewController ()

@end

@implementation MenuNonLogViewController
//----------------------------------------------------------------------------
#pragma mark - View LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // if already connected
    if([[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultFirstname])
    {
        TabBarViewController* tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"tabBarVC"];
        [self.navigationController pushViewController:tabBarVC animated:YES];
    }
    self.background.image = [UIImage imageNamed:@"MainPageBackground"];
}
//----------------------------------------------------------------------------
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];

    [super viewWillAppear:animated];
}

@end
