//
//  AbaloneView.m
//  Abalone
//
//  Created by David Gwynne on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AbaloneView.h"
#import "AbaloneSubView.h"
#import <UIKit/UIKit.h>

@implementation AbaloneView
{
    //Coordinate* pressedCoordinate;
    
    CFMutableDictionaryRef touchedCoordinates;
    NSMutableArray* movesSoFar;
}

@synthesize delegate = _delegate;

- (void)initialise:(id<AbaloneViewDelegate>) del
{
    self.delegate = del;
    
    touchedCoordinates = CFDictionaryCreateMutable(NULL, 0, NULL, NULL);
    
    [self setMultipleTouchEnabled:YES];
    
    float xBorder = 50;
    float yBorder = 50;
    
    float xDelta = 1;
    float yDelta = sqrt(0.75);
    
    float width  = (self.frame.size.width - xBorder * 2.0)  / (9.0 * xDelta);
    float height = (self.frame.size.height - yBorder * 2.0) / (9.0 * yDelta);
    
    for (int y = 0; y < 9; y++)
    {
        float xOffset = (5 - y) * 0.5 * width;
        
        for (int x = 0; x < 9; x++)
        {
            int content = -1;
            
            if(self.delegate != nil)
            {
                content = [self.delegate getContentAtCoordinate:[[Coordinate alloc] initWithX:x Y:y]];
            }
            
            if(content == 0 || content == 1 || content == 2)
            {
                AbaloneSubView* imageView = [[AbaloneSubView alloc] initWithFrame:CGRectMake(xBorder + xOffset + x * width * xDelta,
                                                                                    yBorder + y * height * yDelta,
                                                                                    width,
                                                                                    height) Content:0 X:x Y:y];
                
                [self addSubview:imageView];

                if(content != 0)
                {
                    AbaloneSubView* imageView = [[AbaloneSubView alloc] initWithFrame:CGRectMake(xBorder + xOffset + x * width * xDelta,
                                                                                                 yBorder + y * height * yDelta,
                                                                                                 width,
                                                                                                 height) Content:content X:x Y:y];
                    
                    [self addSubview:imageView];
                }
            }
        }
    }
    
    for (UIView* view in self.subviews)
    {
        if([view isMemberOfClass:[AbaloneSubView class]])
        {
            if(((AbaloneSubView*)view).Content != 0)
            {
                [self bringSubviewToFront:view];
            }
        }
    }
}

- (id) initWithFrame:(CGRect)frame andDelegate:(id<AbaloneViewDelegate>) del
{
    if (self = [super initWithFrame:frame]) {
        [self initialise:del];
    }
    return self;
}

-(Coordinate*) findCoordinateAtPoint:(CGPoint) point
{
    Coordinate* coord;
    
    for (UIView* view in self.subviews)
    {
        if([view isMemberOfClass:[AbaloneSubView class]] && CGRectContainsPoint(view.frame, point))
        {
            AbaloneSubView* abaloneView = (AbaloneSubView*)view;
            
            if(coord == nil)
            {
                coord = [[Coordinate alloc] initWithX:abaloneView.X Y:abaloneView.Y];
                
            }
            else if(coord.X != abaloneView.X || coord.Y != abaloneView.Y)
            {
                coord = nil;
                break;
            }
        }
    }
    
    return coord;
}

-(AbaloneSubView*) findPieceAtCoordinate:(Coordinate*) coord
{
    AbaloneSubView* returnView;
    
    for (UIView* view in self.subviews)
    {
        if([view isMemberOfClass:[AbaloneSubView class]])
        {
            AbaloneSubView* abaloneView = (AbaloneSubView*)view;
            
            if(coord.X == abaloneView.X && coord.Y == abaloneView.Y && abaloneView.Content != 0)
            {
                returnView = abaloneView;
            }
        }
    }
    
    return returnView;
}

