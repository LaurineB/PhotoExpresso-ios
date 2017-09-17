//
//  CreatePrintViewController.m
//  PhotoExpresso
//
//  Created by laurine baillet on 01/12/2016.
//  Copyright © 2016 Laurine Baillet. All rights reserved.
//

#import "CreatePrintViewController.h"

#import "ChooseSourceViewController.h"
#import "MaskImageViewController.h"
#import "AppDelegate.h"
#import "TabBarViewController.h"

#import "FeSlideFilterView.h"
#import "CIFilter+LUT.h"
#import <SVProgressHUD.h>
#import "NSDictionnary+Utils.h"

#import "Filtre.h"
#import "Format.h"

#import "Constant.h"

@interface CreatePrintViewController ()<FeSlideFilterViewDataSource, FeSlideFilterViewDelegate>
//----------------------------------------------------------------------------
@property (strong, nonatomic)   FeSlideFilterView   *slideFilterView;
@property (strong, nonatomic)   NSMutableArray      *arrPhoto;

@property (strong, nonatomic)   NSArray*            filtreArray;
@property (strong,nonatomic)    NSMutableArray*     filtreObjectMA;
//----------------------------------------------------------------------------
-(void) initPhotoFilter;
-(void) initFilter;
-(void) initFeSlideFilterView;

@end
//----------------------------------------------------------------------------
@implementation CreatePrintViewController

//----------------------------------------------------------------------------
#pragma mark - View LifeCycle Methods
//----------------------------------------------------------------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.filtreArray = [[NSArray alloc] init];
    self.filtreObjectMA = [[NSMutableArray alloc]init];
    
    [self parseLocalJson];
    
    [self initPhotoFilter];
    
    [self initFilter];
    
    [SVProgressHUD dismiss];
}
//----------------------------------------------------------------------------
-(void)viewWillAppear:(BOOL)animated{
    
    [self initFeSlideFilterView];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    [super viewWillAppear:animated];
}
//----------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated
{
    [self setBackButton];
//    [self setAddShoppingCartButton];
    [self setTransformButton];
    
    [self updatePriceForFiltre:self.filtreObjectMA[0]];
    
    [super viewDidAppear:animated];
}
//----------------------------------------------------------------------------
#pragma mark - Init
//----------------------------------------------------------------------------

