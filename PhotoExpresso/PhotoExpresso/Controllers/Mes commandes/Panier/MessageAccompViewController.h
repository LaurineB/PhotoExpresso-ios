//
//  MessageAccompViewController.h
//  PhotoExpresso
//
//  Created by Laurine Baillet on 15/03/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Adresse.h"
#import "Tirage.h"
#import "PhotoExpressoViewController.h"

@interface MessageAccompViewController : PhotoExpressoViewController

@property (weak, nonatomic) IBOutlet UITextView *messageTextView;

@property                               Tirage*         tirage;
@property                               Adresse*        adresse;

@end
