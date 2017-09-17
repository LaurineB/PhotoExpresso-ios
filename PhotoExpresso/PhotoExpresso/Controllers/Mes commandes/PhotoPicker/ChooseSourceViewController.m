//
//  ChooseSourceViewController.m
//  PhotoExpresso
//
//  Created by laurine baillet on 01/12/2016.
//  Copyright © 2016 Laurine Baillet. All rights reserved.
//

#import "ChooseSourceViewController.h"
#import "CreatePrintViewController.h"
#import <SVProgressHUD.h>

#import "Constant.h"

@interface ChooseSourceViewController ()

@property   UIImage*    collectedImage;

@end

@implementation ChooseSourceViewController

//----------------------------------------------------------------------------
#pragma mark - View LifeCyle Methods
//----------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Attention" message:@"Votre matériel n'a pas de caméra" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Je ferai attention" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction* action){
                                                       [alertController dismissViewControllerAnimated:YES completion:nil];
                                                   }];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    
    
}
//----------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated{

    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    self.tirageArray = [[NSMutableArray alloc] init];
    if([userDefault objectForKey:kUserDefaultTirageKey] != nil)
    {
        self.tirageArray = [userDefault objectForKey:kUserDefaultTirageKey];
    }
    
    self.navigationItem.hidesBackButton = YES;
    
    if(![userDefault objectForKey:kUserDefaultFirstname])
    {
        self.navigationItem.hidesBackButton = NO;
        [self setBackButton];
    }
    
    [self setShoppingCartButton];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    [super viewWillAppear:animated];
}
//----------------------------------------------------------------------------
#pragma mark - Button Action
//----------------------------------------------------------------------------
- (IBAction)clickOnTakePhoto:(id)sender {
    
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Je vous avais prévenu!" message:@"Un peu plus et l'application s'arrêtait inopinément" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Je le sais" style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction* action){
                                                       [alertController dismissViewControllerAnimated:YES completion:nil];
                                                   }];
        UIAlertAction* poursuivre = [UIAlertAction actionWithTitle:@"Allons-y quand même" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
            [alertController dismissViewControllerAnimated:YES completion:nil];
            
            pickerTakePhoto = [[UIImagePickerController alloc] init];
            pickerTakePhoto.delegate = self;
            pickerTakePhoto.sourceType = UIImagePickerControllerSourceTypeCamera;
            pickerPhotoLibrary.allowsEditing = YES;
            
            [self presentViewController:pickerTakePhoto animated:YES completion:nil];
        }];
        [alertController addAction:ok];
        [alertController addAction:poursuivre];
        
        [self presentViewController:alertController animated:YES completion:nil];

    } else {
        pickerTakePhoto = [[UIImagePickerController alloc] init];
        pickerTakePhoto.delegate = self;
        pickerTakePhoto.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerPhotoLibrary.allowsEditing = YES;
        
        [self presentViewController:pickerTakePhoto animated:YES completion:nil];

    }
}
//----------------------------------------------------------------------------
- (IBAction)clickOnSelectPhoto:(id)sender {
    
    pickerPhotoLibrary = [[UIImagePickerController alloc] init];
    pickerPhotoLibrary.delegate = self;
    pickerPhotoLibrary.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerPhotoLibrary.allowsEditing = YES;
    
    [self presentViewController:pickerPhotoLibrary animated:YES completion:nil];
}

//----------------------------------------------------------------------------
#pragma mark - ImagePickerController Methods
//----------------------------------------------------------------------------
//Tells the delegate that the user picked a still image or movie.
- (void)imagePickerController:(UIImagePickerController *) Picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //récupère l'image choisie
    [pickerPhotoLibrary dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.collectedImage = image;
    
    [self performSegueWithIdentifier:@"createPrint" sender:self];
    
}
//----------------------------------------------------------------------------
//Tells the delegate that the user cancelled the pick operation.
//----------------------------------------------------------------------------
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [pickerPhotoLibrary dismissViewControllerAnimated:YES completion:nil];
}
//----------------------------------------------------------------------------
#pragma mark - prepare for segue
//----------------------------------------------------------------------------
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [SVProgressHUD showWithStatus:@"Filtres en préparation"];
    CreatePrintViewController* createPrintController = [segue destinationViewController];
    createPrintController.imageOriginale = self.collectedImage;
}




@end
