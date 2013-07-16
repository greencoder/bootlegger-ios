//
//  MarketView.h
//  RumRunner
//
//  Created by Scott Newman on 4/24/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketView : UIView
{
    id delegate;
    IBOutlet UILabel *priceLabel;
    IBOutlet UILabel *itemLabel;
    IBOutlet UILabel *qtyLabel;
    IBOutlet UILabel *ownedLabel;
    IBOutlet UILabel *helpLabel;
    IBOutlet UITableView *tableView;
}

@property (nonatomic, weak) id delegate;
@property (nonatomic, retain) UITableView *tableView;

@end
