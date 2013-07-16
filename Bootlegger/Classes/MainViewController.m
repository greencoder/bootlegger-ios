//
//  ViewController.m
//  RumRunner
//
//  Created by Scott Newman on 4/22/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "MainViewController.h"
#import "BaseOverlayView.h"
#import "Item.h"
#import "MarketCell.h"
#import "Constants.h"
#import "FooterView.h"
#import "HeaderView.h"
#import "MessageView.h"
#import "ButtonRowView.h"
#import "NSMutableArray+Shuffle.h"

@implementation MainViewController

@synthesize player = _player;
@synthesize game = _game;
@synthesize gameWasLoaded = _gameWasLoaded;
@synthesize gameInProgress = _gameInProgress;
@synthesize savedFilePath = _savedFilePath;
@synthesize itemsArray = _dataArray;
@synthesize marketView = _marketView;
@synthesize buttonRowView = _buttonRowView;
@synthesize mapView = _mapView;
@synthesize footerView = _footerView;
@synthesize headerView = _headerView;
@synthesize messageView = _messageView;
@synthesize finishGameView = _finishGameView;

- (void)viewDidLoad
{
    int defaultDifficulty = 1;
    int defaultLength = 30;
    
    self.player = [[Player alloc] initWithDifficulty:defaultDifficulty];
    self.game = [[Game alloc] initWithLength:defaultLength difficulty:defaultDifficulty];

    self.itemsArray = [[NSMutableArray alloc] initWithCapacity:10];
    [self generateData];
    
    self.mapView.player = self.player;
    self.footerView.player = self.player;
    self.headerView.player = self.player;
    self.messageView.player = self.player;
    self.buttonRowView.player = self.player;

    self.marketView.delegate = self;
    self.mapView.delegate = self;
    self.buttonRowView.delegate = self;
    self.finishGameView.delegate = self;
    
    self.headerView.game = self.game;
    self.messageView.game = self.game;
    
    [self.messageView updateLabels];
    [self updateLabels];

    // Set the saved file path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    self.savedFilePath = [documentsDirectory stringByAppendingPathComponent:@"game.archive"];
    
    [buttonRowView updateButtons];
}

- (void)viewDidAppear:(BOOL)animated
{
    // If we aren't loading a file, show the new game overlay
    if (!self.gameWasLoaded) {
        [self showOverlay:NEW_GAME_TAG withInfo:nil];
    }
}

- (void)updateLabels
{
    [self.footerView updateLabels];
    [self.headerView updateLabels];
}

