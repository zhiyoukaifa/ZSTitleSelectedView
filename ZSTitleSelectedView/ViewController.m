//
//  ViewController.m
//  ZSTitleSelectedView
//
//  Created by 道道明明白白 on 2019/3/21.
//  Copyright © 2019 道道明明白白. All rights reserved.
//

#import "ViewController.h"
#import "ZSTitleSelectedView.h"

@interface ViewController ()

@property (nonatomic, strong) ZSTitleSelectedView *viewTitleSelected;        /**< zs20190321 标题视图  */

@end

@implementation ViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];

    [self.view addSubview:self.viewTitleSelected];
    
    self.viewTitleSelected.frame = CGRectMake(0, 31, self.view.frame.size.width, 40);

    NSMutableArray *arrayTitles = [NSMutableArray arrayWithObjects:
                                   @"推荐",
                                   @"视频",
                                   @"热点",
                                   @"北京",
                                   @"娱乐",
                                   @"音乐",
                                   @"图片",
                                   @"懂车帝",
                                   @"体育",
                                   @"财经",
                                   @"房产",
                                   @"国际",
                                   @"健康",
                                   @"科技",
                                   @"军事",
                                   @"历史",
                                   @"值点",
                                   @"小说",
                                   nil];
    [self.viewTitleSelected updateArrayTitles:arrayTitles];
}





- (ZSTitleSelectedView *)viewTitleSelected
{
    if (_viewTitleSelected == nil) {
        
        _viewTitleSelected = [[ZSTitleSelectedView alloc] init];
    }
    return _viewTitleSelected;
}


@end
