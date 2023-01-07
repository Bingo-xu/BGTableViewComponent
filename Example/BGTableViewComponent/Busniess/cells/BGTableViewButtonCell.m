//
//  YKTableViewButtonCell.m
//  YKTableViewComponent_Example
//
//  Created by Bingo on 2021/11/26.
//  Copyright © 2021 bingoxu. All rights reserved.
//

#import "BGTableViewButtonCell.h"

@implementation BGTableViewButtonCell

- (void)dealloc {
    NSLog(@"BGTableViewButtonCell");
}

- (IBAction)action1:(id)sender {
    [self bg_cellOtherActionImplementationWithEventType:BGTableViewCellOtherEventTypeOne parameter:nil];
}

- (IBAction)action2:(id)sender {
    [self bg_cellOtherActionImplementationWithEventType:BGTableViewCellOtherEventTypeTwo parameter:nil];
}

- (IBAction)action3:(id)sender {
    [self bg_cellOtherActionImplementationWithEventType:BGTableViewCellOtherEventTypeThree parameter:nil];
}

- (void)bg_refreshUIWithData:(id)data {
    [super bg_refreshUIWithData:data];
    BGTableViewRowData*model = data;
    self.titleLabel.text = model.data;
}

@end
