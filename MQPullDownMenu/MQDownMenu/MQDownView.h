//
//  MQDownView.h
//  MQPullDownMenu
//
//  Created by irs on 16/9/2.
//  Copyright © 2016年 zmq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MQDownView : UIView

+ (MQDownView *)sharedView;

+ (void)showDownMenu:(UIViewController *)viewController;

@end
