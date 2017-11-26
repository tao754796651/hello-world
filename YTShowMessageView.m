//
//  YTLabel.m
//
//  Created by Yt on 15/6/8.
//  Copyright (c) 2015年 Yt. All rights reserved.
//

#import "YTShowMessageView.h"


#define kYTVertical 0.5f

@implementation YTShowMessageView

#pragma mark - 初始化操作
- (instancetype)init {
    self = [super init];
    if (self) {
        // 圆角隐藏
        self.backgroundColor = [UIColor grayColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 3.0;
        self.alpha = 0.0;
    }
    return self;
}

#pragma mark - 展示一个信息
+ (void)showMessage:(NSString *)msg {
    [[[YTShowMessageView alloc] init] showMessage:msg];
}
- (void)showMessage:(NSString *)msg {
    if (msg.length == 0) {
        return;
    }
    // 0.创建视图
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.text = msg;
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:12.0f];
    contentLabel.textColor = [UIColor whiteColor];
    [self addSubview:contentLabel];
    // 0.1添加到视图上
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:self];
    
    CGSize maxSize = CGSizeMake(kYTScreenW - 40.0f, kYTScreenH * (1-kYTVertical) * 2 - 20.0f);
    CGSize contentSize = getSizeAutoCalculate(msg, 12.0f, maxSize);
    // View视图的坐标
    self.center = CGPointMake(kYTScreenW * 0.5, kYTScreenH * kYTVertical);
    CGFloat boundWidth = contentSize.width + 10.0f;
    CGFloat boundHeight = contentSize.height + 10.0f;
    self.bounds = CGRectMake(0, 0, boundWidth, boundHeight);
    // 1.位置
    contentLabel.center = CGPointMake(boundWidth * 0.5, boundHeight * 0.5);
    contentLabel.bounds = CGRectMake(0, 0, contentSize.width, contentSize.height);
    
    // 2.隐藏视图
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        // 再启动动画隐藏并删除 - 等上1.0秒
        [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(hiddenAndRemoveView:) userInfo:nil repeats:NO];
    }];
}
- (void)hiddenAndRemoveView:(NSTimer *)timer{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 展示一个视图（附加Image）
+ (void)showIcon:(NSString *)icon title:(NSString *)title message:(NSString *)msg{
    
    CGFloat width = 270;
    CGFloat height = 110;
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake((kYTScreenH-height)/2, (kYTScreenW-width)/2, width, height)];
    
    //1.代理成功
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(height/2-30, 0, width, 30)];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [v addSubview:btn];
    
    //2.内容
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(height/2, 0, width, 30)];
    l.text = msg;
    [v addSubview:l];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:v];
    
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:[[YTShowMessageView alloc] init] selector:@selector(hiddenView:) userInfo:nil repeats:NO];
}
//隐藏
- (void)hiddenView:(NSTimer *)timer{
    timer = nil;
    [timer invalidate];
}

#pragma mark -  获取字符串的长度,高度
static inline CGSize getSizeAutoCalculate(NSString *text,CGFloat fontSize,CGSize maxSize){
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    
    labelSize.height = ceil(labelSize.height);//返回浮点数整数部分（舍弃小数点部分，往个位数进1）double val = ceil(12.345)→13.000
    
    labelSize.width = ceil(labelSize.width);
    
    return labelSize;
    
}

@end
