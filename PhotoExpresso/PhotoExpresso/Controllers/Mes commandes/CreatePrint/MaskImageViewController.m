//
//  MaskImageViewController.m
//  PhotoExpresso
//
//  Created by laurine baillet on 07/03/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import "MaskImageViewController.h"
#import "TabBarViewController.h"
#import "AppDelegate.h"

#import "FXImageView.h"

#import "Constant.h"

@interface MaskImageViewController ()

@property   NSMutableArray*     formatMutableArray;
@property   Format*             formatSelected;
@property   AppDelegate*        delegate;
@end

@implementation MaskImageViewController
//---------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.finalImageView.image = self.tirage.photo;
    self.infoView.hidden = YES;
    
    [self updatePriceTitle];
    
    self.delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    // Connecter les données
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    self.pickerView.hidden = YES;
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"format" ofType:@"json"]; // A changer pour recupération sur serveur
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    
    NSArray* jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    
    [self initFormatArrayWithArray:jsonArray];
}
//----------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self setHomeButton];
    [self setBackButton];
    [self setAddShoppingCartButton];
}
//----------------------------------------------------------------------------
#pragma mark - Data Methods
//----------------------------------------------------------------------------
- (void)saveTirage
{
    [self.delegate.cartArray addObject:self.tirage];
}
//---------------------------------------------------------------------
- (void)initFormatArrayWithArray:(NSArray*)array
{
    self.formatMutableArray = [[NSMutableArray alloc] init];
    for(int i = 0; i < [array count]; i ++)
    {
        [self.formatMutableArray addObject:[self makeFormatWithDictionnary:array[i]]];
    }
}
//---------------------------------------------------------------------
- (Format*)makeFormatWithDictionnary:(NSDictionary*)dico
{
    Format* format = [[Format alloc]init];
    format.idFormat = [[dico objectForKey:@"id"] intValue];
    format.intitule = [dico objectForKey:@"intitule"];
    format.tarif = [[dico objectForKey:@"tarif"] floatValue];
    format.width = [[dico objectForKey:@"width"] floatValue];
    format.length = [[dico objectForKey:@"length"] floatValue];
    
    return format;
}
//---------------------------------------------------------------------
#pragma mark - picker View Delegate
//---------------------------------------------------------------------
// Le nombre de colonnes des données
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//---------------------------------------------------------------------
// Le nombre de lignes des données
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return (int)self.formatMutableArray.count +1;
}
//--------------------------------------------------------------    -------
// Les données à retourner pour la ligne et le composant (colonne) qui est passé en entrée
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(row == 0)
    {
        return @"Choisir un format";
    }
    Format* format = self.formatMutableArray[row-1];
    return format.intitule;
}

//---------------------------------------------------------------------
// Détecter l'élément sélectionné dans le picker view
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(row == 0)
    {
        self.formatSelected = nil;
    }
    else
    {
        self.formatSelected = self.formatMutableArray[row-1];
        self.intituleFormatLabel.text = self.formatSelected.intitule;
        
        self.tirage.format = self.formatSelected;
        [self.tirage updateMontantTotal];
        [self updatePriceTitle];
        
        self.pickerView.hidden = YES;
    }
}
//----------------------------------------------------------------------------
#pragma mark - Navigation
//----------------------------------------------------------------------------
- (void)updatePriceTitle
{
    self.navigationItem.title = [NSString stringWithFormat:@"%.2f€",self.tirage.montantTotal];
}
//----------------------------------------------------------------------------
- (void)setAddShoppingCartButton
{
    UIImage* addSC = [UIImage imageNamed:@"addShoppingCart"];
    UIBarButtonItem* rightBarButton = [[UIBarButtonItem alloc] initWithImage:addSC style:UIBarButtonItemStylePlain target:self action:@selector(addToCart)];
    [rightBarButton setTintColor:kOrange4Color];
    
    [[self navigationItem] setRightBarButtonItem:rightBarButton];
}
//----------------------------------------------------------------------------
#pragma mark - Action Methods
//----------------------------------------------------------------------------
- (void)addToCart
{
    if(self.formatSelected != nil)
    {
    @try {
        [self saveTirage];
        
        UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"Bravo !" message:@"Votre image a été ajouté au panier" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction* action)
                             {
                                 [alertController dismissViewControllerAnimated:YES completion:nil];
                                 TabBarViewController* tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"tabBarVC"];
                                 
                                 [self.navigationController pushViewController:tabBarVC animated:YES];
                             }];
        
        [alertController addAction:ok];
        
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    } @catch (NSException *exception) {
        
        NSLog(@"Exception : %@",exception.reason);
        UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"Oups" message:@"Quelque chose s'est mal passé" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Ok..." style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction* action)
                             {
                                 [alertController dismissViewControllerAnimated:YES completion:nil];
                             }];
        
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    }
    else
    {
        UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"Oups" message:@"Vous n'avez pas sélectionné de format" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction* action)
                             {
                                 [alertController dismissViewControllerAnimated:YES completion:nil];
                             }];
        
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];

    }
    
}

//----------------------------------------------------------------------------
- (void)goToMainPage {

        UIAlertController*  alertController = [UIAlertController alertControllerWithTitle:@"Attention" message:@"Voulez-vous vraiment retourner à l'accueil? Votre image sera perdue" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* non = [UIAlertAction actionWithTitle:@"Non" style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction* action)
                              {
                                  [alertController dismissViewControllerAnimated:YES completion:nil];
                                  
                              }];
        
        [alertController addAction:non];
        
        UIAlertAction* oui = [UIAlertAction actionWithTitle:@"Oui" style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction* action)
                              {
                                  [alertController dismissViewControllerAnimated:YES completion:nil];
                                 
                                  TabBarViewController* tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"tabBarVC"];
                                  
                                  [self.navigationController pushViewController:tabBarVC animated:YES];
                              }];
        [alertController addAction:oui];
        
        [self presentViewController:alertController animated:YES completion:nil];

}
//----------------------------------------------------------------------------
#pragma mark - IB Action
//----------------------------------------------------------------------------
- (IBAction)showPickerView:(id)sender {
    self.pickerView.hidden = NO;
}
//----------------------------------------------------------------------------
- (IBAction)openInfoView:(id)sender {
    if([self.infoView isHidden])
        self.infoView.hidden = NO;
     else
        self.infoView.hidden = YES;
}

@end
