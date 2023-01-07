//
//  BGSectionView.m
//  BGTableViewComponent_Example
//
//  Created by Bingo on 2022/11/9.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import "BGSectionView.h"
#import "UILabel+BGTool.h"

@implementation BGSectionView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(0);
            make.left.offset(15);
        }];
    }
    return self;
}

- (void)bg_refreshUIWithData:(id)data {
    if (![data isKindOfClass:[NSString class]]) {
        return;
    }
    self.titleLabel.text = data;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel createLableWithFont:[UIFont systemFontOfSize:20] textColor:[UIColor blackColor]];
    }
    return _titleLabel;
}

@end
