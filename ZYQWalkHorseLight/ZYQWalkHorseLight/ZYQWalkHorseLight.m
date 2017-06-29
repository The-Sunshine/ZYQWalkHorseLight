//
//  WalkHorseLight.m
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

#import "ZYQWalkHorseLight.h"

@implementation ZYQWalkHorseLight
{
    UIScrollView * _scrollView;
    NSTimer * _timer;
    NSInteger _page;
    UIWindow * window;
}
#pragma mark - lifeCycle
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initialization];
        [self initScrollView];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initialization];
    [self initScrollView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_labelTitleArray.count == 0) return;

    /** 对label展示个数 做控制 */
    _titleCount = _labelTitleArray.count > _titleCount ? _titleCount : _labelTitleArray.count;

    /** 对使用walkHorseLightWithFrame初始化方法 进行单独定义 */
    if (_labelHeight == 0) _labelHeight = self.frame.size.height / _titleCount;
    if (_labelWidth == 0) _labelWidth = self.frame.size.width;

    _scrollView.frame = CGRectMake(0, 0, _labelWidth, _titleCount * _labelHeight);
    
    /** 控制UILabel 创建个数 */
    NSInteger labelCount = _labelTitleArray.count > _titleCount ? _titleCount + 1 : _titleCount;
    
    /** 添加label */
    for (NSInteger i = 0; i < labelCount; i ++) {
        
        UILabel * label = [[UILabel alloc]init];
        label.frame = CGRectMake(10, i * _labelHeight, _labelWidth - 20, _labelHeight);
        label.tag = 100 + i;
        label.userInteractionEnabled = YES;
        label.textColor = _textColor;
        if (_isOpenOtherTextColor) label.textColor = i % 2 == 0 ? _textColor :_otherTextColor;
        label.font = _textFont;
        [_scrollView addSubview:label];
        
        if (_labelTitleArray.count > i) label.text = _labelTitleArray[i];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [label addGestureRecognizer:tap];
    }
    /** 开启定时器 */
    if (_labelTitleArray.count > _titleCount) [self startTimer];
}
#pragma mark - initialization
-(void)initialization
{
    _titleCount = 5;
    
    _page = _titleCount - 1;
    
    _duration = 2.0;
    
    _labelHeight = self.frame.size.height / _titleCount;
    
    _labelWidth = self.frame.size.width;
    
    _textFont = [UIFont systemFontOfSize:12];
    
    _textColor = [UIColor grayColor];
}

+ (instancetype)walkHorseLightWithFrame:(CGRect)frame delegate:(id<ZYQWalkHorseLightDelegate>)delegate
{
    ZYQWalkHorseLight * walkHorseLight = [[self alloc]initWithFrame:frame];
    walkHorseLight.delegate = delegate;
    
    return walkHorseLight;
}

+(instancetype)walkHorseLightWithFrame:(CGRect)frame titleStringsGroup:(NSArray *)titleStringsGroup
{
    ZYQWalkHorseLight * walkHorseLight = [[self alloc]initWithFrame:frame];
    walkHorseLight.labelTitleArray = titleStringsGroup;
    
    return walkHorseLight;
}
#pragma mark - initScrollView
-(void)initScrollView
{
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    [self addSubview:scrollView];
    _scrollView = scrollView;
}
#pragma mark - properties
-(void)setTitleCount:(NSInteger)titleCount
{
    _titleCount = titleCount;
    
    _page = _titleCount - 1;
}
#pragma mark - timer
-(void)startTimer
{
    [_timer invalidate];
    _timer = nil;
    
    _timer = [NSTimer timerWithTimeInterval:_duration target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void)automaticScroll
{
    NSInteger  page = (_page + 1) % _labelTitleArray.count;
    
    _page = page;
    
    /** 遍历每一个label */
    for (UILabel * topLabel in _scrollView.subviews) {
        float top = topLabel.frame.origin.y;
        
        /** 拿出最上面的label 放到最下面 */
        if (-_labelHeight == top) {
            
            topLabel.frame = CGRectMake(10, _titleCount * _labelHeight, _labelWidth - 20, _labelHeight);
            topLabel.text = _labelTitleArray[page];
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            
            /** 将不是最上面的label向上移动_labelHeight高度 */
            topLabel.frame = CGRectMake(10, topLabel.frame.origin.y - _labelHeight, _labelWidth - 20, _labelHeight);
        }];
    }
}
#pragma mark - clickEvent
-(void)tapClick:(UITapGestureRecognizer *)tap
{
    for (UILabel * label in _scrollView.subviews) {
        
        /** 通过tag值获取label */
        if (label.tag == tap.view.tag) {
            
            [self.delegate WalkHorseLightClick:label.text];
            
            if (_clickBlock) {
                
                _clickBlock(label.text);
            }
        }
    }
}
@end
