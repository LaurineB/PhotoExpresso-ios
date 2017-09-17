//
//  TabBarViewController.m
//  PhotoExpresso
//
//  Created by laurine baillet on 20/02/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import "TabBarViewController.h"
#import "CommandeTableViewController.h"
#import "RegistrationViewController.h"

#import "AppDelegate.h"

#import "Constant.h"
@interface TabBarViewController ()

@property   AppDelegate*    delegate;

@end

@implementation TabBarViewController

@synthesize delegate;
//----------------------------------------------------------------------------
#pragma mark - Life cycle Methods
//----------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [self.delegate updateTotalCommande];
    
    //Design
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : kOrange5Color}];
}
//----------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;
    [self setShoppingCartButton];
    
    
    self.navigationItem.title = [NSString stringWithFormat:@"%.2f€",self.delegate.totalCommande];
    
    [super viewWillAppear:animated];
}
//----------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//----------------------------------------------------------------------------
#pragma mark - Navigation
//----------------------------------------------------------------------------
-(void)setShoppingCartButton
{

    UIImage* addSC = [UIImage imageNamed:@"shoppingCart"];
    UIBarButtonItem* rightBarButton = [[UIBarButtonItem alloc] initWithImage:addSC style:UIBarButtonItemStylePlain target:self action:@selector(goToCart)];
    [rightBarButton setTintColor:kOrange4Color];
    
    [[self navigationItem] setRightBarButtonItem:rightBarButton];
    
}

//----------------------------------------------------------------------------
- (void)goToCart
{
    if(![[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultName])
    {
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Oups" message:@"Pour aller plus loin, vous devez vous inscrire" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction* action){
                                                       [alertController dismissViewControllerAnimated:YES completion:nil];
                                                       
                                                       RegistrationViewController* registerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"registerVC"];
                                                       
                                                       [self.navigationController pushViewController:registerVC animated:YES];
                                                   }];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }

    CommandeTableViewController* commandeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"commandeVC"];
    [self.navigationController pushViewController:commandeVC animated:YES];
}
//----------------------------------------------------------------------------
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
