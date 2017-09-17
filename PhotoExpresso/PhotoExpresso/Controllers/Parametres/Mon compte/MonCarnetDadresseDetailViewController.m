//
//  MonCarnetDadresseDetailViewController.m
//  PhotoExpresso
//
//  Created by laurine baillet on 08/02/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import "MonCarnetDadresseDetailViewController.h"

#import "Constant.h"

@interface MonCarnetDadresseDetailViewController ()

@end

@implementation MonCarnetDadresseDetailViewController


//----------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(self.adresseObject != nil)
    {
        self.intituleTextField.text = self.adresseObject.intitule;
        self.nomTextField.text = self.adresseObject.nom;
        self.prenomTextField.text = self.adresseObject.prenom;
        self.adresse1TextField.text = self.adresseObject.adresse1;
        self.adresse2TextField.text = self.adresseObject.adresse2;
        self.codePostalTextField.text = self.adresseObject.codePostal;
        self.villeTextField.text = self.adresseObject.ville;
        self.paysTExtField.text = self.adresseObject.pays;
    }
    
}
//----------------------------------------------------------------------------
-(void)viewWillAppear:(BOOL)animated{
    [self setBackButton];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = @"Modifier un contact";
    self.navigationController.navigationBar.tintColor = kOrange5Color;
    [super viewWillAppear:animated];
}

//----------------------------------------------------------------------------
#pragma mark - Action button
//----------------------------------------------------------------------------

- (IBAction)clickOnRegister:(id)sender {
    NSLog(@"Register edit adress");
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

@end
