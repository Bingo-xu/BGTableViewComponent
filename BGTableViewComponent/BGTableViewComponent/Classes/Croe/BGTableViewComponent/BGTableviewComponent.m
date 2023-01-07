//
//  BGTableviewComponent.m
//  BGTableViewComponent
//
//  Created by Bingo on 2022/10/14.
//  Copyright © 2022 xb. All rights reserved.
//

#import "BGTableViewComponent.h"
#import "BGThreadSafeMutableArray.h"
#import "BGTableviewComponent+DataSource.h"
#import "BGTableView.h"
#import "BGTableviewComponent+BGForwarding.h"
#import "UIResponder+BGChain.h"
#import "UITableViewCell+BGEvent.h"

@interface BGTableViewComponent ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)  NSMutableArray *cellClassArr;
@property (nonatomic,strong)  BGThreadSafeMutableArray *mDataSource;
@property (nonatomic, strong) BGTableView *tableView;
@end

@implementation BGTableViewComponent
- (void)dealloc {
#ifdef DEBUG
    NSLog(@"BGTableviewComponent------dealloc------");
#endif
}

#pragma mark- =============布局=================
+ (BGTableViewComponent *)initWithTableViewStyle:(UITableViewStyle)style {
    return [self initWithTableViewStyle:style frame:CGRectZero superView:nil];
}

/**
 指定TableViewStyle，默认UITableViewStylePlain
 */
+ (BGTableViewComponent *)initWithTableViewStyle:(UITableViewStyle)style frame:(CGRect)frame superView:(nullable UIView* )superView {
    return [[BGTableViewComponent alloc] initWithTableViewStyle:style frame:frame superView:superView];
}

/**
 指定TableViewStyle，默认UITableViewStylePlain
 传入父视图、tableView的frame、代理
 */
+ (BGTableViewComponent *)initWithTableViewStyle:(UITableViewStyle)style frame:(CGRect)frame superView:(nullable UIView* )superView delegate:(id <BGTableViewDelegate>)delegate {
    BGTableViewComponent*manager = [BGTableViewComponent initWithTableViewStyle:style frame:frame superView:superView];
    manager.delegate = delegate;
    return manager;
}

- (instancetype)initWithTableViewStyle:(UITableViewStyle)style frame:(CGRect)frame superView:(nullable UIView* )superView {
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [self creatTableViewWithStyle:style];
        if (superView) {
            [superView addSubview:self];
        }
    }
    return  self;
}

/**
 布局tableView，传入父视图、tableView的frame
 */
- (void)layoutTableViewWithSuperView:(nullable UIView* )superView frame:(CGRect)frame {
    self.frame = frame;
    if (superView) {
        [superView addSubview:self];
    }
}

//获取组高度
- (CGFloat)getSectionHeight:(NSInteger)section isHead:(BOOL)isHead {
    BGTableViewSectionData* data = [self.mDataSource objectAtIndex:section];
    CGFloat height = isHead?data.header.height:data.footer.height;
    if (height > 0) {
        return height;
    }
    return CGFLOAT_MIN;
}

//获取组视图
- (UIView* )getSectionView:(NSInteger)section isHead:(BOOL)isHead {
    BGTableViewSectionData* data = [self.mDataSource objectAtIndex:section];
    BGTableViewSection *sectionData = isHead?data.header:data.footer;
    UIView *sectionView = sectionData.sectionView;
    if (sectionData.sectionData && [sectionView respondsToSelector:@selector(bg_refreshUIWithData:)]) {
        [sectionView performSelector:@selector(bg_refreshUIWithData:) withObject:sectionData.sectionData];
    }
    if (sectionView) {
        sectionView.hidden = sectionData.height > 0 ? NO:YES;
        return sectionView;
    }
    return nil;
}

#pragma mark- 设置数据源
/**单组列表，无组头组尾，重置数据源。内部创建section*/
- (void)resetSingleSectionDataSourecs:(nullable NSArray<BGTableViewRowData*>*)dataArr {
    [self bg_resetSingleSectionDataSourecs:dataArr];
}

/**重置数据源，组头组尾外部设置*/
- (void)resetDataSourecs:(nullable NSArray<BGTableViewSectionData*>*)dataArr {
    [self bg_resetDataSourecs:dataArr];
}

#pragma mark-查
/**获取某一行数据*/
- (BGTableViewRowData*)getRowDataModelWith:(NSIndexPath*)indexPath {
    return [[(BGTableViewSectionData*)[self.mDataSource objectAtIndex:indexPath.section] dataList] objectAtIndex:indexPath.row];
}

/**获取某一组数据*/
- (BGTableViewSectionData*)getSectionDataModelWith:(NSInteger)section {
    return [self.mDataSource objectAtIndex:section];
}

/**数据源*/
- (NSArray<BGTableViewSectionData*>*)dataSources {
    return self.mDataSource;
}

#pragma mark- 刷新列表
/**重载所有列表*/
- (void)reloadData {
    [self.tableView reloadData];
}

#pragma mark- =============点击事件=================
- (void)cellSelecteEventImplementation:(BGTableViewRowData* )data cell:(UITableViewCell* )cell {
    if (self.delegate && [self.delegate respondsToSelector:@selector(bg_selecteCellImplementationWithCell:data:)]) {
        [self.delegate bg_selecteCellImplementationWithCell:cell data:data];
    }
}

