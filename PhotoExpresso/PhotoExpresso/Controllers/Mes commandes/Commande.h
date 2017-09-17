//
//  Commande.h
//  PhotoExpresso
//
//  Created by laurine baillet on 13/12/2016.
//  Copyright © 2016 Laurine Baillet. All rights reserved.
//

#import "FraisPort.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Commande : NSObject

@property   (strong,nonatomic)  NSString*           numero;
@property   (strong,nonatomic)  NSString*           statut;
//@property   (strong,nonatomic)  NSDate*             date;
// debug
@property   (strong,nonatomic)  NSString*           date;
@property   (strong,nonatomic)  NSMutableArray*     tirageList;
@property   (strong,nonatomic)  NSMutableArray*     codeReductionList;
@property   (nonatomic)         FraisPort*          fraisPort;
@property                       float               montantTotal;

@end
