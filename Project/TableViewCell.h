//
//  TableViewCell.h
//  Project
//
//  Created by vigneshwaranm on 12/02/18.
//  Copyright © 2018 FSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@end
