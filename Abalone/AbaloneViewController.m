//
//  AbaloneViewController.m
//  Abalone
//
//  Created by David Gwynne on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AbaloneViewController.h"

@implementation AbaloneViewController
{
    AbaloneModel* abaloneModel;
    AbaloneView* abaloneView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    abaloneModel = [[AbaloneModel alloc] initWithDelegate:self];
    
    abaloneView = [[AbaloneView alloc] initWithFrame:CGRectMake(0, 0, 700, 700) andDelegate:self];
    
    [self.view addSubview:abaloneView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (int) getContentAtCoordinate:(Coordinate*) coord;
{
    return [abaloneModel getContentAtCoordinate:coord];
}

- (void) tryMoves:(NSArray *)moves
{
    [abaloneModel tryMoves:moves];
}

- (void) doMoves:(NSArray*) moves;
{
    [abaloneView doMoves:moves];
}

@end
