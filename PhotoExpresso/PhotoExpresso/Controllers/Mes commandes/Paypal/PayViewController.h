//
//  PayViewController.h
//  PhotoExpresso
//
//  Created by laurine baillet on 22/02/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"
#import "PhotoExpressoViewController.h"
@interface PayViewController : PhotoExpressoViewController <PayPalPaymentDelegate, PayPalFuturePaymentDelegate, PayPalProfileSharingDelegate, UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nbTiragesLabel;
@property (weak, nonatomic) IBOutlet UILabel *fraisDePortLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalHtcLabel;
@property (weak, nonatomic) IBOutlet UILabel *tvaLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalttcLabel;

@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, strong, readwrite) NSString *resultText;

@end
