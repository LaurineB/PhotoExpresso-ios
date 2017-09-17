//
//  MCANewAdresseViewController.h
//  PhotoExpresso
//
//  Created by laurine baillet on 20/02/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoExpressoViewController.h"

@interface MCANewAdresseViewController : PhotoExpressoViewController

@property (weak, nonatomic) IBOutlet UITextField *intituleTextField;
@property (weak, nonatomic) IBOutlet UITextField *nomTextField;
@property (weak, nonatomic) IBOutlet UITextField *prenomTextField;
@property (weak, nonatomic) IBOutlet UITextField *adresse1TextField;
@property (weak, nonatomic) IBOutlet UITextField *adresse2TextField;
@property (weak, nonatomic) IBOutlet UITextField *codePostalTextField;
@property (weak, nonatomic) IBOutlet UITextField *villeTextField;
@property (weak, nonatomic) IBOutlet UITextField *paysTextField;

@end
