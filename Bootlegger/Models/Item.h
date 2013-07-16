//
//  Item.h
//  RumRunner
//
//  Created by Scott Newman on 5/3/13.
//  Copyright (c) 2013 Scott Newman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject <NSCoding>
{
    NSString *name;
    int price;
    int qty;
    int sortOrder;
    int maxPrice;
    int minPrice;
    int level;
    BOOL isAvailable;
}

@property (nonatomic, retain) NSString *name;
@property int price;
@property int qty;
@property int sortOrder;
@property int maxPrice;
@property int minPrice;
@property int level;
@property BOOL isAvailable;

- (id)initWithName:(NSString *)name minPrice:(int)minP maxPrice:(int)maxP level:(int)theLevel sortOrder:(int)order difficulty:(int)difficulty;
- (void)randomizePrice;
- (void)randomizeQuantityForDifficulty:(int)difficulty;
- (int)randomIntFromRangeMin:(int)min max:(int)max;

@end
