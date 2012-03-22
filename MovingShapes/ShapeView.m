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

- (void) processTouchEvent:(UIEvent *)event {
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self processTouchEvent: event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self processTouchEvent: event];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    if (self.triangle) {
        HKPoint *aPoint = [self.triangle.points objectAtIndex:0];
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextBeginPath(ctx);
        CGContextMoveToPoint   (ctx, aPoint.x, aPoint.y);  // top left
        for (int i = 1; i < [self.triangle.points count]; i++) {
            aPoint = [self.triangle.points objectAtIndex:i];
            CGContextAddLineToPoint(ctx, aPoint.x, aPoint.y); 
        }
        CGContextClosePath(ctx);
        
        CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
        CGContextFillPath(ctx);
    }
    

    
}


@end
