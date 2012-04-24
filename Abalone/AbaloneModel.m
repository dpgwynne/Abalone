//
//  AbaloneModel.m
//  Abalone
//
//  Created by David Gwynne on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AbaloneModel.h"

@implementation AbaloneModel
{
    int content[9][9];
}

@synthesize delegate = _delegate;

- (id) initWithDelegate:(id<AbaloneModelDelegate>)del
{
    if (self = [super init])
    {
        self.delegate = del;
        
        for (int y = 0; y < 9; y++)
        {
            for (int x = 0; x < 9; x++)
            {
                if((y < 5 && x < 9 - abs(y - 4)) || (y >= 5 && x > abs(y - 5)))
                {
                    content[x][y] = 0;
                }
                else
                {
                    content[x][y] = -1;
                }
            }
        }
        
        content[0][0] = 1;
        content[1][0] = 1;
        content[2][0] = 1;
        content[3][0] = 1;
        content[4][0] = 1;

        content[0][1] = 1;
        content[1][1] = 1;
        content[2][1] = 1;
        content[3][1] = 1;
        content[4][1] = 1;
        content[5][1] = 1;

        content[2][2] = 1;
        content[3][2] = 1;
        content[4][2] = 1;    

    
        content[4][8] = 2;
        content[5][8] = 2;
        content[6][8] = 2;
        content[7][8] = 2;
        content[8][8] = 2;
        
        content[3][7] = 2;
        content[4][7] = 2;
        content[5][7] = 2;
        content[6][7] = 2;
        content[7][7] = 2;
        content[8][7] = 2;
        
        content[4][6] = 2;
        content[5][6] = 2;
        content[6][6] = 2;    
    }
    
    return self;
}

- (int) getContentAtCoordinate:(Coordinate*) coord;
{
    if(coord.X >= 0 && coord.X < 9 && coord.Y >=0 && coord.Y < 9)
    {
        //NSLog(@"getContentAtCoordinate returning %d", content[coord.X][coord.Y]);
        
        return content[coord.X][coord.Y];
    }
    else
    {
        //NSLog(@"getContentAtCoordinate returning %d", -1);
        
        return -1;
    }
}

-(BOOL) isDirection:(Coordinate*) delta
{
    return abs(delta.X) <= 1 &&
           abs(delta.Y) <= 1 &&
           !(delta.X == -1 && delta.Y == 1) &&
           !(delta.X == 1 && delta.Y == -1);
}

