//
//  UIResponder+BGChain.m
//  BGTableViewComponent
//
//  Created by Bingo on 2022/10/14.
//  Copyright © 2022 xb. All rights reserved.
//

#import "UIResponder+BGChain.h"

@implementation UIResponder (BGChain)

/**事件传递*/
- (void)bg_handleEventWithEventName:(NSString*)eventName parameter:(NSDictionary*)parameter {
    [self.nextResponder bg_handleEventWithEventName:eventName parameter:parameter];
}

@end
