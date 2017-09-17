//
//  TirageTableViewCell.m
//  PhotoExpresso
//
//  Created by laurine baillet on 02/02/2017.
//  Copyright © 2017 Laurine Baillet. All rights reserved.
//

#import "CommandeTableViewCell.h"

#import "Constant.h"

@implementation CommandeTableViewCell : UITableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.addButton.imageView.tintColor = kOrange4Color;
    self.removeButton.tintColor = kOrange4Color;
    
}
//----------------------------------------------------------------------------

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//----------------------------------------------------------------------------
- (void)layoutSubviews {
    [super layoutSubviews];
    self.photoImageView.frame = CGRectMake(0,0,32,32);
}
@end
