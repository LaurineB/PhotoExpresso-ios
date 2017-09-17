//
//  PhotoExpressoTableViewController.h
//  PhotoExpresso
//
//  Created by lad-dev on 15/03/2017.
//  Copyright © 2017 Estiam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoExpressoTableViewController : UITableViewController
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

@end
