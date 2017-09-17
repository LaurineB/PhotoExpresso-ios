//
//  LoginViewController.m
//  PhotoExpresso
//
//  Created by lad-dev on 23/11/2016.
//  Copyright © 2016 Laurine Baillet. All rights reserved.
//

#import "LoginViewController.h"
#import "TabBarViewController.h"

//POD
#import "JSONKit.h"
#import <SVProgressHUD.h>

#import "Constant.h"

@interface LoginViewController ()

@property   (retain,nonatomic)  NSURLConnection*    connection;
@property   (retain, nonatomic) NSMutableData       *receivedData;
@property                       BOOL                test;
@property                       BOOL                shouldPerformSegue;
@end

@implementation LoginViewController

//----------------------------------------------------------------------------
#pragma mark - View LifeCycle Methods
//----------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[self navigationController] setNavigationBarHidden:NO];
    
    // Actionner les tests
    self.test = TRUE;
    self.infoView.hidden = YES;
    
   }
//----------------------------------------------------------------------------
-(void)viewWillAppear:(BOOL)animated{
    UIImage* arrowLeft = [UIImage imageNamed:@"arrowLeft"];
    UIBarButtonItem* backBarButton = [[UIBarButtonItem alloc] initWithImage:arrowLeft style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [backBarButton setTintColor:kOrange4Color];
    
    [[self navigationItem] setLeftBarButtonItem:backBarButton];
    
    [super viewWillAppear:animated];
}
//----------------------------------------------------------------------------
#pragma mark - Button Action
//----------------------------------------------------------------------------

- (IBAction)goToRegistration:(id)sender {
    self.shouldPerformSegue = YES;
    
}

//----------------------------------------------------------------------------
- (IBAction)clickOnConnect:(id)sender {
    
    [SVProgressHUD setStatus:@"chargement"];
    
    NSString* email         = self.mailTextField.text;
    NSString* password      = self.passwordTextField.text;
    NSDictionary* result    = [[NSDictionary alloc] init];
    UIAlertController* alert = [[UIAlertController alloc] init];
    
    if([email isEqualToString:@""] && [password isEqualToString:@""])
    {
        alert = [UIAlertController alertControllerWithTitle:@"C'est embêtant :/" message:@"Vous n'avez rien écrit" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];

        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];

    }
    
    if(self.test) // Test Mode
    {
        // what kind of test?
        if([email isEqualToString:@"success"])
        {
            result = [self getLocalJsonSuccess];
            // sauvegarde le nom utilisateur
            [[NSUserDefaults standardUserDefaults] setObject:@"Judas" forKey:kUserDefaultFirstname];
            [[NSUserDefaults standardUserDefaults] setObject:@"Bricot" forKey:kUserDefaultName];
            [[NSUserDefaults standardUserDefaults] setObject:@"mail" forKey:kUserDefaultEmail];
            [[NSUserDefaults standardUserDefaults] setObject:@"password" forKey:kUserDefaultPassword];
        }
        else if ([email isEqualToString:@"fail"])
        {
            if([password isEqualToString:@"true"]){
                result = [self getLocalJsonEmailFail];
            }
            else if([password isEqualToString:@"false"])
            {
                result = [self getLocalJsonPwdFail];
            }
        }
        NSLog(@"result : %@",result);
        // Success login
        if([[result objectForKey:@"response"] isEqualToString:@"true"])
        {
            self.shouldPerformSegue = YES;
        }
        // Fail login
        else if([[result objectForKey:@"response"] isEqualToString:@"false"])
        {
            if([[result objectForKey:@"type"] isEqualToString:@"email"])
            {
                 alert = [UIAlertController alertControllerWithTitle:@"C'est embêtant :/" message:@"Votre email est invalide" preferredStyle:UIAlertControllerStyleAlert];
            }
            else if([[result objectForKey:@"type"] isEqualToString:@"password"])
            {
                 alert = [UIAlertController alertControllerWithTitle:@"C'est embêtant :/" message:@"Votre mot de passe est invalide" preferredStyle:UIAlertControllerStyleAlert];
            }
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * action) {}];
            [alert addAction:defaultAction];
            self.shouldPerformSegue = NO;
            [self shouldPerformSegueWithIdentifier:@"loginSegue" sender:sender];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        
    }
    else
    {
        ///////
        //    POST METHOD
        ///////
        //    Set post string with actual username and password.
        NSString *post = [NSString stringWithFormat:@"email=%@&password=%@",email,password];
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        
        //    Create a Urlrequest with all the properties like HTTP method, http header field with length of the post string
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        //    Set the Url for which your going to send the data to that request
        [request setURL:[NSURL URLWithString:kUrl_api]];
        
        //    Now, set HTTP method (POST or GET).
        [request setHTTPMethod:@"POST"];
        
        //    Set HTTP header field with length of the post data. Also set the Encoded value for HTTP header Field.
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        //    Set the HTTPBody of the urlrequest with postData
        [request setHTTPBody:postData];
        
        //    Now, create URLConnection object. Initialize it with the URLRequest
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        self.connection = connection;
        [connection cancel];
        
        //start the connection
        [connection start];
        
        if(connection) {
            NSLog(@"Connection Successful");
        } else {
            NSLog(@"Connection could not be made");
        }
        
        // success
        
        //To modify
        [[NSUserDefaults standardUserDefaults] setObject:@"Judas" forKey:kUserDefaultFirstname];
        [[NSUserDefaults standardUserDefaults] setObject:@"Bricot" forKey:kUserDefaultName];
        [[NSUserDefaults standardUserDefaults] setObject:@"password" forKey:kUserDefaultPassword];
    }
    
        [SVProgressHUD dismiss];
