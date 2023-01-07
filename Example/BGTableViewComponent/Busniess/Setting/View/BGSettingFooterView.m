//
//  BGSettingFooterView.m
//  BGTableViewComponent_Example
//
//  Created by Bingo on 2022/11/10.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import "BGSettingFooterView.h"

@implementation BGSettingFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self =  [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self addSubview:self.nextBtn];
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, [UIScreen mainScreen].bounds.size.width - 30, 50)];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        _nextBtn.backgroundColor = [UIColor whiteColor];
        _nextBtn.layer.cornerRadius = 10;
        [_nextBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_nextBtn setTitle:@"退出当前账号" forState:UIControlStateNormal];
    }
    return _nextBtn;
}

@end
