//
//  TirageTableViewCell.h
//  PhotoExpresso
//
//  Created by laurine baillet on 02/02/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommandeTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nbTirageLabel;
@property (strong, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;

@end
