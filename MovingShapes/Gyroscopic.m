//
//  Gyroscopic.m
//  MovingShapes
//
//  Created by Karol Mazur on 3/22/12.
//  Copyright (c) 2012 mazur.me. All rights reserved.
//

#import "Gyroscopic.h"

@implementation Gyroscopic

@synthesize motionManager = _motionManager;
@synthesize timer = _timer;
@synthesize rotation = _rotation;
@synthesize delegate = _delegate;

- (id)init {
    self = [super init];
    if (self) {
        self.motionManager = [[CMMotionManager alloc] init];
    }
    return self;
}

- (void)startUpdates {
    [self.motionManager startGyroUpdates];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1/30.0
												 target:self 
											   selector:@selector(doGyroUpdate)
											   userInfo:nil 
												repeats:YES];

//    [motionManager stopGyroUpdates];
//		[timer invalidate];

}

- (void)doGyroUpdate {
	float rate = self.motionManager.gyroData.rotationRate.z;
	if (fabs(rate) > .2) {
		float direction = rate > 0 ? 1 : -1;
		self.rotation += direction * M_PI/90.0;
        
        [self.delegate gyroscopicDidUpdateRotation:self.rotation];
        
//		self.image.transform = CGAffineTransformMakeRotation(rotation);
	}
}

@end
