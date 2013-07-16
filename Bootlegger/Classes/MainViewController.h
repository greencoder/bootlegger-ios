//
//  ViewController.h
//  RumRunner
//
//  Created by Scott Newman on 4/22/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "Game.h"
#import "MarketView.h"
#import "BuyOverlayView.h"
#import "ButtonRowView.h"
#import "MapView.h"
#import "TravelOverlayView.h"
#import "PauseOverlayView.h"
#import "PricesOverlayView.h"
#import "NewGameOverlayView.h"
#import "GarageOverlayView.h"
#import "BankOverlayView.h"
#import "LoanOverlayView.h"
#import "GunsOverlayView.h"
#import "DoctorOverlayView.h"
#import "GambleOverlayView.h"
#import "FinishGameView.h"
#import "PoliceOverlayView.h"
#import "MuggingOverlayView.h"

@class BaseOverlayView;
@class FooterView;
@class HeaderView;
@class MessageView;

@interface MainViewController : UIViewController <UITableViewDataSource,
    UITableViewDelegate, ButtonRowViewDelegate, FinishGameViewDelegate,
    BuyOverlayViewDelegate, TravelOverlayViewDelegate, PricesOverlayViewDelegate,
    PauseOverlayViewDelegate, NewGameOverlayViewDelegate, BankOverlayViewDelegate,
    GarageOverlayViewDelegate, LoanOverlayViewDelegate, GunOverlayViewDelegate,
    DoctorOverlayViewDelegate, GambleOverlayViewDelegate, PoliceOverlayViewDelegate,
    MuggingOverlayViewDelegate>
{
    BaseOverlayView *overlayView;
    UIView *greyedOutView;

    NSMutableArray *itemsArray;
    Player *player;
    Game *game;
    
    BOOL gameWasLoaded;
    BOOL gameInProgress;
    NSString *savedFilePath;

    IBOutlet FooterView *footerView;
    IBOutlet MapView *mapView;
    IBOutlet HeaderView *headerView;
    IBOutlet MessageView *messageView;
    IBOutlet ButtonRowView *buttonRowView;
    IBOutlet MarketView *marketView;
    IBOutlet FinishGameView *finishGameView;
}

@property (nonatomic, retain) NSMutableArray *itemsArray;
@property (nonatomic, retain) Player *player;
@property (nonatomic, retain) Game *game;
@property BOOL gameWasLoaded;
@property BOOL gameInProgress;
@property (nonatomic, retain) NSString *savedFilePath;
@property (nonatomic, retain) MarketView *marketView;
@property (nonatomic, retain) ButtonRowView *buttonRowView;
@property (nonatomic, retain) MapView *mapView;
@property (nonatomic, retain) FooterView *footerView;
@property (nonatomic, retain) HeaderView *headerView;
@property (nonatomic, retain) MessageView *messageView;
@property (nonatomic, retain) FinishGameView *finishGameView;

- (IBAction)settingsButtonClick:(id)sender;
- (void)showOverlay:(int)tag withInfo:(NSDictionary *)infoDict;
- (void)configureGameWithLength:(int)length difficulty:(int)difficulty;
- (void)hideOverlay;
- (void)updateLabels;
- (void)updateData;
- (void)clearTableViewSelections;
- (void)updateSpecialLocation:(NSString *)newLocation;
- (void)startNewDay;
- (void)resetGame;
- (void)applyInterestToSavings;
- (void)applyInterestToDebt;
- (BOOL)savedFileExists;
- (void)deleteSavedFile;
- (void)saveData;
- (void)loadData;

@end
