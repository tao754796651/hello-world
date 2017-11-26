//
//  YTLabel.h
//
//  Created by Yt on 15/6/8.
//  Copyright (c) 2015年 Yt. All rights reserved.
//

#import <UIKit/UIKit.h>

//获取当前设备的宽度
#define kYTScreenH [UIScreen mainScreen].bounds.size.height
#define kYTScreenW [UIScreen mainScreen].bounds.size.width

#define kPad 16
@interface YTShowMessageView : UIView

/**
 *  提示一下1.5秒后关闭，如果需要修改（.m 搜索1.5进行修改）
 *  @param msg 显示内容
 */
+ (void)showMessage:(NSString *)msg;

/**
 *  显示一个图片+文字的提示 (TODO:进行完善)
 *  @param icon  为小标识
 *  @param title 标题
 *  @param msg   内容
 */
+ (void)showIcon:(NSString *)icon title:(NSString *)title message:(NSString *)msg;

@end
