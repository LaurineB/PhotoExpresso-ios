//
//  ChoixDestinataireTableViewController.m
//  PhotoExpresso
//
//  Created by laurine baillet on 22/02/2017.
//  Copyright © 2017 Estiam. All rights reserved.
//

#import "ChoixDestinataireTableViewController.h"

#import "MCANewAdresseViewController.h"
#import "DestinataireTableViewCell.h"
#import "AppDelegate.h"
#import "MessageAccompViewController.h"

#import "Adresse.h"
#import "Tirage.h"

#import "NSDictionnary+Utils.h"

#import "Constant.h"

@interface ChoixDestinataireTableViewController ()

@property   AppDelegate*    delegate;

@end

@implementation ChoixDestinataireTableViewController

//----------------------------------------------------------------------------
#pragma mark - View Life Cycle Methods
//----------------------------------------------------------------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.adressesObjectMA = [[NSMutableArray alloc] init];
    self.adressesSelectedMA = [[NSMutableArray alloc] init];
    
    [self parseLocalJson];
    
    if(self.tirage.adresses != nil)
    {
        self.adressesSelectedMA = [[NSMutableArray alloc] initWithArray:self.tirage.adresses];
    }
    
}
//----------------------------------------------------------------------------
-(void)viewWillAppear:(BOOL)animated{

    [self setBackButton];
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.tableView reloadData];
    
    [super viewWillAppear:animated];
}
//----------------------------------------------------------------------------
#pragma mark - Table view data source
//----------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//----------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.adressesObjectMA count];
}

//----------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DestinataireTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"destCell" forIndexPath:indexPath];
    
    Adresse* adresse = [self.adressesObjectMA objectAtIndex:indexPath.row];
    
    NSString* nom = [NSString stringWithFormat:@" %@",adresse.nom];
    NSString* fullname = [adresse.prenom stringByAppendingString:nom];
    
    // Configure the cell...
    cell.intituleLabel.text = adresse.intitule;
    cell.nomLabel.text = fullname;
    cell.villeLabel.text = adresse.ville;
    cell.messageButton.tag = indexPath.row;
    [cell.messageButton addTarget:self action:@selector(goToMessage:) forControlEvents:UIControlEventTouchUpInside];
    
    if([self tirageContainAdresse:adresse])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}
//----------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.adressesSelectedMA removeObject:[self.adressesObjectMA objectAtIndex:indexPath.row]];
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        [self.adressesSelectedMA addObject:[self.adressesObjectMA objectAtIndex:indexPath.row]];
    }
}
//----------------------------------------------------------------------------
#pragma mark - Utils
//----------------------------------------------------------------------------
- (void)makeAdressWithDictionnary:(NSDictionary*)adresseDict
{
    if([adresseDict isValidDictionary])
    {
        Adresse* adresse = [[Adresse alloc] init];
        
        adresse.intitule = [adresseDict stringForKey:@"intitule"];
        adresse.nom = [adresseDict stringForKey:@"nom"];
        adresse.prenom = [adresseDict stringForKey:@"prenom"];
        adresse.adresse1 = [adresseDict stringForKey:@"adresse1"];
        adresse.adresse2 = [adresseDict stringForKey:@"adresse2"];
        adresse.codePostal = [adresseDict stringForKey:@"codepostal"];
        adresse.ville = [adresseDict stringForKey:@"ville"];
        adresse.pays = [adresseDict stringForKey:@"pays"];
        
        [self.adressesObjectMA addObject:adresse];
        
    }

}
//---------------------------------------------------------------------
- (BOOL)tirageContainAdresse:(Adresse*)adresse
{
    if(adresse != nil && [adresse isKindOfClass:[Adresse class]])
    {
        for(Adresse* adresseTirage in self.tirage.adresses)
        {
            if([adresseTirage.intitule isEqualToString:adresse.intitule] && [adresseTirage.prenom isEqualToString:adresse.prenom] && [adresseTirage.ville isEqualToString:adresse.ville])
            {
                return true;
            }
        }
    }
    return false;

}

//----------------------------------------------------------------------------
# pragma mark - parse JSON
//----------------------------------------------------------------------------
- (void)parseLocalJson
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"adresse" ofType:@"json"]; // A changer pour recupération sur serveur
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    
    NSArray* adresseArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    
    for(int i=0;i < [adresseArray count]; i++)
    {
        NSDictionary* adresseDict = adresseArray[i];
        
        [self makeAdressWithDictionnary:adresseDict];
    }
}

//----------------------------------------------------------------------------
#pragma mark - Button action
//----------------------------------------------------------------------------
- (void)goToMessage:(UIButton*)sender
{
    MessageAccompViewController* messageAccompVC = [self.storyboard instantiateViewControllerWithIdentifier:@"messageAccompVC"];
    messageAccompVC.adresse = [self takeTirageAdresseCorrespondingAdress:[self.adressesObjectMA objectAtIndex:sender.tag]];
    messageAccompVC.tirage = self.tirage;
    
    [self.navigationController pushViewController:messageAccompVC animated:YES];
}
//----------------------------------------------------------------------------
- (Adresse*)takeTirageAdresseCorrespondingAdress:(Adresse*)adresse
{
    if(adresse != nil && [adresse isKindOfClass:[Adresse class]])
    {
        for(Adresse* adresseTirage in self.tirage.adresses)
        {
            if([adresseTirage.intitule isEqualToString:adresse.intitule] && [adresseTirage.prenom isEqualToString:adresse.prenom] && [adresseTirage.ville isEqualToString:adresse.ville])
            {
                return adresseTirage;
            }
        }
    }
    return nil;

}
//----------------------------------------------------------------------------
#pragma mark - Navigation
//----------------------------------------------------------------------------
- (void)goBack
{
    self.tirage.adresses = [self.adressesSelectedMA copy];
    [self.delegate updateTotalCommande];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
