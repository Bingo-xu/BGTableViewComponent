//
//  UITableView+BGLayout.m
//  BGTableViewComponent
//
//  Created by Bingo on 2022/10/14.
//  Copyright © 2022 xb. All rights reserved.
//

#import "UITableView+BGLayout.h"

@implementation UITableView (BGLayout)

- (void)closeEstimateHeight {
    self.estimatedRowHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    if (@available(iOS 15.0, *)) {//解决顶部会多出一截
        self.sectionHeaderTopPadding = 0;
    }
}

- (NSString*)identificationStrWithClassName:(NSString* )className {
    return [NSString stringWithFormat:@"%@_identification",className];
}

- (BOOL)registerCellWithClassName:(NSString*)className {
    Class cla = NSClassFromString(className);
    if (cla) {
        [self registerClass:cla forCellReuseIdentifier:[self identificationStrWithClassName:className]];
        return YES;
    }
    NSLog(@"%@类不存在",className);
    return NO;
}

- (void)registerCellWithClass:(Class )cla {
    [self registerCellWithClassName:NSStringFromClass(cla)];
}

/**注册cell,通用*/
- (BOOL)commonRegisterCellWithClassName:(NSString*)className bundle:(NSBundle* )bundle {
    if (!bundle) {
        bundle = [NSBundle mainBundle];
    }
    NSString*nibPath = [bundle pathForResource:className ofType:@"nib"];
    if (!nibPath) {
        return [self registerCellWithClassName:className];
    }
    [self registerNib:[UINib nibWithNibName:className bundle:bundle] forCellReuseIdentifier:[self identificationStrWithClassName:className]];
    return YES;
}

@end

@implementation UIScrollView (BGLayout)

- (void)closeInset {
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

@end