- (void)clearTableViewSelections
{
    // Deselect any table view rows
    for (NSIndexPath *indexPath in self.marketView.tableView.indexPathsForSelectedRows)
    {
        [self.marketView.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }

    // Make sure no buttons are still selected
    self.buttonRowView.selectedItem = nil;
    [self.buttonRowView updateButtons];
}

- (void)startNewDay
{
    self.game.daysLeft -= 1;
    
    [self applyInterestToSavings];
    [self applyInterestToDebt];
    
    [self clearTableViewSelections];
    
    [self updateData];
    [self updateLabels];
    
    [self.messageView updateLabels];
    
    if (self.game.daysLeft == 0)
    {
        [self showOverlay:LAST_DAY_TAG withInfo:nil];
        self.finishGameView.hidden = NO;
    }

    NSNumber *dayNum = [NSNumber numberWithInt:(self.game.gameLength - self.game.daysLeft + 1)];

    // If the current day is in the game's police days array, show the police
    if ([self.game.policeDays containsObject:dayNum]) {
        [self showOverlay:POLICE_TAG withInfo:nil];
    }
    else if ([self.game.muggingDays containsObject:dayNum]) {
        [self showOverlay:MUGGING_TAG withInfo:nil];
    }

}

- (void)resetGame
{
    NSLog(@"Resetting game");
    [self deleteSavedFile];
    self.gameInProgress = NO;
}

- (void)applyInterestToSavings
{
    int interestAmount = self.player.savings * (1/self.player.interestRateSavings);
    self.player.savings += round(interestAmount/self.game.gameLength);
}

- (void)applyInterestToDebt
{
    int interestAmount = self.player.debt * (1/self.player.interestRateDebt);
    self.player.debt += round(interestAmount);
}

- (void)configureGameWithLength:(int)length difficulty:(int)difficulty
{
    [self.game configureWithLength:length difficulty:difficulty];
    [self.player configureWithDifficulty:difficulty];
    [self.mapView updateImageForLocation:self.player.location];
    [self.finishGameView setHidden:YES];
    [self updateSpecialLocation:self.player.location];
    
    self.gameInProgress = YES;
    NSLog(@"setting gameInProgress YES");
}

- (void)generateData
{
    NSString *pathStr = [[NSBundle mainBundle] bundlePath];
    NSString *filePath = [pathStr stringByAppendingPathComponent:@"Items.plist"];
    NSArray *data = [NSArray arrayWithContentsOfFile:filePath];
    
    for (NSDictionary *dict in data) {
        Item *item = [[Item alloc] initWithName:dict[@"name"]
                                        minPrice:[dict[@"minPrice"] intValue]
                                        maxPrice:[dict[@"maxPrice"] intValue]
                                           level:[dict[@"level"] intValue]
                                       sortOrder:[dict[@"sortOrder"] intValue]
                                      difficulty:self.game.difficulty];
        [self.itemsArray addObject:item];
    }
    
    [self updateData];
}

- (void)updateData
{
    // We have to reset availability and randomize price/qty
    for (Item *item in self.itemsArray)
    {
        item.isAvailable = YES;
        [item randomizePrice];
        [item randomizeQuantityForDifficulty:self.game.difficulty];
    }
    
    [self.itemsArray shuffle];

    // Set items as unavailable
    [(Item *)self.itemsArray[self.itemsArray.count-1] setIsAvailable:NO];

    if (self.game.difficulty == 2 || self.game.difficulty == 3)
    {
        [(Item *)self.itemsArray[self.itemsArray.count-2] setIsAvailable:NO];
    }

    if (self.game.difficulty == 3)
    {
        [(Item *)self.itemsArray[self.itemsArray.count-3] setIsAvailable:NO];
    }
    
    [self.marketView.tableView reloadData];
}

- (void)updateSpecialLocation:(NSString *)newLocation
{
    // Manhattan - Guns 1001
    // Queens - Loan Shark 1002
    // Staten Island - Doctor 1003
    // Brooklyn - Bank 1004
    // The Bronx - Auto Shop 1005
    
    if ([newLocation isEqualToString:@"Manhattan"]) {
        [self.buttonRowView updateSpecialButtonWithTitle:@"Visit Gun Shop" withTag:1001];
    }
    else if ([newLocation isEqualToString:@"Queens"]) {
        [self.buttonRowView updateSpecialButtonWithTitle:@"Visit Loan Shark" withTag:1002];
    }
    else if ([newLocation isEqualToString:@"Staten Island"]) {
        [self.buttonRowView updateSpecialButtonWithTitle:@"Visit Doctor" withTag:1003];
    }
    else if ([newLocation isEqualToString:@"Brooklyn"]) {
        [self.buttonRowView updateSpecialButtonWithTitle:@"Visit Bank" withTag:1004];
    }
    else if ([newLocation isEqualToString:@"The Bronx"]) {
        [self.buttonRowView updateSpecialButtonWithTitle:@"Visit Garage" withTag:1005];
    }
}

#pragma mark Finish Game View Delegate

- (void)finishGameViewDidClickFinish
{
    [self resetGame];
    [self showOverlay:END_GAME_TAG withInfo:nil];
}

#pragma mark End Game Overlay View Delegate

- (void)endGameOverlayDidClickStartNewGame
{
    [self hideOverlay];
    [self showOverlay:NEW_GAME_TAG withInfo:nil];
}

#pragma mark Mugging Overlay View Delegate

- (void)muggingOverlayDidClickOkay
{
    [self hideOverlay];
}

- (void)muggingOverlayDidGetMugged:(int)cashLost
{
    [self.player loseMoney:cashLost];
    [self updateLabels];
}

#pragma mark Police Overlay View Delegate

- (void)policeOverlayDidClickOkay
{
    [self updateLabels];
    [self.marketView.tableView reloadData];
    [self hideOverlay];
    
    if (self.player.health <= 0) {
        [self resetGame];
        [self showOverlay:END_GAME_TAG withInfo:nil];
    }
}

#pragma mark Gun Overlay View Delegate

- (void)shouldUpgradeWeaponWithPower:(int)power forCost:(int)cost
{
    [self.player upgradeWeaponWithPower:power forCost:cost];
}

- (void)gunsOverlayDidClickDone
{
    [self hideOverlay];
}

- (void)gunsOverlayDidClickCancel
{
    [self hideOverlay];
}

#pragma mark Gamble Overlay View Delegate

- (void)shouldCompleteWager:(int)amount
{
    self.player.cash += amount;
    [self updateLabels];
}

- (void)gambleOverlayDidClickDone
{
    [self hideOverlay];
}

- (void)gambleOverlayDidClickCancel
{
    [self hideOverlay];
}

#pragma mark Loan Overlay View Delegate

- (void)loanOverlayDidClickOkay
{
    [self hideOverlay];
}

- (void)loanOverlayDidClickCancel
{
    [self hideOverlay];
}

- (void)shouldBorrowAmount:(int)amount atRate:(float)rate
{
    [self.player borrowMoney:amount atRate:rate];
    [self updateLabels];
}

- (void)shouldRepayAmount:(int)amount
{
    [self.player repayMoney:amount];
    [self updateLabels];
}

#pragma mark Travel Overlay View Delegate

- (void)shouldTravelToLocation:(NSString *)newLocation
{
    self.player.location = newLocation;
    [self.mapView updateImageForLocation:newLocation];
    [self updateSpecialLocation:newLocation];
    [self startNewDay];
}

- (void)travelOverlayDidClickOkay
{
    [self hideOverlay];
}

- (void)travelOverlayDidClickCancel
{
    [self hideOverlay];
}

#pragma mark Buy Overlay View Delegate

- (void)shouldBuyItem:(Item *)item withQuantity:(int)quantity
{
    [self.player purchaseItem:item atQuantity:quantity];

    // Decrement the available items
    item.qty -= quantity;
    [self.marketView.tableView reloadData];
    [self.buttonRowView updateButtons];
}

- (void)buyOverlayDidClickOkay
{
    [self hideOverlay];
}

- (void)buyOverlayDidClickCancel
{
    [self hideOverlay];
}

#pragma mark Sell Overlay View Delegate

- (void)shouldSellItem:(Item *)item withQuantity:(int)quantity
{
    [self.player sellItem:item atQuantity:quantity];

    // Increment the available items
    item.qty += quantity;
    [self.marketView.tableView reloadData];
    [self.buttonRowView updateButtons];
}

- (void)sellOverlayDidClickOkay
{
    [self hideOverlay];
}

- (void)sellOverlayDidClickCancel
{
    [self hideOverlay];
}

#pragma mark Drop Overlay View Delegate

- (void)shouldDropItem:(Item *)item withQuantity:(int)quantity
{
    [self.player dropItem:item atQuantity:quantity];
    
    // Increment the available items
    item.qty += quantity;
    [self.marketView.tableView reloadData];
    [self.buttonRowView updateButtons];
}

- (void)dropOverlayDidClickOkay
{
    [self hideOverlay];
}

- (void)dropOverlayDidClickCancel
{
    [self hideOverlay];
}

#pragma mark Prices Overlay View Delegate

- (void)pricesOverlayDidClickDone
{
    [self hideOverlay];
}

#pragma mark Map View Delegate

- (void)didTapMapLocation:(NSString *)location
{
    NSDictionary *infoDict = @{@"location":location};
    [self showOverlay:TRAVEL_TAG withInfo:infoDict];
}

- (void)shouldFinishGame
{
    [self hideOverlay];
    [self resetGame];
    [self showOverlay:END_GAME_TAG withInfo:nil];
}

#pragma mark Doctor Overlay View Delegate

- (void)shouldHealNumberOfPoints:(int)numPoints forCost:(int)cost
{
    [self.player healForPoints:numPoints forCost:cost];
    [self updateLabels];
}

- (void)doctorOverlayDidClickDone
{
    [self hideOverlay];
}

#pragma mark Last Day Overlay View Delegate

- (void)lastDayOverlayDidClickDone
{
    [self hideOverlay];
}

#pragma mark New Game Overlay View Delegate

- (void)shouldResetGame
{
    [self resetGame];
}

- (void)shouldStartNewGameWithLength:(int)length difficulty:(int)difficulty
{
    [self configureGameWithLength:length difficulty:difficulty];
    [self updateData];
    [self updateLabels];
}

- (void)newGameOverlayDidClickOkay
{
    [self hideOverlay];
}

#pragma mark Bank Overlay View Delegate

- (void)shouldWithdrawMoney:(int)amount
{
    self.player.savings -= amount;
    self.player.cash += amount;
    [self updateLabels];
}

- (void)shouldDepositMoney:(int)amount
{
    self.player.cash -= amount;
    self.player.savings += amount;
    [self updateLabels];
}

- (void)bankOverlayDidClickDone
{
    [self hideOverlay];
}

#pragma mark Garage Overlay View Delegate
- (void)shouldUpgradeVehicleWithInventorySize:(int)size forCost:(int)cost
{
    [self.player upgradeInventorySpace:size forCost:cost];
    [self updateLabels];
}

- (void)garageOverlayDidClickOkay
{
    [self hideOverlay];
}

- (void)garageOverlayDidClickCancel
{
    [self hideOverlay];
}

#pragma mark Pause Overlay View Delegate

- (void)pauseOverlayDidClickResume
{
    [self hideOverlay];
}

- (void)pauseOverlayDidClickNewGame
{
    [self hideOverlay];
    [self resetGame];
    [self showOverlay:NEW_GAME_TAG withInfo:nil];
}

#pragma mark Button Row View Delegate

- (void)didTapBuyButton
{
    NSIndexPath *indexPath = self.marketView.tableView.indexPathForSelectedRow;
    Item *item = self.itemsArray[indexPath.row];
    NSDictionary *infoDict = @{@"item": item};
    [self showOverlay:MARKET_BUY_TAG withInfo:infoDict];
}

- (void)didTapPricesButton
{
    NSDictionary *infoDict = @{@"items": self.itemsArray};
    [self showOverlay:PRICES_TAG withInfo:infoDict];
}

- (void)didTapSellButton
{
    NSIndexPath *indexPath = self.marketView.tableView.indexPathForSelectedRow;
    Item *item = self.itemsArray[indexPath.row];
    NSDictionary *infoDict = @{@"item": item};
    [self showOverlay:MARKET_SELL_TAG withInfo:infoDict];
}

- (void)didTapDropButton
{
    NSIndexPath *indexPath = self.marketView.tableView.indexPathForSelectedRow;
    Item *item = self.itemsArray[indexPath.row];
    NSDictionary *infoDict = @{@"item": item};
    [self showOverlay:MARKET_DROP_TAG withInfo:infoDict];
}

- (void)didTapSpecialButton
{
    int tagNum = self.buttonRowView.specialButton.tag;
    [self showOverlay:tagNum withInfo:nil];
}

- (void)didTapGambleButton
{
    [self showOverlay:GAMBLE_TAG withInfo:nil];
}

#pragma mark Base Overlay View Delegate

- (void)shouldHideOverlay
{
    [self hideOverlay];
    [self.buttonRowView updateButtons];
}

#pragma mark Overlay Handlers

- (void)showOverlay:(int)tag withInfo:(NSDictionary *)infoDict
{    
    NSString *nibName;
    switch (tag) {
        case GUNS_TAG:
            nibName = @"GunsOverlayView";
            break;
        case LOAN_TAG:
            nibName = @"LoanOverlayView";
            break;
        case DOCTOR_TAG:
            nibName = @"DoctorOverlayView";
            break;
        case GAMBLE_TAG:
            nibName = @"GambleOverlayView";
            break;
        case BANK_TAG:
            nibName = @"BankOverlayView";
            break;
        case GARAGE_TAG:
            nibName = @"GarageOverlayView";
            break;
        case MARKET_BUY_TAG:
            nibName = @"BuyOverlayView";
            break;
        case MARKET_SELL_TAG:
            nibName = @"SellOverlayView";
            break;
        case MARKET_DROP_TAG:
            nibName = @"DropOverlayView";
            break;
        case SETTINGS_TAG:
            nibName = @"SettingsOverlayView";
            break;
        case TRAVEL_TAG:
            nibName = @"TravelOverlayView";
            break;
        case DROP_TAG:
            nibName = @"DropOverlayView";
            break;
        case PRICES_TAG:
            nibName = @"PricesOverlayView";
            break;
        case NEW_GAME_TAG:
            nibName = @"NewGameOverlayView";
            break;
        case PAUSE_TAG:
            nibName = @"PauseOverlayView";
            break;
        case LAST_DAY_TAG:
            nibName = @"LastDayOverlayView";
            break;
        case END_GAME_TAG:
            nibName = @"EndGameOverlayView";
            break;
        case POLICE_TAG:
            nibName = @"PoliceOverlayView";
            break;
        case MUGGING_TAG:
            nibName = @"MuggingOverlayView";
            break;
    }
    
    if (nibName != nil)
    {
        // This is the background view that is full-sized and semi-opaque.
        greyedOutView = [[UIView alloc] initWithFrame:self.view.bounds];
        greyedOutView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];

        overlayView = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] lastObject];
        overlayView.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
        overlayView.delegate = self;
        overlayView.player = self.player;
        overlayView.game = self.game;
        overlayView.infoDict = infoDict;

        [self.view addSubview:greyedOutView];
        [self.view addSubview:overlayView];
    }

}

