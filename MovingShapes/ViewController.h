//
//  ViewController.h
//  MovingShapes
//
//  Created by Jakub Suder on 3.22.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShapeView.h"
#import "Shape.h"
#import "Gyroscopic.h"

@class Gyroscopic;

@interface ViewController : UIViewController <ShapeViewDelegate, GyroscopicDelegate> {
  Shape *shape;
}

@property (strong, nonatomic) Gyroscopic *gyroscopic;

@end
