//
//  Coordinate.h
//  Abalone
//
//  Created by David Gwynne on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coordinate : NSObject

@property (assign) int X;
@property (assign) int Y;

- (id) initWithX:(int)x Y:(int)y;

@end
