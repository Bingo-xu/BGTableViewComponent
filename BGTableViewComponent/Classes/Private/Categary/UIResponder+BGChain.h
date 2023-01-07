//
//  UIResponder+BGChain.h
//  BGTableViewComponent
//
//  Created by Bingo on 2022/10/14.
//  Copyright © 2022 xb. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**点击cell事件名*/
#define  BGCellEventName        @"BGCellEventName"

@interface UIResponder (BGChain)

/**事件传递*/
- (void)bg_handleEventWithEventName:(NSString*)eventName parameter:(NSDictionary*)parameter;

@end

NS_ASSUME_NONNULL_END
