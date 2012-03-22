//
//  Shape.m
//  MovingShapes
//
//  Created by Karol Mazur on 3/22/12.
//  Copyright (c) 2012 mazur.me. All rights reserved.
//

#import "Shape.h"
#import "HKPoint.h"

@implementation Shape

@synthesize points = _points;

- (id)initWithPoints:(NSArray *)points {
    self = [super init];
    if (self) {
        self.points = points;
    }
    return self;
}

- (void) updatePoints: (NSArray *) points {
  self.points = points;
}

@end
