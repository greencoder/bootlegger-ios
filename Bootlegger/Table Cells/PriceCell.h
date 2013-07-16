//
//  PriceCell.h
//  RumRunner
//
//  Created by Scott Newman on 5/10/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceCell : UITableViewCell
{
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *priceRangeLabel;
}

@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *priceRangeLabel;

@end
