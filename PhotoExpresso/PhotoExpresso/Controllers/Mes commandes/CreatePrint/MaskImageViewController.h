//
//  MaskImageViewController.h
//  PhotoExpresso
//
//  Created by laurine baillet on 07/03/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tirage.h"
#import "PhotoExpressoViewController.h"

@interface MaskImageViewController : PhotoExpressoViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet    UIImageView     *finalImageView;
@property (weak, nonatomic) IBOutlet    UIPickerView    *pickerView;
@property (weak, nonatomic) IBOutlet    UILabel         *intituleFormatLabel;

@property (strong, nonatomic)           Tirage*         tirage;


@property (weak, nonatomic) IBOutlet UIView *infoView;

@end
