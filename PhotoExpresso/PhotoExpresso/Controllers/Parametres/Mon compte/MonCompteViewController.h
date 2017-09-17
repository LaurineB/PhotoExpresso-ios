//
//  MonCompteViewController.h
//  PhotoExpresso
//
//  Created by laurine baillet on 05/12/2016.
//  Copyright © 2016 Laurine Baillet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoExpressoViewController.h"
@import SafariServices;

@interface MonCompteViewController : PhotoExpressoViewController

@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmationTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end
