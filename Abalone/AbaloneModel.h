//
//  AbaloneModel.h
//  Abalone
//
//  Created by David Gwynne on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Coordinate.h"
#import "Move.h"

@protocol AbaloneModelDelegate
- (void) doMoves:(NSArray*) moves;
@end

@interface AbaloneModel : NSObject

@property (nonatomic, assign) id<AbaloneModelDelegate> delegate;

- (id) initWithDelegate:(id<AbaloneModelDelegate>) del;
- (int) getContentAtCoordinate:(Coordinate*) coord;
- (void) tryMoves:(NSArray*) moves;

@end
