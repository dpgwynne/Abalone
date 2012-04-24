//
//  Move.m
//  Abalone
//
//  Created by David Gwynne on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Move.h"

@implementation Move
@synthesize From = _from, To = _to;

- (id) initWithFrom:(Coordinate*)from To:(Coordinate*)to
{
    if (self = [super init])
    {
        self.From = from;
        self.To   = to;
    }
    
    return self;
}

@end
