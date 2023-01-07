//
//  BGSectionViewModel.h
//  BGTableViewComponent_Example
//
//  Created by Bingo on 2022/11/25.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BGSectionViewModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) BOOL showArrow;

@property (nonatomic, assign) NSInteger actionType;


@end

NS_ASSUME_NONNULL_END