//        MenuLogViewController* menuNonLog = [[MenuLogViewController alloc] init];
//        [self.navigationController pushViewController:menuNonLog animated:YES];
}
//----------------------------------------------------------------------------
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    return self.shouldPerformSegue;
}
//----------------------------------------------------------------------------
#pragma mark - NSURLConnection delegate
//----------------------------------------------------------------------------

/*
 this method might be calling more than one times according to incoming data size
 */
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.receivedData appendData:data];
    
    NSLog(@"%@",self.receivedData);
}

//----------------------------------------------------------------------------
/*
 if there is an error occured, this method will be called by connection
 */
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"%@" , error);
}

//----------------------------------------------------------------------------
/*
 if data is successfully received, this method will be called by connection
 */
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    //initialize convert the received data to string with UTF8 encoding
    NSString *htmlSTR = [[NSString alloc] initWithData:self.receivedData
                                              encoding:NSUTF8StringEncoding];
    NSLog(@"%@" , htmlSTR);
    
    //show controller with navigation
    TabBarViewController* menuLog = [[TabBarViewController alloc] init];
    [self.navigationController pushViewController:menuLog animated:YES];

}

//----------------------------------------------------------------------------
#pragma mark - JSON Methods
//----------------------------------------------------------------------------

- (NSDictionary*)getLocalJsonSuccess
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"loginSuccess" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    
    NSDictionary *resultsDictionary = [jsonData objectFromJSONData];

    return resultsDictionary;
}
//----------------------------------------------------------------------------
- (NSDictionary*)getLocalJsonPwdFail
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"loginFailPwd" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    
    NSDictionary *resultsDictionary = [jsonData objectFromJSONData];
    
    return resultsDictionary;

}
//----------------------------------------------------------------------------
- (NSDictionary*)getLocalJsonEmailFail
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"loginFailMail" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    
    NSDictionary *resultsDictionary = [jsonData objectFromJSONData];
    
    return resultsDictionary;

}
//---------------------------------------------------------------------
#pragma mark - IB Action
//---------------------------------------------------------------------
- (IBAction)showInfoView:(id)sender {
    if([self.infoView isHidden])
    {
        self.infoView.hidden = NO;
    } else
    {
        self.infoView.hidden = YES;
    }
}

@end