- (void) tryMoves:(NSArray*) moves
{
    NSMutableArray* movesToDo = [NSMutableArray array];
    
    if([moves count] == 1)
    {
        //NSLog(@"Moving from %d,%d to %d,%d", move.From.X, move.From.Y, move.To.X, move.To.Y);
        
        Move* move = [moves objectAtIndex:0];
            
        Coordinate* delta = [[Coordinate alloc] initWithX:move.To.X - move.From.X
                                                        Y:move.To.Y - move.From.Y];
    
        if([self isDirection:delta] &&
           ([self getContentAtCoordinate:move.From] == 1 || [self getContentAtCoordinate:move.From] == 2))
        {
            BOOL legalMove = NO;
            Coordinate* previous = move.From;
            Coordinate* current;
            
            for (int i = 1; i < 6; i++)
            {
                current = [[Coordinate alloc] initWithX:move.From.X + i * delta.X
                                                      Y:move.From.Y + i * delta.Y];
                
                [movesToDo addObject:[[Move alloc] initWithFrom:previous To:current]];
                
                if([self getContentAtCoordinate:current] == 0)
                {
                    legalMove = YES;
                    break;
                }
                
                if([self getContentAtCoordinate:current] == -1)
                {
                    legalMove = NO;
                    break;
                }
                
                previous = current;
            }
            
            if([movesToDo count] > 0 && legalMove)
            {
                for (Move* m in movesToDo)
                {
                    content[m.To.X][m.To.Y] = content[m.From.X][m.From.Y];
                }
                
                content[move.From.X][move.From.Y] = 0;
            }
        }
    }
    else if ([moves count] == 2)
    {
        Move* move0 = [moves objectAtIndex:0];
        Move* move1 = [moves objectAtIndex:1];
        
        if(([self getContentAtCoordinate:move0.From] == 1 && [self getContentAtCoordinate:move1.From] == 1) ||
           ([self getContentAtCoordinate:move0.From] == 2 && [self getContentAtCoordinate:move1.From] == 2))
        {
            //Both movements move a piece
            if([self getContentAtCoordinate:move0.To] == 0 && [self getContentAtCoordinate:move1.To] == 0)
            {
                //Both movements move to an empty coordinate
                Coordinate* delta0 = [[Coordinate alloc] initWithX:move0.To.X - move0.From.X
                                                                 Y:move0.To.Y - move0.From.Y];
                
                Coordinate* delta1 = [[Coordinate alloc] initWithX:move1.To.X - move1.From.X
                                                                 Y:move1.To.Y - move1.From.Y];
                
                if([self isDirection:delta0] && delta0.X == delta1.X && delta0.Y == delta1.Y)
                {
                    //The two movements are parallel and in a good direction?
                    Coordinate* between = [[Coordinate alloc] initWithX:move1.From.X - move0.From.X
                                                                      Y:move1.From.Y - move0.From.Y];
                    if([self isDirection:between])
                    {
                        //The two movements are next to each so just move them
                        [movesToDo addObject:move0];
                        [movesToDo addObject:move1];
                        
                        content[move0.To.X][move0.To.Y] = content[move0.From.X][move0.From.Y];                    
                        content[move0.From.X][move0.From.Y] = 0;

                        content[move1.To.X][move1.To.Y] = content[move1.From.X][move1.From.Y];
                        content[move1.From.X][move1.From.Y] = 0;
                    }
                    else
                    {
                        if(abs(between.X) == 2)
                        {
                            between.X /= 2;
                        }
                        
                        if(abs(between.Y) == 2)
                        {
                            between.Y /= 2;
                        }
                        
                        Coordinate* middleFrom = [[Coordinate alloc] initWithX:move0.From.X + between.X Y:move0.From.Y + between.Y];
                        
                        Coordinate* middleTo   = [[Coordinate alloc] initWithX:middleFrom.X + delta0.X Y:middleFrom.Y + delta0.Y];

                        Coordinate* between0 = [[Coordinate alloc] initWithX:middleFrom.X - move0.From.X
                                                                           Y:middleFrom.Y - move0.From.Y];
                        
                        Coordinate* between1 = [[Coordinate alloc] initWithX:move1.From.X - middleFrom.X
                                                                           Y:move1.From.Y - middleFrom.Y];
                        
                        
                        
                        if([self getContentAtCoordinate:middleFrom] == [self getContentAtCoordinate:move0.From] &&
                           [self getContentAtCoordinate:middleTo] == 0 &&
                           [self isDirection:between0] &&
                           [self isDirection:between1])
                        {
                            Move* middleMove = [[Move alloc] initWithFrom:middleFrom To:middleTo];
                            
                            [movesToDo addObject:move0];
                            [movesToDo addObject:middleMove];
                            [movesToDo addObject:move1];
                            
                            content[move0.To.X][move0.To.Y] = content[move0.From.X][move0.From.Y];                    
                            content[move0.From.X][move0.From.Y] = 0;
                            
                            content[middleMove.To.X][middleMove.To.Y] = content[middleMove.From.X][middleMove.From.Y];                    
                            content[middleMove.From.X][middleMove.From.Y] = 0;
                            
                            content[move1.To.X][move1.To.Y] = content[move1.From.X][move1.From.Y];
                            content[move1.From.X][move1.From.Y] = 0;
                        }
                    }
                }
            }
        }
    }
    
    if([movesToDo count] > 0)
    {    
        [self.delegate doMoves:movesToDo];
    }
}

@end