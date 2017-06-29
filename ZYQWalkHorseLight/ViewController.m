//
//  ViewController.m
//  scrollview
//
//  Created by zyq on 2017/3/20.
//  Copyright © 2017年 Jun. All rights reserved.
//

#import "ViewController.h"
#import "ZYQWalkHorseLight.h"
@interface ViewController () <ZYQWalkHorseLightDelegate>

@end

@implementation ViewController
{
    NSArray * _labelTitleArray;
    UIView * _moveView;
    CGFloat _titleWidth;
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    _labelTitleArray = @[@"0",@"1",@"2",@"3",@"4",@"5"];
    
    ZYQWalkHorseLight * lightView = [ZYQWalkHorseLight walkHorseLightWithFrame: CGRectMake(0, 50, self.view.frame.size.width, 200) titleStringsGroup:_labelTitleArray];
    lightView.delegate = self;
    lightView.isOpenOtherTextColor = YES;
    lightView.otherTextColor = [UIColor redColor];
    [self.view addSubview:lightView];
    
    __weak typeof(lightView) weakSelf = lightView;
    weakSelf.clickBlock = ^(NSString * string){
        
        NSLog(@"Block--------------%@",string);
    };
}


-(void)WalkHorseLightClick:(NSString *)string
{
    NSLog(@"__FUNCTION__delegate------%@",string);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
