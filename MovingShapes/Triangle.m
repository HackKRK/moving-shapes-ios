//
//  Triangle.m
//  MovingShapes
//
//  Created by Karol Mazur on 3/22/12.
//  Copyright (c) 2012 mazur.me. All rights reserved.
//

#import "Triangle.h"
#import "HKPoint.h"

@implementation Triangle

@synthesize points = _points;

- (id)initWithPoints:(NSArray *)points {
    self = [super init];
    if (self) {
        self.points = points;
    }
    return self;
}

@end