- (void)bg_handleEventWithEventName:(NSString *)eventName parameter:(NSDictionary *)parameter {
    if ([BGCellEventName isEqualToString:eventName]) {
        BGTableViewRowData*model = (BGTableViewRowData*)[parameter objectForKey:@"data"];
        UITableViewCell*cell = [parameter objectForKey:@"cell"];
        NSInteger eventType = [[parameter objectForKey:@"eventType"] integerValue];
        NSDictionary *otherPa = [parameter objectForKey:@"parameter"];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(bg_clickCellOtherEventImplementationWithCell:data:eventType:otherParameters:)]) {
            [self.delegate bg_clickCellOtherEventImplementationWithCell:cell data:model eventType:eventType otherParameters:otherPa];
        }
    }
}

#pragma mark- =============代理方法=================
#pragma mark-UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self getSectionView:section isHead:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self getSectionHeight:section isHead:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self getSectionView:section isHead:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self getSectionHeight:section isHead:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BGTableViewRowData * data = [self getRowDataModelWith:indexPath];
    if (data.cellHeight > 0) {
        return data.cellHeight;
    }
    if (data.autoHeight) { //外层未设置行高，根据
        Class<BGTableViewCellProtocol> cls = NSClassFromString(data.cellClassName);
        if (cls && [cls respondsToSelector:@selector(bg_getTableViewCellHeightWithData:)]) {
            CGFloat h = [cls bg_getTableViewCellHeightWithData:data.data];
            data.cellHeight = h;
            return h;
        }
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self cellSelecteEventImplementation:[self getRowDataModelWith:indexPath] cell:[tableView cellForRowAtIndexPath:indexPath]];
}


#pragma mark-UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.mDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.mDataSource.count == 0) {
        return UITableViewCell.new;
    }
    BGTableViewRowData * data = [self getRowDataModelWith:indexPath];
    data.indexPath = indexPath;
    NSString*idS = [tableView identificationStrWithClassName:data.cellClassName];
    UITableViewCell<BGTableViewCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:idS];
    if (!cell) {
        return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idS];
    }
    [cell setBGCellData:data]; //cell持有数据源
    if ([cell respondsToSelector:@selector(bg_refreshUIWithData:)]) {
        cell.hidden = (data.cellHeight == 0); //高度为0 隐藏cell
        [cell bg_refreshUIWithData:data];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(bg_customCellImplementationWithCell:data:)]) {
       UITableViewCell*nCell = [self.delegate bg_customCellImplementationWithCell:cell data:data];
        if (nCell) {
            return nCell;
        }
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BGTableViewSectionData* sectionData = (BGTableViewSectionData*)[self.mDataSource objectAtIndex:section];
    if (sectionData.isPackUp) { //收起状态
        return 0;
    }
    return [sectionData dataList].count;
}

#pragma mark- =============getterOrSetter=================

- (BGTableView* )creatTableViewWithStyle:(UITableViewStyle)style {
    BGTableView *tableView = [[BGTableView alloc] initWithFrame:CGRectZero style:style];
    tableView.delegate = self;
    tableView.dataSource = self;
    //添加约束
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:tableView];
    NSLayoutConstraint *LayoutConstraintCenterX = [self equallyRelatedConstraintWithView:tableView attribute:NSLayoutAttributeCenterX];
    NSLayoutConstraint *LayoutConstraintCenterY = [self equallyRelatedConstraintWithView:tableView attribute:NSLayoutAttributeCenterY];
    NSLayoutConstraint *LayoutConstraintWidth = [self equallyRelatedConstraintWithView:tableView attribute:NSLayoutAttributeWidth];
    NSLayoutConstraint *LayoutConstraintHeight = [self equallyRelatedConstraintWithView:tableView attribute:NSLayoutAttributeHeight];
    [self addConstraint:LayoutConstraintCenterX];
    [self addConstraint:LayoutConstraintCenterY];
    [self addConstraint:LayoutConstraintWidth];
    [self addConstraint:LayoutConstraintHeight];
    if (style == UITableViewStyleGrouped) {
        UIView*headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 0.01)];
        headView.backgroundColor = [UIColor clearColor];
        tableView.tableFooterView = headView;
    }
    return tableView;
}

///与视图同等相关的约束
- (NSLayoutConstraint *)equallyRelatedConstraintWithView:(UIView *)view attribute:(NSLayoutAttribute)attribute
{
return [NSLayoutConstraint constraintWithItem:view
                                    attribute:attribute
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:self
                                    attribute:attribute
                                   multiplier:1.0
                                     constant:0.0];
}

//- (BGTableView *)tableView {
//    if (!_tableView) {
//        _tableView = [self creatTableViewWithStyle:UITableViewStylePlain];
//    }
//    return _tableView;
//}

- (NSMutableArray *)cellClassArr {
    if (!_cellClassArr) {
        _cellClassArr = [NSMutableArray new];
    }
    return _cellClassArr;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.tableView.backgroundColor = backgroundColor;
}

- (BGThreadSafeMutableArray *)mDataSource {
    if (!_mDataSource) {
        _mDataSource = [BGThreadSafeMutableArray new];
    }
    return _mDataSource;
}

@end
