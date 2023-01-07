//
//  BGBaseTableViewCell.m
//  BGTableViewComponent_Example
//
//  Created by Bingo on 2022/11/7.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import "BGBaseTableViewCell.h"

@implementation BGBaseTableViewCell

//获取cell高度
+ (CGFloat)bg_getTableViewCellHeightWithData:(BGTableViewRowData *)data {
    return 0;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    [self commonInit];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;
    [self commonInit];
    return self;
}


- (void)commonInit {
    [self cellSelectionStyleNone];
    self.backgroundColor = [UIColor colorWithRed:241/255.0 green:246/255.0 blue:249/255.0 alpha:1];
}

- (void)bg_refreshUIWithData:(id)data {
    NSAssert([data isKindOfClass:[BGTableViewRowData class]], @"数据源必须为BGTableViewRowData类型");
}

- (void)addLine {
    [self.contentView addSubview:self.bottomLineView];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.left.offset(0);
        make.centerX.offset(0);
        make.height.offset(0.5);
    }];
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [UIView new];
        _bottomLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomLineView;
}

@end
