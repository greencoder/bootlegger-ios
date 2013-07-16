//
//  Item.m
//  RumRunner
//
//  Created by Scott Newman on 5/3/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import "Item.h"

#define ARC4RANDOM_MAX 0x100000000

@implementation Item

@synthesize name = _name;
@synthesize price = _price;
@synthesize qty = _qty;
@synthesize sortOrder = _sortOrder;
@synthesize maxPrice = _maxPrice;
@synthesize minPrice = _minPrice;
@synthesize level = _level;
@synthesize isAvailable = _isAvailble;

- (id)initWithName:(NSString *)aName minPrice:(int)minP maxPrice:(int)maxP level:(int)theLevel sortOrder:(int)order difficulty:(int)difficulty
{
    self = [super init];
    if (self)
    {
        self.name = aName;
        self.minPrice = minP;
        self.maxPrice = maxP;
        self.level = theLevel;
        self.sortOrder = order;

        // Generate random price and quantity
        [self randomizePrice];
        [self randomizeQuantityForDifficulty:difficulty];
    }
    return self;
}

- (int)randomIntFromRangeMin:(int)min max:(int)max
{
    return round(((float)arc4random() / 0x100000000 * (max - min)) + min);
}

- (void)randomizeQuantityForDifficulty:(int)difficulty
{
    NSArray *minQs = @[@15,@10,@5];
    NSArray *maxQs = @[@15,@25,@35];
    
    // The quantity should be between 5-35 items
    // The harder the difficulty, the lower the min qty
    // The higher the level, the higher the max qty
    int minQty = [minQs[difficulty-1] integerValue];
    int maxQty = [maxQs[self.level-1] integerValue];

    self.qty = [self randomIntFromRangeMin:minQty max:maxQty];
}

- (void)randomizePrice
{
    int newPrice = [self randomIntFromRangeMin:self.minPrice max:self.maxPrice];
    // Try not to get the same price twice
    if (newPrice == self.price) {
        newPrice = [self randomIntFromRangeMin:self.minPrice max:self.maxPrice];
    }
    self.price = newPrice;
}

#pragma mark init with coder

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt:self.price forKey:@"price"];
    [aCoder encodeInt:self.qty forKey:@"qty"];
    [aCoder encodeInt:self.sortOrder forKey:@"sortOrder"];
    [aCoder encodeInt:self.maxPrice forKey:@"maxPrice"];
    [aCoder encodeInt:self.minPrice forKey:@"minPrice"];
    [aCoder encodeInt:self.level forKey:@"level"];
    [aCoder encodeBool:self.isAvailable forKey:@"isAvailable"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        [self setName:[aDecoder decodeObjectForKey:@"name"]];
        [self setPrice:[aDecoder decodeIntForKey:@"price"]];
        [self setQty:[aDecoder decodeIntForKey:@"qty"]];
        [self setSortOrder:[aDecoder decodeIntForKey:@"sortOrder"]];
        [self setMaxPrice:[aDecoder decodeIntForKey:@"maxPrice"]];
        [self setMinPrice:[aDecoder decodeIntForKey:@"minPrice"]];
        [self setLevel:[aDecoder decodeIntForKey:@"level"]];
        [self setIsAvailable:[aDecoder decodeBoolForKey:@"isAvailable"]];
    }
    return self;
}

@end
