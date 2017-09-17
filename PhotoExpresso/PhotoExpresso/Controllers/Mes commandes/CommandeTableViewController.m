//
//  CommandeViewController.m
//  PhotoExpresso
//
//  Created by laurine baillet on 13/12/2016.
//  Copyright © 2016 Laurine Baillet. All rights reserved.
//

#import "CommandeTableViewController.h"

#import "RegistrationViewController.h"
#import "CommandeTableViewCell.h"
#import "PayViewController.h"
#import "ChoixDestinataireTableViewController.h"
#import "FraisPortTableViewController.h"
#import "RegistrationViewController.h"

#import "AppDelegate.h"

#import "Tirage.h"

#import "Constant.h"
//----------------------------------------------------------------------------
@interface CommandeTableViewController ()

@property   AppDelegate*    delegate;
@property   Tirage*         tirage;
@end

@implementation CommandeTableViewController
//----------------------------------------------------------------------------
#pragma mark - View Life Cycle
//----------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Data
    self.delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
}
//----------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultFirstname])
        [self setHomeButton];
    else
    {
        [self setBackButton];
    }
    
//    [self setPaymentButton];
    [self setNextButton];
    
    [self updateTotal];
    
    [super viewWillAppear:animated];
    
}
//----------------------------------------------------------------------------
#pragma mark - Button Methods
//----------------------------------------------------------------------------

- (IBAction)addButtonClicked:(UIButton *)sender {
    Tirage* tirage = self.delegate.cartArray[sender.tag];
    
    tirage.nbExemplairePhoto += 1;
    
    [tirage updateMontantTotal];
    
    [self updateTotal];
    
    [self.tableView reloadData];
}
//----------------------------------------------------------------------------
- (IBAction)removeButtonClicked:(UIButton *)sender {
    Tirage* tirage = self.delegate.cartArray[sender.tag];
    
    if(tirage.nbExemplairePhoto > 1)
        tirage.nbExemplairePhoto -= 1;
    
    [tirage updateMontantTotal];
    
    [self updateTotal];
    
    [self.tableView reloadData];
}


//----------------------------------------------------------------------------
#pragma mark - Table view data source
//----------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommandeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commandeCell" forIndexPath:indexPath];
    
    self.tirage = self.delegate.cartArray[indexPath.row];
    
    if(self.tirage.nbExemplairePhoto == 0)
    {
        [self.delegate.cartArray removeObject:self.tirage];
        [tableView reloadData];
    }
    
    // Configure the cell...
    cell.photoImageView.image = self.tirage.photo;
    cell.nbTirageLabel.text = [NSString stringWithFormat:@"%i",self.tirage.nbExemplairePhoto];
    cell.addButton.tag = indexPath.row;
    cell.removeButton.tag = indexPath.row;
    
    return cell;
}
//----------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//----------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.delegate.cartArray count];
}
//----------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChoixDestinataireTableViewController* choixDestinataireTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"choixDestinataireVC"];
    choixDestinataireTVC.tirage = self.tirage;
        
    [self.navigationController pushViewController:choixDestinataireTVC animated:YES];
}
//----------------------------------------------------------------------------
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//----------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self deleteTirageFromCartAtIndex:(int)indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}
//----------------------------------------------------------------------------
#pragma mark - Navigation
//----------------------------------------------------------------------------
- (void)setNextButton
{
    UIImage* arrowRight = [UIImage imageNamed:@"arrowRight"];
    UIBarButtonItem* nextButton = [[UIBarButtonItem alloc] initWithImage:arrowRight style:UIBarButtonItemStylePlain target:self action:@selector(goToFraisPort)];
    [nextButton setTintColor:kOrange4Color];
    [[self navigationItem] setRightBarButtonItem:nextButton];
}
//----------------------------------------------------------------------------
- (void)goToFraisPort
{
    // normalement je devrais ajouter cette close : [self.delegate allTiragesHaveAdresse]
    // mais j'ai un problème dans l'enregistrement des adresses dans le Tirage
        if(self.delegate.totalCommande > 0)
        {
            FraisPortTableViewController* fraisPortTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"fraisPortTVC"];
            [self.navigationController pushViewController:fraisPortTVC animated:YES];
        }
        else if(!(self.delegate.totalCommande > 0))
        {
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Oups" message:@"Votre panier est vide :/" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction* action){
                                                           [alertController dismissViewControllerAnimated:YES completion:nil];
                                                       }];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
        } else if (![self.delegate allTiragesHaveAdresse])
        {
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Oups" message:@"Vous devez choisir des destinataires pour vos tirages" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction* action){
                                                           [alertController dismissViewControllerAnimated:YES completion:nil];
                                                       }];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
    
}

//----------------------------------------------------------------------------
#pragma mark - Utils
//----------------------------------------------------------------------------
- (void)updateTotal
{
    [self.delegate updateTotalCommande];
    self.navigationItem.title = [NSString stringWithFormat:@"%.2f€",self.delegate.totalCommande];
}
//----------------------------------------------------------------------------
- (void)deleteTirageFromCartAtIndex:(int)index
{
    [self.delegate.cartArray removeObjectAtIndex:index];
    
}


@end
