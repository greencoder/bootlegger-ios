//
//  PricesOverlayView.h
//  RumRunner
//
//  Created by Scott Newman on 5/9/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "BaseOverlayView.h"

@protocol PricesOverlayViewDelegate <NSObject>
- (void)pricesOverlayDidClickDone;
@end

@interface PricesOverlayView : BaseOverlayView
    <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *priceRangeLabel;
    IBOutlet UITableView *tableView;
}

@property (nonatomic, weak) id<PricesOverlayViewDelegate> delegate;
@property (nonatomic, retain) UITableView *tableView;

- (IBAction)doneClick:(id)sender;

@end
