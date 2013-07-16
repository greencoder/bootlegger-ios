//
//  CustomCell.h
//  RumRunner
//
//  Created by Scott Newman on 4/25/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketCell : UITableViewCell
{
    IBOutlet UILabel *itemLabel;
    IBOutlet UILabel *priceLabel;
    IBOutlet UILabel *qtyLabel;
    IBOutlet UILabel *ownedLabel;
}

@property (nonatomic, retain) UILabel *itemLabel;
@property (nonatomic, retain) UILabel *priceLabel;
@property (nonatomic, retain) UILabel *qtyLabel;
@property (nonatomic, retain) UILabel *ownedLabel;

@end
