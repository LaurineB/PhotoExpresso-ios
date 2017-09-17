//
//  PayViewController.m
//  PhotoExpresso
//
//  Created by laurine baillet on 22/02/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import "PayViewController.h"
#import "AppDelegate.h"
#import "TabBarViewController.h"

#import <QuartzCore/QuartzCore.h>
#import "NSDictionnary+Utils.h"
#import "Constant.h"
// Set the environment:
// - For live charges, use PayPalEnvironmentProduction (default).
// - To use the PayPal sandbox, use PayPalEnvironmentSandbox.
// - For testing, use PayPalEnvironmentNoNetwork.
#define kPayPalEnvironment PayPalEnvironmentNoNetwork

@interface PayViewController ()
@property(nonatomic, strong, readwrite) IBOutlet UIView *successView;
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;

@property   AppDelegate*    delegate;
@property   float           totalHtc;
@property   float           tva;
@property   float           totalTtc;
@end

@implementation PayViewController

//----------------------------------------------------------------------------
#pragma mark - Life cycle Methods
//----------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    //View config
    
    // passer les prix avec é chiffres après la virgule sinon payment not procesable
    self.totalHtc = self.delegate.commandeEnCours.montantTotal+self.delegate.commandeEnCours.fraisPort.prix;
    NSString* totalHtc2f = [NSString stringWithFormat:@"%.2f",self.totalHtc];
    self.totalHtc = [totalHtc2f floatValue];
    self.totalHtcLabel.text = [NSString stringWithFormat:@"%.2f€",self.totalHtc];
    
    self.tva = self.delegate.commandeEnCours.montantTotal*0.2;
    NSString* tva2f = [NSString stringWithFormat:@"%.2f",self.tva];
    self.tva = [tva2f floatValue];
    
    self.tvaLabel.text = [NSString stringWithFormat:@"%.2f€",self.tva];
    
    self.totalTtc = self.tva + self.totalHtc;
    self.totalttcLabel.text = [NSString stringWithFormat:@"%.2f€",self.totalTtc];
    
    self.fraisDePortLabel.text = [NSString stringWithFormat:@"%.2f€",self.delegate.commandeEnCours.fraisPort.prix];
    
    self.nbTiragesLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)[self.delegate.cartArray count]];
    
    // Set up payPalConfig
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = NO;
    _payPalConfig.merchantName = @"Photo Expresso";
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    self.successView.hidden = YES;
    
    // use default environment, should be Production in real life
    self.environment = kPayPalEnvironment;
    
}
//----------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    // Preconnect to PayPal early
    [self setPayPalEnvironment:self.environment];
    [self setBackButton];
}
//----------------------------------------------------------------------------
#pragma mark - config paypal
//----------------------------------------------------------------------------
- (void)setPayPalEnvironment:(NSString *)environment {
    self.environment = environment;
    [PayPalMobile preconnectWithEnvironment:environment];
}
//----------------------------------------------------------------------------
#pragma mark - Button Action Methods
//----------------------------------------------------------------------------
- (IBAction)payWithPaypal:(id)sender {
    // Remove our last completed payment, just for demo purposes.
    self.resultText = nil;
    
    NSDecimalNumber *total = [[NSDecimalNumber alloc] initWithFloat:self.totalHtc];
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = total;
    payment.currencyCode = @"EUR";
    payment.shortDescription = @"Photo Expresso";
    payment.items = nil;
    payment.paymentDetails = nil;

    if (!payment.processable) {
        // This particular payment will always be processable. If, for
        // example, the amount was negative or the shortDescription was
        // empty, this payment wouldn't be processable, and you'd want
        // to handle that here
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Erreur paypal" message:@"Quelque chose s'est mal passé" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction* action){
                                                       [alertController dismissViewControllerAnimated:YES completion:nil];
                                                   }];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                configuration:self.payPalConfig
                                                                                                     delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];

}
//----------------------------------------------------------------------------
#pragma mark - PayPalPaymentDelegate methods
//----------------------------------------------------------------------------
- (void)payPalFuturePaymentViewController:(PayPalFuturePaymentViewController *)futurePaymentViewController didAuthorizeFuturePayment:(NSDictionary *)futurePaymentAuthorization
{

}
//---------------------------------------------------------------------
-(void)payPalFuturePaymentDidCancel:(PayPalFuturePaymentViewController *)futurePaymentViewController
{
    
}
//---------------------------------------------------------------------
- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    self.resultText = [completedPayment description];
    [self showSuccess];
    
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:nil];
}
//---------------------------------------------------------------------
- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    self.resultText = nil;
    self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}