-(void)configureWithImage:(UIImage *)image
{
    self.imageOriginale = image;
}
//----------------------------------------------------------------------------
-(void) initPhotoFilter
{
    _arrPhoto = [NSMutableArray arrayWithCapacity:5];
    
    for (NSInteger i = 0; i < 5; i++)
    {
        if (i == 4)
        {
            UIImage *image = self.imageOriginale;
            [_arrPhoto addObject:image];
        }
        else
        {
            NSString *nameLUT = [NSString stringWithFormat:@"filter_lut_%ld",i + 1];
            
            //////////
            // FIlter with LUT
            // Load photo
            UIImage *photo = self.imageOriginale;
            
            // Create filter
            CIFilter *lutFilter = [CIFilter filterWithLUT:nameLUT dimension:64];
            
            // Set parameter
            CIImage *ciImage = [[CIImage alloc] initWithImage:photo];
            [lutFilter setValue:ciImage forKey:@"inputImage"];
            CIImage *outputImage = [lutFilter outputImage];
            
            CIContext *context = [CIContext contextWithOptions:[NSDictionary dictionaryWithObject:(__bridge id)(CGColorSpaceCreateDeviceRGB()) forKey:kCIContextWorkingColorSpace]];
            
            UIImage *newImage = [UIImage imageWithCGImage:[context createCGImage:outputImage fromRect:outputImage.extent]];
            
            
            [_arrPhoto addObject:newImage];
        }
    }
}
//----------------------------------------------------------------------------
-(void) initFilter
{
    for (int i=0;i < [self.filtreArray count];i++) {
        NSDictionary* filtreDict = self.filtreArray[i];
        
        Filtre* filtre = [self makeFiltreWithDictionnary:filtreDict];
        
        [self.filtreObjectMA addObject:filtre];
    }
}
//----------------------------------------------------------------------------
-(void) initFeSlideFilterView
{
    CGRect frame = CGRectMake(self.view.frame.origin.x,
                              self.view.frame.origin.y,
                              self.view.frame.size.width,
                              self.view.frame.size.height);
    
    self.slideFilterView = [[FeSlideFilterView alloc] initWithFrame:frame];
    self.slideFilterView.dataSource = self;
    self.slideFilterView.delegate = self;
    
    [self.view addSubview:self.slideFilterView];
    
    // Btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setBackgroundImage:[UIImage imageNamed:@"done"] forState:UIControlStateNormal];
    
    self.slideFilterView.doneBtn = btn;
}
//----------------------------------------------------------------------------
#pragma mark - Delegate / Data Source
//----------------------------------------------------------------------------
-(NSInteger) numberOfFilter
{
    return [self.filtreObjectMA count];
}
//----------------------------------------------------------------------------
-(Filtre *) FeSlideFilterView:(FeSlideFilterView *)sender filterAtIndex:(NSInteger)index
{
    return self.filtreObjectMA[index];
    
}
//----------------------------------------------------------------------------
-(UIImage *) FeSlideFilterView:(FeSlideFilterView *)sender imageFilterAtIndex:(NSInteger)index
{
    return _arrPhoto[index];
}
//----------------------------------------------------------------------------
-(void) FeSlideFilterView:(FeSlideFilterView *)sender didTapDoneButtonAtIndex:(NSInteger)index
{
    NSLog(@"did tap at index = %ld",(long)index);
}
//----------------------------------------------------------------------------
-(NSString *) kCAContentGravityForLayer
{
    return kCAGravityResizeAspectFill;
}
//----------------------------------------------------------------------------
-(void) FeSlideFilterView:(FeSlideFilterView *)sender didEndSlideFilterAtIndex:(NSInteger) index
{
    Filtre* filtre = self.filtreObjectMA[index];
    [self updatePriceForFiltre:filtre];
}
//----------------------------------------------------------------------------
#pragma mark - Slide Private Methods
//----------------------------------------------------------------------------
- (void)updatePriceForFiltre:(Filtre*)filtre
{
    self.navigationItem.title = [NSString stringWithFormat:@"%.2f€",filtre.tarif];
}
//----------------------------------------------------------------------------
#pragma mark - Navigation methods
//----------------------------------------------------------------------------
-(void)setBackButton
{
    // arrow left navigation item
    UIImage* arrowLeft = [UIImage imageNamed:@"arrowLeft"];
    UIBarButtonItem* backBarButton = [[UIBarButtonItem alloc] initWithImage:arrowLeft style:UIBarButtonItemStylePlain target:self action:@selector(goToMainPage)];
    [backBarButton setTintColor:kOrange4Color];
    [[self navigationItem] setLeftBarButtonItem:backBarButton];
}
//----------------------------------------------------------------------------
- (void)setTransformButton
{
    UIImage* addSC = [UIImage imageNamed:@"transform"];
    UIBarButtonItem* rightBarButton = [[UIBarButtonItem alloc] initWithImage:addSC style:UIBarButtonItemStylePlain target:self action:@selector(goToMask)];
    [rightBarButton setTintColor:kOrange4Color];
    
    [[self navigationItem] setRightBarButtonItem:rightBarButton];
}
//---------------------------------------------------------------------
- (void)goToMask
{
    long index = self.slideFilterView.currentIndex;
    UIImage*    imageToAdd  = self.arrPhoto[index];
    
    Filtre*   filtre      = self.filtreObjectMA[index];

    Format*   format      = [[Format alloc]init];
    
    Tirage* tirage = [[Tirage alloc] init];
    tirage.photo    = imageToAdd;
    tirage.filtre   = filtre;
    tirage.format   = format;
    tirage.nbExemplairePhoto = 1;
    [tirage updateMontantTotal];
    
    // go to the mask
    MaskImageViewController* maskImageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"maskImageVC"];
    
    maskImageVC.tirage = tirage;
    [self.navigationController pushViewController:maskImageVC animated:YES];
}
//----------------------------------------------------------------------------
#pragma mark - Data Methods
//----------------------------------------------------------------------------

- (void)sendFilterNamesToServer
{
    //C'est l'application qui détermine les filtres disponibles et non le photographe. mais le photographe peut décider de les désactiver : filtre.actif (BOOL)
    
    NSArray* intitules = @[@"Los Angeles",@"Paris",@"London",@"Rio"];
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:intitules options:NSJSONWritingPrettyPrinted error:nil];
    
    //prepare url
    
    NSString* urlString = [NSString stringWithFormat:@"%@/recupererNomsFiltre",kUrl_api];
    NSURL* url = [NSURL URLWithString:urlString];

    //Send to server
}
//----------------------------------------------------------------------------
- (void)parseLocalJson
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"filtre" ofType:@"json"]; // A changer pour recupération sur serveur
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    
    self.filtreArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    
    if(_filtreArray[0] == nil)
    {
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Erreur" message:@"Aucun filtre disponible pour le moment" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction* action){
                                                       [alertController dismissViewControllerAnimated:YES completion:nil];
                                                       
                                                       TabBarViewController* tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"tabBarVC"];
                                                       [self.navigationController pushViewController:tabBarVC animated:YES];
                                                   }];
        [alertController addAction:ok];
        
        [self presentViewController:alertController animated:YES completion:nil];

    }
}
//----------------------------------------------------------------------------
- (Filtre*)makeFiltreWithDictionnary:(NSDictionary*)filtreDict
{
    if([filtreDict isValidDictionary])
    {
        Filtre* filtre = [[Filtre alloc] init];
        
        filtre.idFiltre = [[filtreDict stringForKey:@"id"] intValue];
        filtre.intitule = [filtreDict stringForKey:@"intitule"];
        filtre.tarif    = [[filtreDict stringForKey:@"tarif"] floatValue];
        filtre.actif    = [filtreDict stringForKey:@"actif"];
        
        return filtre;
        
    }
    return [[Filtre alloc] init];
}
@end