- (void)hideOverlay
{
    [overlayView removeFromSuperview];
    [greyedOutView removeFromSuperview];

    [self clearTableViewSelections];
    [self updateLabels];
}

- (IBAction)pauseButtonClick:(id)sender
{
    [self showOverlay:PAUSE_TAG withInfo:nil];
}

- (IBAction)settingsButtonClick:(id)sender
{
    [self showOverlay:SETTINGS_TAG withInfo:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MarketCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    Item *item = [self.itemsArray objectAtIndex:indexPath.row];
    
    cell.itemLabel.text = item.name;
    
    if (item.isAvailable)
    {
        cell.priceLabel.text = [NSString stringWithFormat:@"$%d", item.price];
        cell.qtyLabel.text = [NSString stringWithFormat:@"%d", item.qty];
    }
    else
    {
        cell.priceLabel.text = @"-";
        cell.qtyLabel.text = @"-";
    }
    
    int count = [self.player countItemsForName:item.name];
    cell.ownedLabel.text = [NSString stringWithFormat:@"%d", count];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Item *item = self.itemsArray[indexPath.row];
    self.buttonRowView.selectedItem = item;
    [self.buttonRowView updateButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark data saving/restoring methods

- (BOOL)savedFileExists
{
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:self.savedFilePath];
    NSLog(@"Checking if saved file exists: %@", (fileExists ? @"YES" : @"NO"));
    return [[NSFileManager defaultManager] fileExistsAtPath:self.savedFilePath];
}

- (void)deleteSavedFile
{
    NSLog(@"Trying to delete saved file");
    if ([self savedFileExists]) {
        NSLog(@"Deleting saved file");
        [[NSFileManager defaultManager] removeItemAtPath:self.savedFilePath error:nil];
    }
}

- (void)saveData
{
    NSLog(@"Saving data file");
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];

    [archiver encodeObject:self.game forKey:@"game"];
    [archiver encodeObject:self.player forKey:@"player"];
    [archiver encodeObject:self.itemsArray forKey:@"itemsArray"];
    [archiver finishEncoding];

    [data writeToFile:self.savedFilePath atomically:YES];
}

- (void)loadData
{
    NSLog(@"Loading data file");
    
    NSMutableData *data = [[NSMutableData alloc] initWithContentsOfFile:self.savedFilePath];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];

    self.player = [unarchiver decodeObjectForKey:@"player"];
    self.game = [unarchiver decodeObjectForKey:@"game"];
    self.itemsArray = [unarchiver decodeObjectForKey:@"itemsArray"];

    // Make sure the game in marked as in progress
    self.gameInProgress = YES;
    
    self.mapView.player = self.player;
    self.footerView.player = self.player;
    self.headerView.player = self.player;
    self.messageView.player = self.player;
    self.buttonRowView.player = self.player;
    self.headerView.game = self.game;
    self.messageView.game = self.game;
    
    [self.mapView updateImageForLocation:self.player.location];
    [self updateSpecialLocation:self.player.location];
    
    [self.marketView.tableView reloadData];
    
    // If it's the last day, show the finish game screen
    if (self.game.daysLeft == 0)
    {
        [self showOverlay:LAST_DAY_TAG withInfo:nil];
        self.finishGameView.hidden = NO;
    }
    
    [unarchiver finishDecoding];
    [self updateLabels];

    // Set a flag to let the view controller know that a file was loaded
    self.gameWasLoaded = YES;
}

@end