-(AbaloneSubView*) findNonPieceAtCoordinate:(Coordinate*) coord
{
    AbaloneSubView* returnView;
    
    for (UIView* view in self.subviews)
    {
        if([view isMemberOfClass:[AbaloneSubView class]])
        {
            AbaloneSubView* abaloneView = (AbaloneSubView*)view;
            
            if(coord.X == abaloneView.X && coord.Y == abaloneView.Y && abaloneView.Content == 0)
            {
                returnView = abaloneView;
            }
        }
    }
    
    return returnView;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//UITouch *touch = [[event allTouches] anyObject];
	// Get the touch location and note the location for later use to 
	//CGPoint touchLocation = [touch locationInView:self];
    
    //pressedCoordinate = [self findCoordinateAtPoint:touchLocation];
    
    for (UITouch* touch in touches)
    {
        CGPoint touchLocation = [touch locationInView:self];
        
        Coordinate* pressedCoordinate = [self findCoordinateAtPoint:touchLocation];
        
        if(pressedCoordinate)
        {
            CFDictionarySetValue(touchedCoordinates, (__bridge_retained void*)touch, (__bridge_retained void*)pressedCoordinate);
        }
    }
}

-(int) sign:(int)value
{
    if(value > 0)
    {
        return 1;
    }
    else if (value < 0)
    {
        return -1;
    }
    else
    {
        return 0;
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{    
    //NSLog(@"touchesEnded called with touches containing %d touches.", [touches count]);
    //NSLog(@"touchesEnded called with event containing %d touches.", [[event touchesForView:self] count]);
    
    if(!movesSoFar)
    {
        movesSoFar = [NSMutableArray array];
    }
    
    for (UITouch* touch in touches)
    {
        Coordinate* pressedCoordinate = (__bridge Coordinate *)CFDictionaryGetValue(touchedCoordinates, (__bridge_retained void*)touch);
        
        if(pressedCoordinate)
        {
            CGPoint touchLocation = [touch locationInView:self];

            Coordinate* releasedCoordinate = [self findCoordinateAtPoint:touchLocation];
            releasedCoordinate.X = pressedCoordinate.X + [self sign:(releasedCoordinate.X - pressedCoordinate.X)];
            releasedCoordinate.Y = pressedCoordinate.Y + [self sign:(releasedCoordinate.Y - pressedCoordinate.Y)];
            
            if(releasedCoordinate)
            {
                [movesSoFar addObject:[[Move alloc] initWithFrom:pressedCoordinate To:releasedCoordinate]];
            }
            
            CFDictionaryRemoveValue(touchedCoordinates, (__bridge_retained void*)touch);
        }
    }
    
    if([touches count] == [[event touchesForView:self] count])
    {
        //This is the last touch
        if([movesSoFar count] > 0)
        {
            [self.delegate tryMoves:movesSoFar];
        }

        [movesSoFar removeAllObjects];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch* touch in touches)
    {
        CFDictionaryRemoveValue(touchedCoordinates, (__bridge_retained void*)touch);
    }
    
    [movesSoFar removeAllObjects];
}

- (void) doMoves:(NSArray*) moves
{
    for (Move* move in moves)
    {
        if([move isMemberOfClass:[Move class]])
        {
            AbaloneSubView* piece = [self findPieceAtCoordinate:move.From];
            AbaloneSubView* nonPiece = [self findNonPieceAtCoordinate:move.To];
    
            [self bringSubviewToFront:piece];
    
            [UIView transitionWithView:self
                              duration:0.5
                               options:UIViewAnimationOptionTransitionNone
                            animations:^{piece.frame = nonPiece.frame;}
                            completion:NULL];
        }
    }
    
    for (Move* move in moves)
    {
        if([move isMemberOfClass:[Move class]])
        {
            AbaloneSubView* piece = [self findPieceAtCoordinate:move.From];
            AbaloneSubView* nonPiece = [self findNonPieceAtCoordinate:move.To];
            
            piece.X = nonPiece.X;
            piece.Y = nonPiece.Y;
        }
    }
}

@end
