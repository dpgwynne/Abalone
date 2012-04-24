//
//  Move.h
//  Abalone
//
//  Created by David Gwynne on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinate.h"

@interface Move : NSObject

@property (retain, strong)  Coordinate* From;
@property (retain, strong)  Coordinate* To;

- (id) initWithFrom:(Coordinate*)from To:(Coordinate*)to;

@end
