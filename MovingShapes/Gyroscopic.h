//
//  Gyroscopic.h
//  MovingShapes
//
//  Created by Karol Mazur on 3/22/12.
//  Copyright (c) 2012 mazur.me. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@protocol GyroscopicDelegate <NSObject>

- (void)gyroscopicPositionChangedToX:(CGFloat) x y:(CGFloat)y;

@end

@interface Gyroscopic : NSObject {
    CGFloat x, y;
}

@property (assign, nonatomic) id <GyroscopicDelegate> delegate;

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) NSTimer *timer;
@property float rotation;

- (void)startUpdates;

@end
