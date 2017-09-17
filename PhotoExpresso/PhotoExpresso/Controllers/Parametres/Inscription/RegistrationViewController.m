//
//  RegistrationViewController.m
//  PhotoExpresso
//
//  Created by laurine baillet on 30/11/2016.
//  Copyright © 2016 Laurine Baillet. All rights reserved.
//

#import "RegistrationViewController.h"
#import "Constant.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController

//----------------------------------------------------------------------------
#pragma mark - View LifeCyle Methods
//----------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//----------------------------------------------------------------------------
-(void)viewWillAppear:(BOOL)animated{
    [self setBackButton];
    [super viewWillAppear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//----------------------------------------------------------------------------
#pragma mark - Button Action
//----------------------------------------------------------------------------
- (IBAction)ClickOnSubscribe:(id)sender {
    
    if([self verifyAllInformationsSet])
    {
        [self makeArrayAndSend];
        [self registerInUserDefault];
    }
}
//----------------------------------------------------------------------------
#pragma mark - Utils Methods
//----------------------------------------------------------------------------
- (BOOL)verifyAllInformationsSet
{
    if(self.firstnameTextField.text != nil &&
       self.nameTextField.text != nil &&
       self.mailTextField != nil &&
       self.passwordTextField.text != nil &&
       self.confirmationPasswordTextField.text != nil)
    {
        if([self.passwordTextField.text compare:self.confirmationPasswordTextField.text] == NSOrderedSame)
        {
            return true;
        }
        else {
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Erreur" message:@"La confirmation ne correspond pas" preferredStyle:UIAlertControllerStyleAlert];
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
- (void)registerInUserDefault
{
    NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:self.nameTextField.text forKey:kUserDefaultName];
    [prefs setObject:self.firstnameTextField.text forKey:kUserDefaultFirstname];
    [prefs setObject:self.mailTextField.text forKey:kUserDefaultEmail];
    [prefs setObject:self.passwordTextField.text forKey:kUserDefaultPassword];
}
//----------------------------------------------------------------------------
#pragma mark - Json Methods
//----------------------------------------------------------------------------

- (void)makeArrayAndSend
{
    NSArray* arrayToSend = [[NSArray alloc] init];
    
    [arrayToSend setValue:self.firstnameTextField.text forKey:@"firstname"];
    [arrayToSend setValue:self.nameTextField.text forKey:@"name"];
    [arrayToSend setValue:self.mailTextField.text forKey:@"mail"];
    [arrayToSend setValue:self.passwordTextField.text forKey:@"password"];
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:arrayToSend options:NSJSONWritingPrettyPrinted error:nil];
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    //TODO : send jsonString
}

@end
