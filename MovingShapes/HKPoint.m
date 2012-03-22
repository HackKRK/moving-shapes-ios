//
//  HKPoint.m
//  MovingShapes
//
//  Created by Karol Mazur on 3/22/12.
//  Copyright (c) 2012 mazur.me. All rights reserved.
//

#import "HKPoint.h"

@implementation HKPoint

- (id) initWithCGPoint:(CGPoint) cgpoint {
    self = [super init];
    if (self) {
        cgp = cgpoint;
    }
    return self;
}

- (CGFloat) x {
    return cgp.x;
}

- (CGFloat) y {
    return cgp.y;
}

- (NSString*)description {
    return [NSString stringWithFormat: @"Point(%f,%f)", cgp.x, cgp.y];
}

@end
