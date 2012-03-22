//
//  ShapeView.h
//  MovingShapes
//
//  Created by Karol Mazur on 3/22/12.
//  Copyright (c) 2012 mazur.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKPoint.h"
#import "Triangle.h"

@protocol ShapeViewDelegate <NSObject>

@optional
- (void)shapeViewDidMoveVertex: (NSInteger) vertex toPoint: (HKPoint *) point;
- (void)shapeViewDidTouchWithOnePoint:(HKPoint*) point;
- (void)shapeViewDidTouchWithTwoPoints:(NSArray *)points;
- (void)shapeViewDidTouchWithThreePoints:(NSArray *)points;

@end

@interface ShapeView : UIView {
  NSInteger fingers;
  NSInteger vertex;
}

@property (assign, nonatomic) id <ShapeViewDelegate> delegate;
@property (assign, nonatomic) Triangle *triangle;

@end
