//
//  BGTableViewSectionData.h
//  BGTableViewComponent
//
//  Created by Bingo on 2022/10/14.
//  Copyright © 2022 xb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BGTableViewRowData.h"

NS_ASSUME_NONNULL_BEGIN

@interface BGTableViewSection : NSObject <NSCopying>

/**组视图*/
@property (nonatomic,strong) UIView *sectionView;
/**组高度*/
@property (nonatomic,assign) CGFloat height;
/**组数据源*/
@property (nonatomic,strong) id sectionData;

+ (BGTableViewSection* )creatSectionWith:(UIView* )sectionView height:(CGFloat)height;

+ (BGTableViewSection* )creatSectionWith:(UIView* )sectionView height:(CGFloat)height sectionData:(nullable id)sectionData;

@end

@interface BGTableViewSectionData : NSObject <NSCopying>

/**是否收起，默认否*/
@property (nonatomic,assign) BOOL isPackUp;
/**cell数据源*/
@property (nonatomic,strong) NSArray <BGTableViewRowData *>*dataList;
/**组头*/
@property (nonatomic,strong) BGTableViewSection *header;
/**组尾*/
@property (nonatomic,strong) BGTableViewSection *footer;

@end

NS_ASSUME_NONNULL_END
