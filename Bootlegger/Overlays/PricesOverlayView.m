//
//  PricesOverlayView.m
//  RumRunner
//
//  Created by Scott Newman on 5/9/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "PricesOverlayView.h"
#import "PriceCell.h"
#import "Item.h"
#import "Constants.h"

@implementation PricesOverlayView

@synthesize delegate = _delegate;
@synthesize tableView = _tableView;

- (IBAction)doneClick:(id)sender
{
    [self.delegate pricesOverlayDidClickDone];
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.tableView = (UITableView *)[self viewWithTag:100];
        [self.tableView registerNib:[UINib nibWithNibName:@"PriceCell" bundle:nil]
             forCellReuseIdentifier:@"Cell"];
    }
    
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *itemsArray = self.infoDict[@"items"];
    return itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    PriceCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    // We want to list the items by their sort order. There are easier ways to do this, but
    // it works without having to copy the array.
    Item *item;
    for (Item *theItem in self.infoDict[@"items"]) {
        if (theItem.sortOrder == (indexPath.row + 1)) {
            item = theItem;
        }
    }

    cell.nameLabel.text = item.name;
    cell.priceRangeLabel.text = [NSString stringWithFormat:@"$%d - $%d", item.minPrice, item.maxPrice];
    
    return cell;
}



@end
