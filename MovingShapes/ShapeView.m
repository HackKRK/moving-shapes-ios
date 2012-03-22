//
//  ShapeView.m
//  MovingShapes
//
//  Created by Karol Mazur on 3/22/12.
//  Copyright (c) 2012 mazur.me. All rights reserved.
//

#import "ShapeView.h"

@implementation ShapeView

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        UITapGestureRecognizer *threeTouch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(threeTouched:)];
//        [self addGestureRecognizer:threeTouch];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)threeTouched:(UITapGestureRecognizer *)sender {
//    if (sender.state == UIGestureRecognizerStateEnded) { }
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray *allTouches = [event allTouches];
    NSMutableArray *points = [NSMutableArray arrayWithCapacity: allTouches.count];
    if (allTouches.count == 3){
        [allTouches enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UITouch *touch = (UITouch *) obj;
            HKPoint *point = [[HKPoint alloc] initWithCGPoint: [touch locationInView:self]];
            [points addObject: point];
        }];
        
        [delegate shapeViewDidTouchWithThreePoints: points];
    }
//    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
//        // Get a single touch and it's location
//        UITouch *touch = obj;
//        CGPoint touchPoint = [touch locationInView:self.view];
//        
//        // Draw a red circle where the touch occurred
//        UIView *touchView = [[UIView alloc] init];
//        [touchView setBackgroundColor:[UIColor redColor]];
//        touchView.frame = CGRectMake(touchPoint.x, touchPoint.y, 30, 30);
//        touchView.layer.cornerRadius = 15;
//        [self.view addSubview:touchView];
//        [touchView release];
//    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
