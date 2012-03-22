//
//  ShapeView.h
//  MovingShapes
//
//  Created by Karol Mazur on 3/22/12.
//  Copyright (c) 2012 mazur.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKPoint.h"
#import "Shape.h"

@protocol ShapeViewDelegate <NSObject>

@optional
- (void)shapeViewDidMoveVertex: (NSInteger) vertex toPoint: (HKPoint *) point;
- (void)shapeViewDidTouchWithOnePoint:(HKPoint*) point;
- (void)shapeViewDidTouchWithThreePoints:(NSArray *)points;
- (void)shapeViewDidTouchWithFourPoints:(NSArray *)points;
- (void)shapeViewDidMoveByX: (CGFloat) x y: (CGFloat) y;
@end

@interface ShapeView : UIView {
  NSInteger fingers;
  NSInteger vertex;
  HKPoint *startingPoint;
}

@property (assign, nonatomic) id <ShapeViewDelegate> delegate;
@property (assign, nonatomic) Shape *shape;

@end
