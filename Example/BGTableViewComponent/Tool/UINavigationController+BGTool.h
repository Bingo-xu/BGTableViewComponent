//
//  UINavigationController+BGTool.h
//  BGTableViewComponent_Example
//
//  Created by Bingo on 2022/11/10.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (BGTool)


- (void)pushViewControllerName:(nonnull NSString *)vcName info:(nullable NSDictionary *)info;


@end

NS_ASSUME_NONNULL_END
