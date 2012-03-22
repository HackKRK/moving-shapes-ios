//
//  ShapeView.h
//  MovingShapes
//
//  Created by Karol Mazur on 3/22/12.
//  Copyright (c) 2012 mazur.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKPoint.h"

@protocol ShapeViewDelegate <NSObject>

- (void)shapeViewDidTouchWithThreePoints:(NSArray *)points;

@end

@interface ShapeView : UIView

@property (assign, nonatomic) id <ShapeViewDelegate> delegate;

@end
