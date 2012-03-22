//
//  ShapeView.m
//  MovingShapes
//
//  Created by Karol Mazur on 3/22/12.
//  Copyright (c) 2012 mazur.me. All rights reserved.
//

#import "ShapeView.h"

@implementation ShapeView

@synthesize delegate, triangle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        UITapGestureRecognizer *threeTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(threeTouched:)];
//        [self addGestureRecognizer:threeTouch];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)threeTouched:(UITapGestureRecognizer *)sender {
//    if (sender.state == UIGestureRecognizerStateEnded) { }
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];
    NSMutableArray *points = [NSMutableArray arrayWithCapacity: allTouches.count];

    [allTouches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
      UITouch *touch = (UITouch *) obj;
      HKPoint *point = [[HKPoint alloc] initWithCGPoint: [touch locationInView:self]];
      [points addObject: point];
    }];

  switch (allTouches.count) {
    case 1: 
      [delegate shapeViewDidTouchWithOnePoint: [points objectAtIndex: 0]];
      break;
    case 2: 
      [delegate shapeViewDidTouchWithTwoPoints: points];
      break;
    case 3: 
      [delegate shapeViewDidTouchWithThreePoints: points];
      break;
  }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
