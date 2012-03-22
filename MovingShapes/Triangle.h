//
//  Triangle.h
//  MovingShapes
//
//  Created by Karol Mazur on 3/22/12.
//  Copyright (c) 2012 mazur.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HKPoint.h"

@interface Triangle : NSObject

- (id)initWithPoints:(NSArray *)points;
- (void) updatePoints: (NSArray *) points;

@property (strong, nonatomic) NSArray *points;

@end
