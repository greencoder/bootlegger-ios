//
//  Player.m
//  RumRunner
//
//  Created by Scott Newman on 4/26/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "Player.h"
#import "Item.h"

@implementation Player

@synthesize location = _location;
@synthesize health = _health;
@synthesize cash = _cash;
@synthesize debt = _debt;
@synthesize savings = _savings;
@synthesize interestRateSavings = _interestRateSavings;
@synthesize interestRateDebt = _interestRateDebt;
@synthesize capacity = _capacity;
@synthesize items = _items;
@synthesize offensivePower = _offensivePower;

- (id)initWithDifficulty:(int)difficulty
{
    self = [super init];
    if (self)
    {
        [self configureWithDifficulty:difficulty];
    }
    return self;
}

- (void)configureWithDifficulty:(int)difficulty
{
    self.location = @"Queens";
    self.items = [[NSMutableDictionary alloc] initWithCapacity:10];
    self.health = 100;
    self.debt = 0;
    self.savings = 0;
    self.offensivePower = 0;
    self.interestRateSavings = 2.5f;
    self.interestRateDebt = 5.0f;

    if (difficulty == 1) {
        self.cash = 2500;
        self.capacity = 25;
    }
    else if (difficulty == 2) {
        self.cash = 2000;
        self.capacity = 20;
    }
    else {
        self.cash = 1500;
        self.capacity = 15;
    }
}

- (void)upgradeInventorySpace:(int)space forCost:(int)cost
{
    if (space > self.capacity) {
        self.capacity = space;
        self.cash -= cost;
    }
}

- (void)borrowMoney:(int)amount atRate:(float)rate
{
    self.cash += amount;
    self.debt += amount;
    self.interestRateDebt = rate;
}

- (void)repayMoney:(int)amount
{
    self.cash -= amount;
    self.debt -= amount;
}

- (void)loseMoney:(int)amount
{
    self.cash -= amount;
}

- (void)upgradeWeaponWithPower:(int)power forCost:(int)cost
{
    NSLog(@"in Player.m upgrading weapon: %d, $%d", power, cost);

    // Decrement cash
    self.cash -= cost;
    self.offensivePower = power;
}

- (void)healForPoints:(int)numPoints forCost:(int)cost
{
    self.cash -= cost;
    self.health += numPoints;

    if (self.health > 100) {
        self.health = 100;
    }
}

- (void)purchaseItem:(Item *)item atQuantity:(int)qty
{
    // Decrement cash
    self.cash -= (item.price * qty);

    // If they already have the item, count how many they have
    int curQuantity = 0;
    if ([self.items objectForKey:item.name]) {
        curQuantity = [[self.items objectForKey:item.name] integerValue];
    }
    
    // Update their inventory
    NSNumber *newQuantity = [NSNumber numberWithInt:(curQuantity + qty)];
    [self.items setObject:newQuantity forKey:item.name];
    
}

- (void)sellItem:(Item *)item atQuantity:(int)qty
{
    // Increment cash
    self.cash += (item.price * qty);
    
    // If they already have the item, count how many they have
    int curQuantity = 0;
    if ([self.items objectForKey:item.name]) {
        curQuantity = [[self.items objectForKey:item.name] integerValue];
    }
    
    // Update their inventory
    NSNumber *newQuantity = [NSNumber numberWithInt:(curQuantity - qty)];

    if (newQuantity.integerValue > 0) {
        [self.items setObject:newQuantity forKey:item.name];
    }
    else {
        [self.items removeObjectForKey:item.name];
    }
}

- (void)dropItem:(Item *)item atQuantity:(int)qty
{
    // Count how many they have
    int curQuantity = 0;
    if ([self.items objectForKey:item.name]) {
        curQuantity = [[self.items objectForKey:item.name] integerValue];
    }
    
    // Update their inventory
    NSNumber *newQuantity = [NSNumber numberWithInt:(curQuantity - qty)];

    if (newQuantity.integerValue > 0) {
        [self.items setObject:newQuantity forKey:item.name];
    }
    else {
        [self.items removeObjectForKey:item.name];
    }
}

