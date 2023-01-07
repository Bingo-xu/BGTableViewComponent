//
//  BGAPPTool.m
//  BGTableViewComponent
//
//  Created by Bingo on 2022/11/7.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import "BGAPPTool.h"

@implementation BGAPPTool

+ (CGFloat)safeBottom {
    static CGFloat height = -1;
    if (height != -1) {
        return height;
    }
    if (@available(iOS 11.0, *)) {
        if ([UIApplication sharedApplication].keyWindow) {
            height = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
        }
    }else {
        height = 0;
    }
    if (height != -1) {
        return height;
    }
    return 0;
}

+ (CGFloat)statusBarHeight {
    static CGFloat barHeight = 0;
    if (barHeight > 0) {
        return barHeight;
    }
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        barHeight = statusBarManager.statusBarFrame.size.height;
    }
    else {
        barHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    NSLog(@"statusBarHeight:%f",barHeight);
    return barHeight;
}

@end
