//
//  MonCarnetDadresseTableViewController.m
//  PhotoExpresso
//
//  Created by laurine baillet on 05/12/2016.
//  Copyright © 2016 Laurine Baillet. All rights reserved.
//

#import "MonCarnetDadresseTableViewController.h"

#import "MonCarnetDadresseTableViewCell.h"
#import "MonCarnetDadresseDetailViewController.h"
#import "MCANewAdresseViewController.h"

#import "Adresse.h"

#import "Constant.h"

//POD
#import "JSONKit.h"
#import <SVProgressHUD.h>

@interface MonCarnetDadresseTableViewController ()

@property   (nonatomic) NSArray* adresseArray;

@end

@implementation MonCarnetDadresseTableViewController
//----------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self parseLocalJson];
}
//----------------------------------------------------------------------------
-(void)viewWillAppear:(BOOL)animated{
    UIImage* arrowLeft = [UIImage imageNamed:@"arrowLeft"];
    UIBarButtonItem* backBarButton = [[UIBarButtonItem alloc] initWithImage:arrowLeft style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [backBarButton setTintColor:kOrange4Color];
    
    [[self navigationItem] setLeftBarButtonItem:backBarButton];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.tableView reloadData];
    
    [super viewWillAppear:animated];
}

//----------------------------------------------------------------------------
#pragma mark - UITableView delegate
//----------------------------------------------------------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//----------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.adresseArray count]+1;
}

//----------------------------------------------------------------------------
# pragma mark - parse JSON
//----------------------------------------------------------------------------
- (void)parseLocalJson
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"adresse" ofType:@"json"]; // A changer pour recupération sur serveur
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];

    self.adresseArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    
    NSLog(@"%@",self.adresseArray);
}

//----------------------------------------------------------------------------
#pragma mark - Table view data source
//----------------------------------------------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MonCarnetDadresseTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"adresseCell"];

    if(indexPath.row == 0)
    {
        cell.intituleLabel.text = @"Ajouter un contact";
        cell.fullnameLabel.text = @"";
        cell.villeLabel.text = @"";
        
        return cell;
    }
    NSDictionary* adresseDict = self.adresseArray[indexPath.row-1];
    
    Adresse* adresse = [self makeAdressWithDictionnary:adresseDict];
    
    NSString* nom = [NSString stringWithFormat:@" %@",adresse.nom];
    NSString* fullname = [adresse.prenom stringByAppendingString:nom];
    
    
    // Configure the cell...
    cell.intituleLabel.text = adresse.intitule;
    cell.fullnameLabel.text = fullname;
    cell.villeLabel.text = adresse.ville;

    return cell;
}
//----------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        MCANewAdresseViewController* MCANewAdresseVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MCANewAdresseVC"];
        [self.navigationController pushViewController:MCANewAdresseVC animated:YES];
    }
    else
    {
        MonCarnetDadresseDetailViewController* MCDDetailtVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MCDDetailtVC"];
    
        NSDictionary* adresseDict = self.adresseArray[indexPath.row-1];
    
        Adresse* adresseToSend = [self makeAdressWithDictionnary:adresseDict];
    
        MCDDetailtVC.adresseObject = adresseToSend;
    
        [self.navigationController pushViewController:MCDDetailtVC animated:YES];
    }
 }

//----------------------------------------------------------------------------
#pragma mark - Utils
//----------------------------------------------------------------------------
- (Adresse*)makeAdressWithDictionnary:(NSDictionary*)adresseDict
{
    Adresse* adresse = [[Adresse alloc] init];
    
    adresse.intitule = [adresseDict objectForKey:@"intitule"];
    adresse.nom = [adresseDict objectForKey:@"nom"];
    adresse.prenom = [adresseDict objectForKey:@"prenom"];
    adresse.adresse1 = [adresseDict objectForKey:@"adresse1"];
    adresse.adresse2 = [adresseDict objectForKey:@"adresse2"];
    adresse.codePostal = [adresseDict objectForKey:@"codepostal"];
    adresse.ville = [adresseDict objectForKey:@"ville"];
    adresse.pays = [adresseDict objectForKey:@"pays"];
    
    return adresse;
}

@end
