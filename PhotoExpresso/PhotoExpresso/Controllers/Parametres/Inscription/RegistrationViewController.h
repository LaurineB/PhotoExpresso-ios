//
//  RegistrationViewController.h
//  PhotoExpresso
//
//  Created by laurine baillet on 30/11/2016.
//  Copyright © 2016 Laurine Baillet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoExpressoViewController.h"

@interface RegistrationViewController : PhotoExpressoViewController

@property (weak, nonatomic) IBOutlet UITextField *firstnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmationPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *subscribeButton;

@end
