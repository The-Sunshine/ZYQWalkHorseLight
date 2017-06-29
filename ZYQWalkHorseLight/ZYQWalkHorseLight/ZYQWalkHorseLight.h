//
//  ZYQWalkHorseLight.h
//  scrollview
//
//  Created by zyq on 2017/3/21.
//  Copyright © 2017年 Jun. All rights reserved.
//

/*
 
 **********************************
 * 在您使用此自动轮播的过程中如果出现bug请及时以以下任意一种方式联系我们，我们会及时修复bug并
 * 帮您解决问题。
 * Email : 793894000@qq.com
 *
 **********************************

 */


#import <UIKit/UIKit.h>

@protocol ZYQWalkHorseLightDelegate <NSObject>

-(void)WalkHorseLightClick:(NSString *)string;

@end

@interface ZYQWalkHorseLight : UIView 

/** 初始轮播图（推荐使用） */
+ (instancetype)walkHorseLightWithFrame:(CGRect)frame delegate:(id<ZYQWalkHorseLightDelegate>)delegate;

+ (instancetype)walkHorseLightWithFrame:(CGRect)frame titleStringsGroup:(NSArray *)titleStringsGroup;

/** 宽度 */
@property (nonatomic,assign)  CGFloat    labelWidth;

/** 每行高度 warning: 设置的高度 * 显示条数||5 不能小于当前类的高度 否则会产生超过部分无法点击的问题  */
@property (nonatomic,assign)  CGFloat    labelHeight;

/** 同时显示条数 warning: 设置的高度 * 显示条数 不能小于当前类的高度 否则会产生超过部分无法点击的问题 */
@property (nonatomic,assign)  NSInteger  titleCount;

/** 信息 */
@property (nonatomic,strong)  NSArray  * labelTitleArray;

/** 开启其他字体颜色 */
@property (nonatomic,assign)  BOOL       isOpenOtherTextColor;

/** 字体颜色 */
@property (nonatomic,strong)  UIColor  * textColor;

/** 其他字体颜色 */
@property (nonatomic,strong)  UIColor  * otherTextColor;

/** 字体大小 */
@property (nonatomic,strong)  UIFont   * textFont;

/** 滚动间隔 */
@property (nonatomic,assign)  CGFloat    duration;

/** 代理点击事件 */
@property (nonatomic,weak)    id<ZYQWalkHorseLightDelegate> delegate;

/** Block点击事件 */
@property (nonatomic, strong) void(^clickBlock)(NSString * string);

@end
