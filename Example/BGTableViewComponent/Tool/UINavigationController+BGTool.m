//
//  UINavigationController+BGTool.m
//  BGTableViewComponent_Example
//
//  Created by Bingo on 2022/11/10.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import "UINavigationController+BGTool.h"

@implementation UINavigationController (BGTool)

- (void)pushViewControllerHideTabbar:(UIViewController *)vc {
    vc.hidesBottomBarWhenPushed = YES;
    [self pushViewController:vc animated:YES];
}

- (void)pushViewControllerName:(nonnull NSString *)vcName info:(nullable NSDictionary *)info {
    UIViewController *vc = [NSClassFromString(vcName) new];
    if (!vc) {
        NSLog(@"未定义的类%@",vc);
        return;
    }
    if (info) {
        [vc setValuesForKeysWithDictionary:info];
    }
    [self pushViewControllerHideTabbar:vc];
}

@end
