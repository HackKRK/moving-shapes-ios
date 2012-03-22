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
#import "Gyroscopic.h"

@implementation ViewController

@synthesize gyroscopic = _gyroscopic;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)shapeViewDidMoveVertex: (NSInteger) vertex toPoint: (HKPoint *) point {
  NSLog(@"moved point %d: %@", vertex, point);
  NSMutableArray *points = [NSMutableArray arrayWithArray: [triangle points]];
  [points replaceObjectAtIndex: vertex withObject: point];
  [triangle updatePoints: points];
  [self.view setNeedsDisplay];
}

- (void)shapeViewDidTouchWithOnePoint:(HKPoint *)point {
  NSLog(@"1 point: %@", point);
}

- (void)shapeViewDidMoveByX: (CGFloat) x y: (CGFloat) y {
  NSLog(@"moved by: %f %f", x, y);
  NSMutableArray *points = [NSMutableArray arrayWithCapacity: [[triangle points] count]];
  for (HKPoint *point in [triangle points]) {
    HKPoint *modified = [[HKPoint alloc] initWithCGPoint: CGPointMake(point.x + x, point.y + y)];
    [points addObject: modified];
  }
  [triangle updatePoints: points];
  [self.view setNeedsDisplay];
}

- (void)shapeViewDidTouchWithThreePoints:(NSArray *)points {
    NSLog(@"3 points: %@", points);

  if (triangle) {
    [triangle updatePoints: points];
  } else {
    triangle = [[Triangle alloc] initWithPoints: points];
    [(ShapeView *) self.view setTriangle: triangle];
  }

  [self.view setNeedsDisplay];
}

- (void)gyroscopicDidUpdateRotation:(float)rotation {
    NSLog(@"rotation %f", rotation);
//    self.view.transform = CGAffineTransformMakeRotation(rotation);
    //		self.image.transform = CGAffineTransformMakeRotation(rotation);
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ShapeView *sv = (ShapeView *) self.view;
    sv.delegate = self;
    
    self.gyroscopic = [[Gyroscopic alloc] init];
    self.gyroscopic.delegate = self;
    [self.gyroscopic startUpdates];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.gyroscopic.delegate = nil;
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
  return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end
