//
//  ZSTitleSelectedView.m
//  News
//
//  Created by 道道明明白白 on 2019/3/20.
//  Copyright © 2019 道道明明白白. All rights reserved.
//

#import "ZSTitleSelectedView.h"

#define kTagBtnsBase  1903200929  //zs20190321 多个标题按钮 tag初值
#define kRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
@interface ZSTitleSelectedView()

@property (nonatomic, strong) UIScrollView *scrollView;      /**< zs20190320 滚动视图  */

@property (nonatomic, strong) UIButton *btnLastSelected;       /**< zs20190320 上次选中的按钮 */

@end

@implementation ZSTitleSelectedView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addContentView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addContentView];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
}

- (void)updateArrayTitles:(NSMutableArray *)arrayTitles
{
    _arrayTitles = arrayTitles;
    [self reloadBtnsTitles];
}

#pragma mark - private
- (void)addContentView
{
    self.scrollView.backgroundColor = kRGB(125, 185, 240);
    [self addSubview:self.scrollView];
}
- (void)onClickAllBtns:(UIButton*)btn
{
    if (btn.selected) {
        return;
    }
    _btnLastSelected.selected = NO;
    btn.selected = YES;
    _btnLastSelected = btn;
    
    if (self.scrollView.contentSize.width < self.frame.size.width) {
        return;
    }
    //zs20190320 进行位置偏移 将选中的标题 移动到中间位置
    if (btn.center.x > self.frame.size.width/2.0) {
        if (btn.center.x - self.frame.size.width/2.0 < (self.scrollView.contentSize.width - self.frame.size.width)) {
            [self.scrollView setContentOffset:CGPointMake(btn.center.x - self.frame.size.width/2.0, 0) animated:YES];
        } else {
            [self.scrollView setContentOffset:CGPointMake((self.scrollView.contentSize.width - self.frame.size.width), 0) animated:YES];
        }
    } else {
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}
- (void)reloadBtnsTitles
{
    for (int i = 0; i < self.arrayTitles.count ; i ++) {
        
        UIButton *btnTitle = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnTitle setTitle:_arrayTitles[i] forState:(UIControlStateNormal)];
        btnTitle.titleLabel.font = [UIFont systemFontOfSize:14];
        [btnTitle setTitleColor:kRGB(31, 31, 31) forState:(UIControlStateNormal)];
        [btnTitle setTitleColor:kRGB(246, 78, 79) forState:(UIControlStateSelected)];
        btnTitle.tag = i + kTagBtnsBase;
        if (i == 0) {
            _btnLastSelected = btnTitle;
            btnTitle.selected = YES;
            btnTitle.frame = CGRectMake(15,
                                        0,
                                        [self getTextWidth:self.arrayTitles[i] font:14] + 10,
                                        self.frame.size.height);
        } else {
            UIButton *btnLast = (UIButton*)[self.scrollView viewWithTag:i + kTagBtnsBase -1];
            btnTitle.frame = CGRectMake(btnLast.frame.origin.x + btnLast.frame.size.width + 10,
                                        0,
                                        [self getTextWidth:self.arrayTitles[i] font:14] + 10,
                                        self.frame.size.height);
        }
        [btnTitle addTarget:self action:@selector(onClickAllBtns:) forControlEvents:(UIControlEventTouchUpInside)];
        [_scrollView addSubview:btnTitle];
    }
    
    
    if (self.arrayTitles.count > 1) {//zs20190321 保证两个及两个以上的标题
        
        UIButton *btnLast = [self.scrollView viewWithTag:self.arrayTitles.count - 1 + kTagBtnsBase];
        //zs20190321 判断最后一个按钮的位置 是否超过父视图 如果没超过则将剩余的宽度补到两个按钮之间的间隙上
        if (btnLast.frame.origin.x + btnLast.frame.size.width + 15 < self.frame.size.width) {
            
            //zs20190321 如果标题在屏幕上能全部展示 则做位置做均匀分配处理
            CGFloat widthPara = self.frame.size.width - (btnLast.frame.origin.x + btnLast.frame.size.width + 15);
            CGFloat widthAdd = widthPara/(self.arrayTitles.count -1);
            for (int i = 1; i < self.arrayTitles.count; i ++) {
                UIButton *btn= (UIButton*)[self.scrollView viewWithTag:i + kTagBtnsBase];
                btn.frame = CGRectMake(btn.frame.origin.x + widthAdd,
                                       btn.frame.origin.y,
                                       btn.frame.size.width,
                                       btn.frame.size.height);
                if (i > 1) {
                    UIButton *btnFront = (UIButton*)[self.scrollView viewWithTag:i + kTagBtnsBase -1];
                    btn.frame = CGRectMake(btnFront.frame.origin.x + btnFront.frame.size.width + 10 + widthAdd,
                                           btn.frame.origin.y,
                                           btn.frame.size.width,
                                           btn.frame.size.height);
                }
            }
        } else {//zs20190321 所有标题在屏幕上展示不下 需要滚动
            _scrollView.contentSize = CGSizeMake(btnLast.frame.origin.x + btnLast.frame.size.width  + 15, self.frame.size.height);
        }
    }
    
    //zs20190321 如果只有一个标题或者两个标题 按照具体需求去适配吧
}

#pragma mark ------- 计算文本在对应字体下的长度
- (CGFloat)getTextWidth:(NSString*)text font:(CGFloat)fontPara
{
    if ([text isKindOfClass:[NSString class]]) {
        
        CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontPara]}];
        return size.width;
    } else {
        return 0;
    }
}
#pragma mark - getter
- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

@end
