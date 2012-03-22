//
//  ViewController.m
//  MovingShapes
//
//  Created by Jakub Suder on 3.22.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "Triangle.h"
#import "ShapeView.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)shapeViewDidTouchWithOnePoint:(HKPoint *)point {
  NSLog(@"1 point: %@", point);
}

- (void)shapeViewDidTouchWithTwoPoints:(NSArray *)points {
  NSLog(@"2 points: %@", points);
}

- (void)shapeViewDidTouchWithThreePoints:(NSArray *)points {
    NSLog(@"3 points: %@", points);

  if (triangle) {
    [triangle updatePoints: points];
  } else {
    triangle = [[Triangle alloc] initWithPoints: points];
    [(ShapeView *) self.view setTriangle: triangle];
    [self.view setNeedsDisplay];
  }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ShapeView *sv = (ShapeView *) self.view;
    sv.delegate = self;
    
	// Do any additional setup after loading the view, typically from a nib.
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
  return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