//----------------------------------------------------------------------------
#pragma mark Proof of payment validation
//----------------------------------------------------------------------------
- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    [self sendPaymentConfirmation:completedPayment.confirmation];
    
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
}
//----------------------------------------------------------------------------
#pragma mark PayPalProfileSharingDelegate methods
//----------------------------------------------------------------------------

- (void)payPalProfileSharingViewController:(PayPalProfileSharingViewController *)profileSharingViewController
             userDidLogInWithAuthorization:(NSDictionary *)profileSharingAuthorization {
    NSLog(@"PayPal Profile Sharing Authorization Success!");
    self.resultText = [profileSharingAuthorization description];
    [self showSuccess];
    
    [self sendProfileSharingAuthorizationToServer:profileSharingAuthorization];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//----------------------------------------------------------------------------
- (void)userDidCancelPayPalProfileSharingViewController:(PayPalProfileSharingViewController *)profileSharingViewController {
    NSLog(@"PayPal Profile Sharing Authorization Canceled");
    self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}
//----------------------------------------------------------------------------
- (void)sendProfileSharingAuthorizationToServer:(NSDictionary *)authorization {
    // TODO: Send authorization to server
    NSLog(@"Here is your authorization:\n\n%@\n\nSend this to your server to complete profile sharing setup.", authorization);
}
//----------------------------------------------------------------------------
#pragma mark - Helpers
//----------------------------------------------------------------------------
- (void)showSuccess {
    self.successView.hidden = NO;
    self.successView.alpha = 1.0f;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:2.0];
    self.successView.alpha = 0.0f;
    [UIView commitAnimations];
}
//----------------------------------------------------------------------------
#pragma mark - Flipside View Controller
//----------------------------------------------------------------------------
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"pushSettings"]) {
        [[segue destinationViewController] setDelegate:(id)self];
    }
}

//---------------------------------------------------------------------
#pragma mark - web Services Methods
//---------------------------------------------------------------------
- (void)sendPaymentConfirmation:(NSDictionary*)confirmation
{
    if(confirmation != nil && [confirmation isValidDictionary])
    {
        @try {
            NSData* jsonDataConfirmation = [NSJSONSerialization dataWithJSONObject:confirmation options:NSJSONWritingPrettyPrinted error:nil];
            NSString* jsonStringConfirmation = [[NSString alloc] initWithData:jsonDataConfirmation encoding:NSUTF8StringEncoding];
            
            NSArray* tirageArray = self.delegate.cartArray;
            NSData* jsonDataTirages = [NSJSONSerialization dataWithJSONObject:tirageArray options:NSJSONWritingPrettyPrinted error:nil];
            NSString* jsonStringTirages = [[NSString alloc] initWithData:jsonDataTirages encoding:NSUTF8StringEncoding];

        } @catch (NSException *exception) {
            NSLog(@"Send Payment confirmation error : %@", exception.description);
            
            UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"Erreur" message:@"Paiement non confirmé" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction* action)
                                 {
                                     [alertController dismissViewControllerAnimated:YES completion:nil];
                                 }];
            
            [alertController addAction:ok];
            
            
            [self presentViewController:alertController animated:YES completion:nil];

        } @finally {
            
            [self.delegate resetCart];
            TabBarViewController* tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"tabBarVC"];
            
            [self.navigationController pushViewController:tabBarVC animated:YES];
        }
        
        //TODO : send jsonStringConfirmation + tirages
    }
}
//---------------------------------------------------------------------
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
