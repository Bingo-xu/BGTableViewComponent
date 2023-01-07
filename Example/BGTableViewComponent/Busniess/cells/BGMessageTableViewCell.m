//
//  BGMessageTableViewCell.m
//  BGTableViewComponent_Example
//
//  Created by Bingo on 2022/11/7.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import "BGMessageTableViewCell.h"

@implementation BGMessageTableViewCell

- (void)commonInit {
    [super commonInit];
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.detailLabel];
    [self.bgView addSubview:self.arrowImageView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(10);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.right.offset(-50);
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.offset(0);
        make.width.offset(6);
        make.height.offset(10);
    }];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 10;
    }
    return _bgView;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView new];
        _arrowImageView.image = [UIImage imageNamed:@"message_arrow_gray"];
    }
    return _arrowImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel createLableWithFont:[UIFont systemFontOfSize:20] textColor:[UIColor blackColor] text:@"消息标题"];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel createLableWithFont:[UIFont systemFontOfSize:16] textColor:[UIColor lightGrayColor] text:@"消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容"];
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}

@end
