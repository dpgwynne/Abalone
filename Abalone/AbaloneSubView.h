//
//  AbaloneSubView.h
//  Abalone
//
//  Created by David Gwynne on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbaloneSubView : UIImageView

- (id)initWithFrame:(CGRect)frame Content:(int)content X:(int)x Y:(int)y;

@property (assign) int Content;
@property (assign) int X;
@property (assign) int Y;

@end
