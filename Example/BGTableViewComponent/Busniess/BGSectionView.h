//
//  BGSectionView.h
//  BGTableViewComponent_Example
//
//  Created by Bingo on 2022/11/9.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <BGTableViewComponent/BGTableViewComponent.h>

NS_ASSUME_NONNULL_BEGIN

@interface BGSectionView : UIView <BGTableViewReloadDataProtocol>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@end

NS_ASSUME_NONNULL_END
