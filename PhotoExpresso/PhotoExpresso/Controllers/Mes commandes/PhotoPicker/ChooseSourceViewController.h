//
//  ChooseSourceViewController.h
//  PhotoExpresso
//
//  Created by laurine baillet on 01/12/2016.
//  Copyright © 2016 Laurine Baillet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoExpressoViewController.h"
@interface ChooseSourceViewController : PhotoExpressoViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIImagePickerController *pickerPhotoLibrary;
    UIImagePickerController *pickerTakePhoto;
}

@property (weak, nonatomic) IBOutlet    UIButton *      takePhotoButton;
@property (weak, nonatomic) IBOutlet    UIButton *      selectPhotoButton;
@property (weak, nonatomic) IBOutlet    UIButton *      fbPhotoButton;

@property (nonatomic)                   NSMutableArray* tirageArray;


@end
