//
//  MessageAccompViewController.m
//  PhotoExpresso
//
//  Created by Laurine Baillet on 15/03/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import "MessageAccompViewController.h"
#import "AppDelegate.h"
#import "Tirage.h"
#import "Adresse.h"
#import "Constant.h"

@interface MessageAccompViewController ()

@property   AppDelegate*    delegate;

@end

@implementation MessageAccompViewController
//---------------------------------------------------------------------
#pragma mark - View life cycle Mehtods
//---------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(self.adresse.message != nil)
    {
        self.messageTextView.text = self.adresse.message;
    }
}
//---------------------------------------------------------------------
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setBackButton];
    [self setSaveButton];
}
//----------------------------------------------------------------------------
#pragma mark - navigation method
//----------------------------------------------------------------------------
- (void)setSaveButton
{
    UIImage* shoppingCart = [UIImage imageNamed:@"save"];
    UIBarButtonItem* save = [[UIBarButtonItem alloc] initWithImage:shoppingCart style:UIBarButtonItemStylePlain target:self action:@selector(saveMessage)];
    
    [save setTintColor:kOrange4Color];
    [self.navigationItem setRightBarButtonItem:save];
}
//----------------------------------------------------------------------------
- (void)saveMessage
{
    self.adresse.message = self.messageTextView.text;
    [self.tirage.adressesMA addObject:self.adresse];
    
    [self goBack];
}
@end
