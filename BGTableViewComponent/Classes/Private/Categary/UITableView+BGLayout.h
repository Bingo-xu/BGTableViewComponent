//
//  UITableView+BGLayout.h
//  BGTableViewComponent
//
//  Created by Bingo on 2022/10/14.
//  Copyright © 2022 xb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (BGLayout)

/**关闭自动高度*/
- (void)closeEstimateHeight;

/**复用标识符*/
- (NSString*)identificationStrWithClassName:(NSString* )className;

/**注册cell,纯代码类*/
- (BOOL)registerCellWithClassName:(NSString*)className;
/**注册cell,纯代码类*/
- (void)registerCellWithClass:(Class)cla;

/**
 注册cell,通用
 className：cell类名
 bundle：组件化时xib类需要传入bundle
 */
- (BOOL)commonRegisterCellWithClassName:(NSString*)className bundle:(NSBundle* )bundle;

@end

@interface UIScrollView (BGLayout)

/**关闭自动Inset，配合VC的automaticallyAdjustsScrollViewInsets=NO使用*/
- (void)closeInset;

@end

NS_ASSUME_NONNULL_END
