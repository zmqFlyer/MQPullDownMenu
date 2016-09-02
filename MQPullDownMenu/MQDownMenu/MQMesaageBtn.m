//
//  MQMesaageBtn.m
//  MQPullDownMenu
//
//  Created by irs on 16/9/2.
//  Copyright © 2016年 zmq. All rights reserved.
//

#import "MQMesaageBtn.h"
#import "MQDownView.h"

@interface MQMesaageBtn ()
@property (nonatomic , strong) UIButton *msgBtn;
@end

@implementation MQMesaageBtn

+ (MQMesaageBtn *)sharedButton {
    static MQMesaageBtn *sharedButton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedButton = [[self alloc]initWithFrame:CGRectMake(0, 0, 23, 20)];
    });
    return sharedButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self  setBackgroundImage:[UIImage imageNamed:@"message_empty"] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(popDownMenu) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)popDownMenu{
    [MQDownView showDownMenu:[[self viewController].childViewControllers lastObject]];
}

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}



@end
