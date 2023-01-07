//
//  BGSettingTableViewCell.m
//  BGTableViewComponent_Example
//
//  Created by Bingo on 2022/11/10.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import "BGSettingTableViewCell.h"
#import "BGSettingCellData.h"

@interface BGSettingTableViewCell ()
@property (nonatomic,strong) UIView *lineView;

@end

@implementation BGSettingTableViewCell

- (void)commonInit {
    [super commonInit];
    self.contentView.clipsToBounds = YES;
//    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.arrowImage];
    [self.contentView addSubview:self.switchBtn];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.lineView];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self.titleLabel.frame = CGRectMake(15, 15, 150, 25);
    self.arrowImage.frame = CGRectMake(width - 6 - 15, 22, 6, 10);
    self.switchBtn.frame  = CGRectMake(width - 45 - 15, 15, 45, 25);
    self.lineView.frame = CGRectMake(15, 54, width-15, 1);
}

#pragma mark- =============自定义方法=================
- (void)bg_refreshUIWithData:(id)data {
    BGTableViewRowData *dataSource =  data;
    BGSettingCellData *model = dataSource.data;
    self.titleLabel.text = model.title;
    self.switchBtn.hidden = (model.style != BGSettingCellStyleTypeSwitch);
    self.arrowImage.hidden = (model.style != BGSettingCellStyleTypeDefult);
    if (model.style == BGSettingCellStyleTypeSwitch) {
        self.switchBtn.on = model.switchOn;
    }
    self.contentLabel.text = model.content;
}

#pragma mark- =============点击事件=================
- (void)swClick:(UISwitch *)sender {
    [self bg_cellOtherActionImplementationWithEventType:0 parameter:@{@"isOn":@(sender.isOn)}];
}

#pragma mark- =============getterOrSetter=================
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = [UIColor redColor];
        _contentLabel.font = [UIFont systemFontOfSize:14];
    }
    return _contentLabel;
}

- (UISwitch *)switchBtn {
    if (!_switchBtn) {
        _switchBtn = [[UISwitch alloc] init];
        [_switchBtn addTarget:self action:@selector(swClick:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchBtn;
}

- (UIImageView *)arrowImage {
    if (!_arrowImage) {
        _arrowImage = [UIImageView new];
        _arrowImage.image = [UIImage imageNamed:@"message_arrow_gray"];
    }
    return _arrowImage;
}


- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

@end