- (NSString *)dropRandomItemsWithDifficulty:(int)difficulty
{
    NSSet *itemsSet = [NSSet setWithArray:[self.items allKeys]];
    
    // Pick one of the items at random and drop 15, 30, or 45% of them
    NSString *key = [itemsSet anyObject];
    NSNumber *qty = [self.items objectForKey:key];
    int dropAmount = ceil(qty.floatValue * (difficulty * 0.15));
    
    // Remove the items from inventory
    int newQty = qty.integerValue - dropAmount;
    
    if (newQty < 1) {
        [self.items removeObjectForKey:key];
    }
    else {
        [self.items setObject:[NSNumber numberWithInt:newQty] forKey:key];
    }
    
    // pluralize "units" if the dropped amount is greater than one
    NSString *label = @"cases";
    if (dropAmount == 1) {
        label = @"case";
    }
    
    NSString *result = [NSString stringWithFormat:@"You lost %d %@ of %@ while running away.",
                        dropAmount, label, key];
    return result;
}

- (int)fightPoliceWithDifficulty:(int)difficulty
{
    NSArray *maxDamages = @[@40,@30,@20,@10];
    
    NSLog(@"Difficulty: %d", difficulty);
    NSLog(@"Offensive Power: %d", self.offensivePower);
    
    // max damage: 30,40,50 (depending on offensive power)
    int maxD = [[maxDamages objectAtIndex:self.offensivePower] integerValue];
    
    int damage = [self randomIntFromRangeMin:0 max:maxD];
    return damage;
}

- (int)countAllItems
{
    int count = 0;
    for (NSString *key in self.items)
    {
        NSNumber *qty = [self.items objectForKey:key];
        count += qty.integerValue;
    }
    return count;
}

- (int)countItemsForName:(NSString *)name
{
    int count = 0;
    if ([self.items objectForKey:name]) {
        count = [(NSNumber *)[self.items objectForKey:name] integerValue];
    }
    return count;
}

- (int)inventorySpaceAvailable
{
    return self.capacity - [self countAllItems];
}

- (int)randomIntFromRangeMin:(int)min max:(int)max
{
    return round(((float)arc4random() / 0x100000000 * (max - min)) + min);
}

#pragma mark init with coder

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.items forKey:@"items"];
    [aCoder encodeObject:self.location forKey:@"location"];
    [aCoder encodeInt:self.health forKey:@"health"];
    [aCoder encodeInt:self.cash forKey:@"cash"];
    [aCoder encodeInt:self.debt forKey:@"debt"];
    [aCoder encodeInt:self.savings forKey:@"savings"];
    [aCoder encodeInt:self.capacity forKey:@"capacity"];
    [aCoder encodeInt:self.offensivePower forKey:@"offensivePower"];
    [aCoder encodeFloat:self.interestRateSavings forKey:@"interestRateSavings"];
    [aCoder encodeFloat:self.interestRateDebt forKey:@"interestRateDebt"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        [self setItems:[aDecoder decodeObjectForKey:@"items"]];
        [self setLocation:[aDecoder decodeObjectForKey:@"location"]];
        [self setHealth:[aDecoder decodeIntForKey:@"health"]];
        [self setCash:[aDecoder decodeIntForKey:@"cash"]];
        [self setDebt:[aDecoder decodeIntForKey:@"debt"]];
        [self setSavings:[aDecoder decodeIntForKey:@"savings"]];
        [self setCapacity:[aDecoder decodeIntForKey:@"capacity"]];
        [self setOffensivePower:[aDecoder decodeIntForKey:@"offensivePower"]];
        [self setInterestRateSavings:[aDecoder decodeFloatForKey:@"interestRateSavings"]];
        [self setInterestRateDebt:[aDecoder decodeFloatForKey:@"interestRateDebt"]];
    }
    return self;
}

@end
