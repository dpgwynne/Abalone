//
//  Coordinate.m
//  Abalone
//
//  Created by David Gwynne on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Coordinate.h"

@implementation Coordinate
@synthesize X = _x, Y = _y;

- (id) initWithX:(int)x Y:(int)y
{
    if (self = [super init])
    {
        self.X = x;
        self.Y = y;
    }
    
    return self;
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"Coordinate %d,%d", self.X, self.Y];
}

@end
