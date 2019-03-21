//
//  ZSTitleSelectedView.h
//  News
//
//  Created by 道道明明白白 on 2019/3/20.
//  Copyright © 2019 道道明明白白. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 zs20190320 滚动的title 
 */
@interface ZSTitleSelectedView : UIView

@property (nonatomic, strong) NSMutableArray *arrayTitles;       /**< zs20190320 标题数组  */



/**
 zs20190321 刷新标题数据源

 @param arrayTitles 数据源数组
 */
- (void)updateArrayTitles:(NSMutableArray *)arrayTitles;

@end

NS_ASSUME_NONNULL_END
