//
//  ViewController.m
//  MovingShapes
//
//  Created by Jakub Suder on 3.22.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "Shape.h"
#import "ShapeView.h"
#import "Gyroscopic.h"

// from http://stackoverflow.com/questions/563198/how-do-you-detect-where-two-line-segments-intersect
char get_line_intersection(float p0_x, float p0_y, float p1_x, float p1_y, 
                           float p2_x, float p2_y, float p3_x, float p3_y, float *i_x, float *i_y)
{
  float s1_x, s1_y, s2_x, s2_y;
  s1_x = p1_x - p0_x;     s1_y = p1_y - p0_y;
  s2_x = p3_x - p2_x;     s2_y = p3_y - p2_y;
  
  float s, t;
  s = (-s1_y * (p0_x - p2_x) + s1_x * (p0_y - p2_y)) / (-s2_x * s1_y + s1_x * s2_y);
  t = ( s2_x * (p0_y - p2_y) - s2_y * (p0_x - p2_x)) / (-s2_x * s1_y + s1_x * s2_y);
  
  if (s >= 0 && s <= 1 && t >= 0 && t <= 1)
  {
    // Collision detected
    if (i_x != NULL)
      *i_x = p0_x + (t * s1_x);
    if (i_y != NULL)
      *i_y = p0_y + (t * s1_y);
    return 1;
  }
  
  return 0; // No collision
}

@implementation ViewController

@synthesize gyroscopic = _gyroscopic;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)shapeViewDidMoveVertex: (NSInteger) vertex toPoint: (HKPoint *) point {
  NSLog(@"moved point %d: %@", vertex, point);
  NSMutableArray *points = [NSMutableArray arrayWithArray: [shape points]];
  [points replaceObjectAtIndex: vertex withObject: point];
  [shape updatePoints: points];
  [self.view setNeedsDisplay];
}

- (void)shapeViewDidTouchWithOnePoint:(HKPoint *)point {
  NSLog(@"1 point: %@", point);
}

- (void)shapeViewDidMoveByX: (CGFloat) x y: (CGFloat) y {
  NSLog(@"moved by: %f %f", x, y);
  NSMutableArray *points = [NSMutableArray arrayWithCapacity: [[shape points] count]];
  for (HKPoint *point in [shape points]) {
    HKPoint *modified = [[HKPoint alloc] initWithCGPoint: CGPointMake(point.x + x, point.y + y)];
    [points addObject: modified];
  }
  [shape updatePoints: points];
  [self.view setNeedsDisplay];
}

- (void)updateShapeWithPoints:(NSArray*) points {
    if (shape) {
        [shape updatePoints: points];
    } else {
        shape = [[Shape alloc] initWithPoints: points];
        [(ShapeView *) self.view setShape: shape];
    }
    
    [self.view setNeedsDisplay];
}

- (void)shapeViewDidTouchWithThreePoints:(NSArray *)points {
    NSLog(@"3 points: %@", points);
    [self updateShapeWithPoints:points];
}

- (void)shapeViewDidTouchWithFourPoints:(NSArray *)points {
    NSLog(@"4 points: %@", points);
    HKPoint *point1 = [points objectAtIndex: 0];
    HKPoint *point2 = [points objectAtIndex: 1];
    HKPoint *point3 = [points objectAtIndex: 2];
    HKPoint *point4 = [points objectAtIndex: 3];
  
    if (get_line_intersection(point1.x, point1.y, point2.x, point2.y, point3.x, point3.y, point4.x, point4.y, 0, 0)) {
      points = [NSArray arrayWithObjects: point1, point2, point4, point3, nil];
    }
  
    [self updateShapeWithPoints:points];
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
