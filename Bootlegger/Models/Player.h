//
//  Player.h
//  RumRunner
//
//  Created by Scott Newman on 4/26/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Item;

@interface Player : NSObject <NSCoding>
{
    NSString *location;
    NSMutableDictionary *items;
    int health;
    int cash;
    int debt;
    int savings;
    int capacity;
    int offensivePower;
    float interestRateSavings;
    float interestRateDebt;
}

@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSMutableDictionary *items;
@property int health;
@property int cash;
@property int debt;
@property int savings;
@property int capacity;
@property int offensivePower;
@property float interestRateSavings;
@property float interestRateDebt;

- (int)countAllItems;
- (int)countItemsForName:(NSString *)name;
- (int)inventorySpaceAvailable;
- (void)purchaseItem:(Item *)item atQuantity:(int)qty;
- (void)sellItem:(Item *)item atQuantity:(int)qty;
- (void)dropItem:(Item *)item atQuantity:(int)qty;
- (id)initWithDifficulty:(int)difficulty;
- (void)configureWithDifficulty:(int)difficulty;
- (void)upgradeInventorySpace:(int)space forCost:(int)cost;
- (void)upgradeWeaponWithPower:(int)power forCost:(int)cost;
- (void)borrowMoney:(int)amount atRate:(float)rate;
- (void)repayMoney:(int)amount;
- (void)loseMoney:(int)amount;
- (void)healForPoints:(int)numPoints forCost:(int)cost;
- (NSString *)dropRandomItemsWithDifficulty:(int)difficulty;
- (int)fightPoliceWithDifficulty:(int)difficulty;
- (int)randomIntFromRangeMin:(int)min max:(int)max;

@end
