//
//  FraisPortTableViewController.m
//  PhotoExpresso
//
//  Created by laurine baillet on 15/03/2017.
//  Copyright © 2017 Estiam. All rights reserved.
//

#import "FraisPortTableViewController.h"
#import "FraisPortTableViewCell.h"
#import "PayViewController.h"
#import "Commande.h"
#import "AppDelegate.h"

#import "NSDictionnary+Utils.h"

#import "FraisPort.h"

#import "Constant.h"

@interface FraisPortTableViewController ()

@property   NSArray*            fraisPortArray;
@property   NSMutableArray*     fraisPortsObjectMA;
@property   FraisPort*          fraisPortSelected;
@property   int                 indexFraisPortSelected;
@property   AppDelegate*        delegate;

@end

@implementation FraisPortTableViewController
//---------------------------------------------------------------------
#pragma mark - Life Cycle Method
//---------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.indexFraisPortSelected = -1;
    self.fraisPortSelected = [[FraisPort alloc] init];
    self.fraisPortsObjectMA  = [[NSMutableArray alloc] init];
    
    [self parseLocalJson];
}
//----------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setBackButton];
    [self setPaymentButton];
    self.delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];

}
//----------------------------------------------------------------------------
#pragma mark - Table view data source
//----------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//----------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.fraisPortArray count];
}
//----------------------------------------------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FraisPortTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fraisPortCell" forIndexPath:indexPath];
    
    NSDictionary* fraisPortDict = self.fraisPortArray[indexPath.row];
    
    FraisPort* fraisPort = [self makeFraisPortWithDictionnary:fraisPortDict];
    
    // Configure the cell...
    cell.intituleLabel.text = fraisPort.intitule;
    cell.priceLabel.text =  [NSString stringWithFormat:@"%.2f €",fraisPort.prix];
    
    if((int)indexPath.row == self.indexFraisPortSelected)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}
//----------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.indexFraisPortSelected = (int)indexPath.row;

    self.fraisPortSelected = (FraisPort*)[self.fraisPortsObjectMA objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    [tableView reloadData];

}

//----------------------------------------------------------------------------
# pragma mark - parse JSON
//----------------------------------------------------------------------------
- (void)parseLocalJson
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"fraisPort" ofType:@"json"]; // A changer pour recupération sur serveur
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    
    self.fraisPortArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    
    NSLog(@"%@",self.fraisPortArray);
}
//----------------------------------------------------------------------------
#pragma mark - Data Methods
//----------------------------------------------------------------------------
- (FraisPort*)makeFraisPortWithDictionnary:(NSDictionary*)dico
{
    if([dico isValidDictionary])
    {
        FraisPort* fraisPort = [[FraisPort alloc] init];
        fraisPort.intitule = [dico stringForKey:@"intitule"];
        fraisPort.prix = [[dico objectForKey:@"prix"] floatValue];
        fraisPort.idFraisPort = [[dico objectForKey:@"id"] intValue];
        
        [self.fraisPortsObjectMA addObject:fraisPort];
        
        return fraisPort;
    }
    return [[FraisPort alloc] init];
}
//----------------------------------------------------------------------------
- (void)makeCommande
{
    Commande* commande = [[Commande alloc] init];
    commande.statut = @"en cours";
    commande.tirageList = self.delegate.cartArray;
    commande.fraisPort = self.fraisPortSelected;
    commande.montantTotal = self.delegate.totalCommande;
    
    // send Commande to server to make a numero & get Date
//    commande.numero = numero get from server
//    commande.date = date from server
    commande.numero = @"1234"; // for test
    
     self.delegate.commandeEnCours = commande;
}
//----------------------------------------------------------------------------
#pragma mark - Navigation
//----------------------------------------------------------------------------
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//----------------------------------------------------------------------------
- (void)setPaymentButton
{
    UIImage* payment = [UIImage imageNamed:@"payment"];
    UIBarButtonItem* rightBarButton = [[UIBarButtonItem alloc] initWithImage:payment style:UIBarButtonItemStylePlain target:self action:@selector(goToPayment)];
    [rightBarButton setTintColor:kGreen4Color];
    
    [[self navigationItem] setRightBarButtonItem:rightBarButton];
}
//----------------------------------------------------------------------------
- (void)goToPayment
{
    if(self.indexFraisPortSelected != -1)
    {
        [self makeCommande];
        
        PayViewController* payVC = [self.storyboard instantiateViewControllerWithIdentifier:@"payVC"];
        [self.navigationController pushViewController:payVC animated:YES];
    }
    else
    {
        UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"Oups" message:@"Vous n'avez pas choisi la méthode de livraison" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction* action)
                             {
                                 [alertController dismissViewControllerAnimated:YES completion:nil];
                             }];
        
        [alertController addAction:ok];
        
        
        [self presentViewController:alertController animated:YES completion:nil];

    }
    
}
@end
