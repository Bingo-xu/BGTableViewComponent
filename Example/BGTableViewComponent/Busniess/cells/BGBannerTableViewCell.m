//
//  BGBannerTableViewCell.m
//  BGTableViewComponent_Example
//
//  Created by Bingo on 2022/11/10.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import "BGBannerTableViewCell.h"
#import "SDCycleScrollView.h"

@implementation BGBannerModel


@end

@interface BGBannerTableViewCell () <SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *adView;

@end

@implementation BGBannerTableViewCell

+ (CGFloat)bg_getTableViewCellHeightWithData:(BGTableViewRowData *)data {
    return 260;
}

- (void)commonInit {
    [super commonInit];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.adView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(10);
    }];
    
    [self.adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(50);
        make.height.offset(200);
        make.centerX.offset(0);
    }];
}

- (void)bg_refreshUIWithData:(id)data {
    [super bg_refreshUIWithData:data];
    NSArray *models = [(BGTableViewRowData*)data data];
    NSArray *urls = [models valueForKeyPath:@"imageUrl"];
    self.adView.imageURLStringsGroup = urls;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSArray *models = self.bg_rowData.data;
    [self bg_cellOtherActionImplementationWithEventType:0 parameter:@{@"model":models[index]}];
}

- (SDCycleScrollView *)adView {
    if (!_adView) {
        _adView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        _adView.layer.cornerRadius = 10;
        _adView.layer.masksToBounds = YES;
        _adView.backgroundColor = [UIColor lightGrayColor];
        _adView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _adView.pageControlDotSize = CGSizeMake(6, 6);
    }
    return _adView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel createLableWithFont:[UIFont systemFontOfSize:20] textColor:[UIColor blackColor] text:@"广告标题"];
    }
    return _titleLabel;
}

@end
