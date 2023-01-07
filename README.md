# BGTableViewComponent

[![CI Status](https://img.shields.io/travis/Bingo/BGTableViewComponent.svg?style=flat)](https://travis-ci.org/Bingo/BGTableViewComponent)
[![Version](https://img.shields.io/cocoapods/v/BGTableViewComponent.svg?style=flat)](https://cocoapods.org/pods/BGTableViewComponent)
[![License](https://img.shields.io/cocoapods/l/BGTableViewComponent.svg?style=flat)](https://cocoapods.org/pods/BGTableViewComponent)
[![Platform](https://img.shields.io/cocoapods/p/BGTableViewComponent.svg?style=flat)](https://cocoapods.org/pods/BGTableViewComponent)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

BGTableViewComponent is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BGTableViewComponent'
```

## Example
1、使用BGTableViewComponent管理UITableView;
2、数据源配置：列表数据源是BGTableViewSectionData的数组
BGTableViewSectionData：每一组的数据。装配每组的数据，包括组头、组尾视图及组视图的数据，行数据源BGTableViewRowData的数组。
BGTableViewRowData：每一行的数据。装配每行cell的cell类名，cell刷新的数据源，行高、indexPath、cell类型等。

数据源创建实例：
```
    //cell数据装载
    for (int i = 0; i<10; i++) {
        BGTableViewRowData*cellData = [BGTableViewRowData creatDataWith:@"BGTableViewButtonCell" data:[NSString stringWithFormat:@"展开cell第%d行",i] cellHeight:105];
        cellData.selecteCellEventType = i;
        [cellArr addObject:cellData];
    }
    //组数据源配置
    BGTableViewSectionData*sectionData1 = [BGTableViewSectionData new];
    sectionData1.isPackUp = YES;
    sectionData1.header = [BGTableViewSection creatSectionWith:[self headViewWithTag:100] height:50];
    sectionData1.dataList = cellArr;
```
3、cell数据源加载：
遵守BGTableViewCellProtocol协议
实现方法bg_refreshUIWithData:加载数据
```
- (void)bg_refreshUIWithData:(id)data {
    - (void)bg_refreshUIWithData:(id)data {
    NSAssert([data isKindOfClass:[BGTableViewRowData class]], @"数据源必须为BGTableViewRowData类型");
}
```

4、设置cell行高：
可以数据源直接设置，数据源设置0或未设置，可以通过cell实现bg_getTableViewCellHeightWithData:方法设置高度，可根据数据计算高度，返回的高度会缓存起来。

```
//获取cell高度
+ (CGFloat)bg_getTableViewCellHeightWithData:(BGTableViewRowData *)data {
    return 0;
}

```

5、选中cell事件：
遵守BGTableViewDelegate协议，设置代理，实现选中cell代理方法

```
- (void)bg_selecteCellImplementationWithCell:(UITableViewCell *)cell data:(BGTableViewRowData *)data {
    NSInteger type = data.selecteCellEventType;
    NSLog(@"cell选中事件%ld",type);
}
```

6、cell上其他事件：
遵守BGTableViewDelegate协议，实现代理方法
eventType： cell上其他事件定义的类型
otherParameters： cell上其他事件可能用到的传参

```
- (void)bg_clickCellOtherEventImplementationWithCell:(UITableViewCell *)cell data:(BGTableViewRowData *)data eventType:(NSInteger)eventType otherParameters:(NSDictionary *)otherParameters {
    if (eventType == BGTableViewCellOtherEventTypeOne) {
        NSLog(@"cell类型%ld  事件一",data.selecteCellEventType);
        [self.navigationController pushViewControllerName:@"BGSettingViewController" info:nil];
    }else if (eventType == BGTableViewCellOtherEventTypeTwo) {
        NSLog(@"cell类型%ld  事件二",data.selecteCellEventType);
    }else if (eventType == BGTableViewCellOtherEventTypeThree) {
        NSLog(@"cell类型%ld  事件三",data.selecteCellEventType);
    }
}
```
cell中其他事件调用方式

```
[self bg_cellOtherActionImplementationWithEventType:0 parameter:@{@"model":models[index]}];
```
7、编辑cell代理方法
编辑cell，实现代理方法如下：
 默认单个删除按钮
```
/**单个删除按钮事件*/
- (BOOL)bg_canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//删除事件
- (void)bg_commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableViewComponent removeRowDataModelWith:indexPath];
}
```
    自定义多个按钮
```
- (NSArray *)bg_editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {

        NSLog(@"点击了删除");
        [self.manager removeRowDataModelWith:indexPath];
    }];

    //置顶按钮

    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {

        NSLog(@"点击了置顶");

    }];

    topRowAction.backgroundColor = [UIColor blueColor];

    // 添加一个更多按钮

    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"更多"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {

        NSLog(@"点击了更多");
    }];

    moreRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //将设置好的按钮放到数组中返回
    return @[deleteRowAction, topRowAction, moreRowAction];
}
```  
8、其他代理方法：
返回cell，便于外层特殊处理或持有等操作
```
- (UITableViewCell *)bg_customCellImplementationWithCell:(UITableViewCell *)cell data:(BGTableViewRowData *)data {
    if (data.selecteCellEventType == 10) {
        self.bannerCell = (BGBannerTableViewCell *)cell;
        self.cellRect = [self.tableViewComponent.tableView rectForRowAtIndexPath:data.indexPath];
    }
    return cell;
}
```
cell绘制代理方法，可用于cell动画或者特殊绘制操作
```
- (void)bg_willDisplayCell:(UITableViewCell *)cell ForRowAtIndexPath:(NSIndexPath *)indexPath {
    //可添加cell动画、cell特殊绘制操作
    //旋转动画
    cell.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);
    [UIView animateWithDuration:0.5 animations:^{
        cell.layer.transform = CATransform3DIdentity;
    }];
}
```

滑动代理方法，继承UIScrollViewDelegate，可以直接实现对应滑动代理方法。

```
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
```
9、一些类的功能解释：
BGTableviewComponentInterface：用于给BGTableViewComponent扩展方法，便于外部调用，主要是数据源的增删改查等操作。
BGTableViewRowData中字段xibCellBundle：用于xib创建的cell文件放在哪个bundle下，一般默认mainBundle，如果不在mainBundle下，需指定bundle名才可以读取到xib文件。


## Author

Bingo, xb624784368@qq.com

## License

BGTableViewComponent is available under the MIT license. See the LICENSE file for more info.
