//
//  AbaloneViewController.h
//  Abalone
//
//  Created by David Gwynne on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbaloneView.h"
#import "AbaloneModel.h"

@interface AbaloneViewController : UIViewController <AbaloneModelDelegate, AbaloneViewDelegate>
- (int) getContentAtCoordinate:(Coordinate*) coord;
- (void) tryMoves:(NSArray *)moves;
- (void) doMoves:(NSArray*) moves;
@end
