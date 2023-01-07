//
//  UITableViewCell+BGEvent.m
//  BGTableViewComponent
//
//  Created by Bingo on 2022/10/14.
//  Copyright © 2022 xb. All rights reserved.
//

#import "UITableViewCell+BGEvent.h"
#import <objc/runtime.h>
#import "UIResponder+BGChain.h"

static const void *BGCellDataNameKey = &BGCellDataNameKey;

@implementation UITableViewCell (BGEvent)

- (void)setBGCellData:(BGTableViewRowData *)bgCellData {
    objc_setAssociatedObject(self, BGCellDataNameKey, bgCellData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BGTableViewRowData *)bg_rowData {
    return objc_getAssociatedObject(self, BGCellDataNameKey);
}

- (void)bg_cellOtherActionImplementationWithEventType:(NSInteger)eventType parameter:(NSDictionary *)parameter {
    NSMutableDictionary*dic = [NSMutableDictionary new];
    [dic setObject:@(eventType) forKey:@"eventType"];
    if (self.bg_rowData) {
        [dic setObject:self.bg_rowData forKey:@"data"];
        [dic setObject:self forKey:@"cell"];
    }
    if (parameter) {
        [dic setObject:parameter forKey:@"parameter"];
    }
    [self bg_handleEventWithEventName:BGCellEventName parameter:dic];
}

- (void)cellSelectionStyleNone {
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
