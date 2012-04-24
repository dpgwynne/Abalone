//
//  AbaloneSubView.m
//  Abalone
//
//  Created by David Gwynne on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AbaloneSubView.h"

@implementation AbaloneSubView

@synthesize Content = _content, X = _x, Y = _y;

- (id)initWithFrame:(CGRect)frame Content:(int) content X:(int)x Y:(int)y
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.Content = content;
        self.X = x;
        self.Y = y;
    }
    return self;
}

- (void) setContent:(int)content
{
    _content = content;
    
    //Images from http://www.iconarchive.com/show/solar-system-icons-by-dan-wiersma.html
    if(content == 0)
    {
        self.image = [UIImage imageNamed:@"black.png"];
    }
    else if(content == 1)
    {
        self.image = [UIImage imageNamed:@"red.png"];
    }
    else
    {
        self.image = [UIImage imageNamed:@"blue.png"];
    }
}

-(int) Content
{
    return _content;
}

@end
