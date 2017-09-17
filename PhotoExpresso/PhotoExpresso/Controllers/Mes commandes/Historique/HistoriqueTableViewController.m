//
//  HistoriqueTableViewController.m
//  PhotoExpresso
//
//  Created by laurine baillet on 13/12/2016.
//  Copyright © 2016 Laurine Baillet. All rights reserved.
//

#import "HistoriqueTableViewController.h"

#import "HistoriqueTableViewCell.h"

#import "Commande.h"

#import "Constant.h"

@interface HistoriqueTableViewController ()

@property   NSArray*    commandes;

@end

@implementation HistoriqueTableViewController
//----------------------------------------------------------------------------
#pragma mark - View Life Cycle Methods
//----------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.allowsSelection = NO;
    
    [self parseLocalJson];
}
//----------------------------------------------------------------------------
#pragma mark - Table view data source
//----------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//----------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.commandes count];
}
//----------------------------------------------------------------------------
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO];
    [super viewWillAppear:animated];
}
//----------------------------------------------------------------------------
#pragma mark - TableView delegate
//----------------------------------------------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HistoriqueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"historiqueCell" forIndexPath:indexPath];
    
    Commande* commande = [[Commande alloc] init];
    
    // Formatage de date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    
    // French Locale (fr_FR)
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
    
    NSDictionary* commandeDict = self.commandes[indexPath.row];
    
    commande.numero = [NSString stringWithFormat:@"%@",[commandeDict objectForKey:@"id"]];
    commande.statut = [commandeDict objectForKey:@"statut"];
    commande.montantTotal = [[commandeDict objectForKey:@"montant"]floatValue];
    commande.date = [commandeDict objectForKey:@"created_at"];

    // Configure the cell...
    
    cell.numeroCommandeLabel.text = commande.numero;
    
    //formatage du statut
    if([commande.statut isEqualToString:@"envoye"])
    {
        cell.statutCommandeLabel.text = @"Envoyée";
    } else if ([commande.statut isEqualToString:@"en traitement"])
    {
        cell.statutCommandeLabel.text = @"En traitement";
    } else
    {
        cell.statutCommandeLabel.text = @"validée";
    }
    
    //debug
    //NSDate* date =  commande.date;
    //cell.dateLabel.text = [dateFormatter stringFromDate:date];
    cell.dateLabel.text = commande.date;
    cell.montantLabel.text = [NSString stringWithFormat:@"%.2f €",commande.montantTotal];
    
    return cell;
}
//---------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
//----------------------------------------------------------------------------
# pragma mark - parse JSON
//----------------------------------------------------------------------------
- (void)parseLocalJson
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"commande" ofType:@"json"]; // A changer pour recupération sur serveur
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    
    self.commandes = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    
}
@end
