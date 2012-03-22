//
//  ShapeView.m
//  MovingShapes
//
//  Created by Karol Mazur on 3/22/12.
//  Copyright (c) 2012 mazur.me. All rights reserved.
//

static CGFloat maxDistance = 10.0;
static CGFloat indicatorRadius = 10.0;

#import "ShapeView.h"

@implementation ShapeView

@synthesize delegate, triangle;

- (void) awakeFromNib {
  vertex = -1;
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
      if (vertex > -1) {
        [delegate shapeViewDidMoveVertex: vertex toPoint: [points objectAtIndex: 0]];
      } else {
        [delegate shapeViewDidTouchWithOnePoint: [points objectAtIndex: 0]];
      }
      break;
    case 2: 
      [delegate shapeViewDidTouchWithTwoPoints: points];
      break;
    case 3: 
      [delegate shapeViewDidTouchWithThreePoints: points];
      break;
  }
}

- (void) resetTouches: (NSSet *) touches {
  fingers = [touches count];
  vertex = -1;

  if (triangle && fingers == 1) {
    CGPoint touch = [[[touches allObjects] objectAtIndex: 0] locationInView: self];
    for (NSInteger i = 0; i < [[triangle points] count]; i++) {
      HKPoint *point = [[triangle points] objectAtIndex: i];
      if (pow(point.x - touch.x, 2) + pow(point.y - touch.y, 2) < pow(maxDistance, 2)) {
        vertex = i;
        break;
      }
    }
  }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [self resetTouches: [event allTouches]];
  [self processTouchEvent: event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  if (touches.count != fingers) {
    [self resetTouches: [event allTouches]];
  }

  [self processTouchEvent: event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  vertex = -1;
  [self setNeedsDisplay];
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
      
      if (vertex > -1) {
        CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
        HKPoint *point = [[triangle points] objectAtIndex: vertex];
        CGRect rect = CGRectMake(point.x - indicatorRadius, point.y - indicatorRadius,
                                  2 * indicatorRadius, 2 * indicatorRadius);
        CGContextFillEllipseInRect(ctx, rect);
      }
    }
    

    
}


@end
