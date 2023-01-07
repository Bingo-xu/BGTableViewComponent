//
//  BGTableView.m
//  BGTableViewComponent
//
//  Created by Bingo on 2022/10/14.
//  Copyright © 2022 xb. All rights reserved.
//

#import "BGTableView.h"

@implementation BGTableView

- (void)dealloc {
#ifdef DEBUG
    NSLog(@"BGTableView------dealloc------");
#endif
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self) {
        [self commonInit];
    }
    return  self;
}

- (instancetype)init {
    self = [super initWithFrame:CGRectZero style:UITableViewStylePlain];
    if (self) {
        [self commonInit];
    }
    return  self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor whiteColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self closeEstimateHeight];
    [self closeInset];
}

- (void)reloadData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [super  reloadData];
    });
}

@end
