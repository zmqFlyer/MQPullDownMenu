//
//  MQDownView.m
//  MQPullDownMenu
//
//  Created by irs on 16/9/2.
//  Copyright © 2016年 zmq. All rights reserved.
//

#import "MQDownView.h"
#define MQMargin 10
#define MQStatusH 64
#define MQScreenBounds [UIScreen mainScreen].bounds
#define MQScreenH [UIScreen mainScreen].bounds.size.height
#define MQScreenW [UIScreen mainScreen].bounds.size.width
@interface MQDownView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIViewController *currentController;
@end

@implementation MQDownView

+ (MQDownView *)sharedView{
    static MQDownView *sharedView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedView = [[self alloc]initWithFrame:CGRectZero];
    });
    return sharedView;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.coverView = [[UIView alloc]initWithFrame:MQScreenBounds];
        self.coverView.backgroundColor = [UIColor clearColor];
        UIGestureRecognizer *touchHide = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideDownMenu)];
        touchHide.delegate = self;
        [self.coverView addGestureRecognizer:touchHide];
        [[UIApplication sharedApplication].keyWindow addSubview:self.coverView];
        
        
        //计算tableView的frame
        CGFloat ViewW = 110;
        CGFloat ViewH = 80;
        CGFloat ViewX = MQScreenW - ViewW-5.0;
        CGFloat ViewY = MQStatusH;
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(ViewX, ViewY, ViewW, ViewH)];
        [self.coverView addSubview:self.tableView];
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.tableView.alpha = 0.9;
        self.tableView.layer.cornerRadius = 5.0f;
        self.tableView.layer.masksToBounds = YES;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.scrollEnabled = NO;
        self.dataArray = @[@"我的发布",
                           @"联系小二",
                           ];
        
        // 画三角形
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(MQScreenW - 35, MQStatusH)];
        [path addLineToPoint:CGPointMake(MQScreenW - 30, MQStatusH-6)];
        [path addLineToPoint:CGPointMake(MQScreenW - 25, MQStatusH)];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        // 颜色设置和cell颜色一样
        layer.fillColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:0.9].CGColor;
        layer.strokeColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:0.9].CGColor;
        layer.path = path.CGPath;
        [self.coverView.layer addSublayer:layer];
        
        self.coverView.hidden = YES;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"idx";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            [self hideDownMenu];
        }
            break;
        default:{
            [self hideDownMenu];
        }
            break;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //Tip:我们可以通过打印touch.view来看看具体点击的view是具体是什么名称,像点击UITableViewCell时响应的View则是UITableViewCellContentView.
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        //返回为NO则屏蔽手势事件
        return NO;
    }
    [self hideDownMenu];
    return YES;
}

+ (void)showDownMenu:(UIViewController *)viewController{
    [self sharedView].currentController = viewController;
    [self sharedView].coverView.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        [self sharedView].coverView.alpha = 1;
    }];
    [self sharedView].coverView.hidden = NO;
}

- (void)hideDownMenu{
    [UIView transitionWithView:self.coverView duration:0.5 options:0 animations:^{
        self.coverView.alpha--;
    } completion:^(BOOL finished) {
        self.coverView.hidden = YES;
    }];
}


@end
