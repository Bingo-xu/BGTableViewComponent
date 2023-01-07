//
//  BGNoSectionViewController.m
//  BGTableViewComponent_Example
//
//  Created by Bingo on 2022/11/8.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import "BGNoSectionViewController.h"
#import <BGTableViewComponent/BGTableViewComponent.h>
#import "BGDefine.h"
#import "BGTableViewButtonCell.h"
#import "BGBannerTableViewCell.h"

@interface BGNoSectionViewController ()<BGTableViewDelegate>
@property (nonatomic, strong) BGTableViewComponent *tableViewComponent;
@property (nonatomic, strong) BGBannerTableViewCell *bannerCell;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, assign) int exposuresNum;

@property (nonatomic, assign) CGRect cellRect;

@end

@implementation BGNoSectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑列表";
    // Do any additional setup after loading the view.
    [self.tableViewComponent resetSingleSectionDataSourecs:[self creatDataSource]];
}

- (NSArray*)creatDataSource {
    NSMutableArray*cellArr = [NSMutableArray new];
    ///真实存在的cell数据
    for (int i = 0; i<10; i++) {
        BGTableViewRowData*cellData = [BGTableViewRowData creatDataWith:@"BGTableViewButtonCell" data:[NSString stringWithFormat:@"展开cell第%d行",i] cellHeight:105];
        cellData.selecteCellEventType = i;
        [cellArr addObject:cellData];
    }
    NSArray *bannerArr = @[@{@"imgUrl":@"https://cdn.kikakeyboard.com/picture/ios_keyboard/banner/diy_banner2x.png",@"actionUrl":@"kika://custom"},

    @{@"imgUrl":@"https://cdn.kikakeyboard.com/picture/ios_keyboard/banner/avatar_banner2x.png",@"actionUrl":@"kika://avatars"},

                           @{@"imgUrl":@"https://cdn.kikakeyboard.com/picture/ios_keyboard/banner/sticker_banner2x.png",@"actionUrl":@"kika://sticker"}];
    NSMutableArray*bannerModelArr = [NSMutableArray new];
    for (NSDictionary*dic in bannerArr) {
        BGBannerModel *banner = [BGBannerModel new];
        banner.imageUrl = dic[@"imgUrl"];
        banner.actionUrl = dic[@"actionUrl"];
        [bannerModelArr addObject:banner];
    }
    
    //第二行
    BGTableViewRowData*cellData2 = [BGTableViewRowData creatDataWith:@"BGBannerTableViewCell" data:bannerModelArr cellHeight:[BGBannerTableViewCell bg_getTableViewCellHeightWithData:nil]];
    cellData2.selecteCellEventType = 10;
    [cellArr addObject:cellData2];
    return cellArr;
}

// 判断View是否显示在屏幕上
- (BOOL)isDisplayedInScreenWithScrollY:(CGFloat)scrollY
{
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGFloat maxY = scrollY + screenRect.size.height;
    
    if (maxY >= CGRectGetMaxY(self.cellRect) && scrollY <= CGRectGetMinY(self.cellRect)) {
        return YES;
    }
    return NO;
}

#pragma mark-BGTableViewDelegate
- (void)bg_selecteCellImplementationWithCell:(UITableViewCell *)cell data:(BGTableViewRowData *)data {
    NSInteger type = data.selecteCellEventType;
    NSLog(@"cell选中事件%ld",type);
}

- (void)bg_clickCellOtherEventImplementationWithCell:(UITableViewCell *)cell data:(BGTableViewRowData *)data eventType:(NSInteger)eventType otherParameters:(NSDictionary *)otherParameters {
    if (eventType == BGTableViewCellOtherEventTypeOne) {
        NSLog(@"cell类型%ld  事件一",data.selecteCellEventType);
    }else if (eventType == BGTableViewCellOtherEventTypeTwo) {
        NSLog(@"cell类型%ld  事件二",data.selecteCellEventType);
    }else if (eventType == BGTableViewCellOtherEventTypeThree) {
        NSLog(@"cell类型%ld  事件三",data.selecteCellEventType);
    }else if (eventType == 0) { //banner点击事件
        BGBannerModel *banner = [otherParameters valueForKey:@"model"];
        NSLog(@"广告点击地址：%@",banner.actionUrl);
    }
}

- (BOOL)bg_canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)bg_commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableViewComponent removeRowDataModelWith:indexPath];
}


- (UITableViewCell *)bg_customCellImplementationWithCell:(UITableViewCell *)cell data:(BGTableViewRowData *)data {
    if (data.selecteCellEventType == 10) {
        self.bannerCell = (BGBannerTableViewCell *)cell;
        self.cellRect = [self.tableViewComponent.tableView rectForRowAtIndexPath:data.indexPath];
    }
    return cell;
}

- (void)bg_willDisplayCell:(UITableViewCell *)cell ForRowAtIndexPath:(NSIndexPath *)indexPath {
    //可添加cell动画、cell特殊绘制操作
    //平移动画
//    cell.alpha = 0;
//    CGFloat x = -UIScreen.mainScreen.bounds.size.width;
//    cell.transform = CGAffineTransformMakeTranslation(x, 100);
//
//    [UIView animateWithDuration:0.5 animations:^{
//        cell.alpha = 1;
//        cell.transform = CGAffineTransformIdentity;
//    }];
    
    //旋转动画
    cell.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);
    [UIView animateWithDuration:0.5 animations:^{
        cell.layer.transform = CATransform3DIdentity;
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    BOOL isDis = [self isDisplayedInScreenWithScrollY:scrollView.contentOffset.y];
    if (isDis) {
        if (self.isShow != isDis) {
            self.exposuresNum++;
            NSLog(@"cell:%@  曝光次数+%d",self.bannerCell,self.exposuresNum);
        }
        self.isShow = YES;
    }else {
        self.isShow = NO;
    }
}

- (BGTableViewComponent *)tableViewComponent {
    if (!_tableViewComponent) {
        _tableViewComponent = [BGTableViewComponent initWithTableViewStyle:UITableViewStylePlain frame:CGRectMake(0,KNavBarHeight, self.view.bounds.size.width, self.view.bounds.size.height - KNavBarHeight - KTabbarHeight) superView:self.view delegate:self];
    }
    return _tableViewComponent;
}

@end
