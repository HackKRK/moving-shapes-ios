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

- (void)gyroscopicDidUpdateRotation:(float)rotation;

@end

@interface Gyroscopic : NSObject

@property (assign, nonatomic) id delegate;

@property (strong, nonatomic) CMMotionManager *motionManager;
@property (strong, nonatomic) NSTimer *timer;
@property float rotation;

@end
