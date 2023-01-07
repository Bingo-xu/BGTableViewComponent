//
//  BGTableViewSectionData.m
//  BGTableViewComponent
//
//  Created by Bingo on 2022/10/14.
//  Copyright © 2022 xb. All rights reserved.
//

#import "BGTableViewSectionData.h"

@implementation BGTableViewSection

+ (BGTableViewSection* )creatSectionWith:(UIView* )sectionView height:(CGFloat)height {
    return [self creatSectionWith:sectionView height:height sectionData:nil];
}

+ (BGTableViewSection* )creatSectionWith:(UIView* )sectionView height:(CGFloat)height sectionData:(id)sectionData {
    BGTableViewSection* section  = [BGTableViewSection new];
    section.height = height;
    section.sectionView = sectionView;
    section.sectionData = sectionData;
    return section;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    BGTableViewSection *copy = [[BGTableViewSection allocWithZone:zone] init];
    copy.sectionView = [self.sectionView mutableCopy];
    copy.height = self.height;
    copy.sectionData = [self.sectionData mutableCopy];
    return copy;
}

@end


@implementation BGTableViewSectionData

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    BGTableViewSectionData *copy = [[BGTableViewSectionData allocWithZone:zone] init];
    copy.isPackUp = self.isPackUp;
    copy.header = [self.header copy];
    copy.footer = [self.footer copy];
    NSMutableArray *arr = [NSMutableArray new];
    for (BGTableViewRowData *data in self.dataList) {
        [arr addObject:[data copy]];
    }
    copy.dataList = arr;
    return copy;
}

@end
