//
//  MCANewAdresseViewController.m
//  PhotoExpresso
//
//  Created by laurine baillet on 20/02/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import "MCANewAdresseViewController.h"

#import "Constant.h"

@interface MCANewAdresseViewController ()

@end

@implementation MCANewAdresseViewController

//----------------------------------------------------------------------------
#pragma mark - Life Cycle Methods
//----------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//----------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setBackButton];
    self.navigationItem.title = @"Ajouter un contact";
    self.navigationController.navigationBar.tintColor = kOrange5Color;
}
//----------------------------------------------------------------------------
#pragma mark - Action Button Methods
//----------------------------------------------------------------------------
- (IBAction)registerContact:(id)sender {
    //TODO : prepare Json
}
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
