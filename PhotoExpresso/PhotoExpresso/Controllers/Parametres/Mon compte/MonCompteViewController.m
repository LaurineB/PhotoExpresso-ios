//
//  MonCompteViewController.m
//  PhotoExpresso
//
//  Created by laurine baillet on 05/12/2016.
//  Copyright © 2016 Laurine Baillet. All rights reserved.
//

#import "MonCompteViewController.h"
#import "Constant.h"
#import "NSString+Utils.h"

@interface MonCompteViewController ()

@end

@implementation MonCompteViewController
//----------------------------------------------------------------------------
#pragma mark - View LifeCyle Methods
//----------------------------------------------------------------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//----------------------------------------------------------------------------
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO];
    
    [super viewWillAppear:animated];
}
//----------------------------------------------------------------------------
#pragma mark - Button Action Method
//----------------------------------------------------------------------------
- (IBAction)changePassword:(id)sender {
    if([self verifyAllInformationsSetForPassword])
    {
        //prepare json
        NSDictionary* info = [[NSDictionary alloc] init];
        info = @{
                 @"password":self.passwordTextField.text
                 };
        
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:info options:NSJSONWritingPrettyPrinted error:nil];
        
        //prepare url
        
        NSString* urlString = [NSString stringWithFormat:@"%@/editPassword",kUrl_api];
        NSURL* url = [NSURL URLWithString:urlString];
        
        // send informations to server
        
    }
}
//----------------------------------------------------------------------------
- (IBAction)changeEmailAdress:(id)sender {
    if([self NSStringIsValidEmail:self.emailTextField.text])
    {
        //prepare json
        NSDictionary* info = [[NSDictionary alloc] init];
        info = @{
                 @"email":self.passwordTextField.text
                 };
        
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:info options:NSJSONWritingPrettyPrinted error:nil];

        //prepare url
        
        NSString* urlString = [NSString stringWithFormat:@"%@/editEmail",kUrl_api];
        NSURL* url = [NSURL URLWithString:urlString];

        // send informations to server

    }
}

//----------------------------------------------------------------------------
#pragma mark - Utils Methods
//----------------------------------------------------------------------------
- (BOOL)verifyAllInformationsSetForPassword
{
    // values != nil
    if(self.oldPasswordTextField.text != nil &&
       self.passwordConfirmationTextField.text != nil &&
       self.passwordTextField.text != nil)
    {
        // old pass == user password
        if([self.oldPasswordTextField.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultPassword]])
        {
            // new pass & confirmation equal
            if([self.passwordTextField.text compare:self.passwordConfirmationTextField.text] == NSOrderedSame)
            {
                return true;
            }
            else
            {
                UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Erreur" message:@"La confirmation ne correspond pas" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction* action){
                                                               [alertController dismissViewControllerAnimated:YES completion:nil];
                                                           }];
                [alertController addAction:ok];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
        else
        {
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Erreur" message:@"Ancien mot de passe incorrect" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction* action){
                                                           [alertController dismissViewControllerAnimated:YES completion:nil];
                                                       }];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
    return false;
}
//----------------------------------------------------------------------------
-(BOOL)NSStringIsValidEmail:(NSString *)checkString
{
    if([checkString isValidString])
    {
        BOOL stricterFilter = NO;
        NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
        NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
        NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        
        return [emailTest evaluateWithObject:checkString];
    }
    return false;
  }
//----------------------------------------------------------------------------
#pragma mark - Navigation
//----------------------------------------------------------------------------
- (IBAction)seDeconnecter:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultFirstname];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultName];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultEmail];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultPassword];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//---------------------------------------------------------------------
#pragma mark - IBAction
//---------------------------------------------------------------------
- (IBAction)goToContact:(id)sender {
    // normalement kUrl_Web mais serveur trop lent pour démo
    SFSafariViewController* safariVC = [[SFSafariViewController alloc] initWithURL:[[NSURL alloc] initWithString:kUrl_LaurineWebSite]];
    [self.navigationController pushViewController:safariVC animated:YES];
}
//---------------------------------------------------------------------


@end
