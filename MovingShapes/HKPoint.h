//
//  HKPoint.h
//  MovingShapes
//
//  Created by Karol Mazur on 3/22/12.
//  Copyright (c) 2012 mazur.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKPoint : NSObject {
    CGPoint cgp;
}

- (id) initWithCGPoint:(CGPoint) cgpoint;

@property (readonly) CGFloat x;
@property (readonly) CGFloat y;

@end
