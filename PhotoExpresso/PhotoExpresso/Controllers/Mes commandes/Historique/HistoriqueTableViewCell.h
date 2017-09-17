//
//  HistoriqueTableViewCell.h
//  PhotoExpresso
//
//  Created by laurine baillet on 13/12/2016.
//  Copyright © 2016 Laurine Baillet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoriqueTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numeroCommandeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *statutCommandeLabel;
@property (weak, nonatomic) IBOutlet UILabel *montantLabel;

@end
