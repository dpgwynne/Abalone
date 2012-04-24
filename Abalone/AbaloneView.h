//
//  AbaloneView.h
//  Abalone
//
//  Created by David Gwynne on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coordinate.h"
#import "Move.h"

@protocol AbaloneViewDelegate
- (int) getContentAtCoordinate:(Coordinate*) coord;
- (void) tryMoves:(NSArray*) moves;
@end

@interface AbaloneView : UIView
@property (nonatomic, assign) id<AbaloneViewDelegate> delegate;
- (id) initWithFrame:(CGRect)frame andDelegate:(id<AbaloneViewDelegate>) del;
- (void) doMoves:(NSArray*) moves;
@end
