//
//  LoginViewController.h
//  PhotoExpresso
//
//  Created by lad-dev on 23/11/2016.
//  Copyright © 2016 Laurine Baillet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoExpressoViewController.h"

@interface LoginViewController : PhotoExpressoViewController

@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UIView *infoView;

@end
