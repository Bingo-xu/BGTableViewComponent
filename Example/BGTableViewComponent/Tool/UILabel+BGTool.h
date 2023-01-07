//
//  UILabel+BGTool.h
//  BGTableViewComponent_Example
//
//  Created by Bingo on 2022/11/7.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (BGTool)

+ (UILabel *)createLableWithFont:(UIFont*)font textColor:(UIColor *)textColor;
+ (UILabel *)createLableWithFont:(UIFont*)font textColor:(UIColor *)textColor text:(NSString*)text;
+ (UILabel *)createLableWithFont:(UIFont*)font textColor:(UIColor *)textColor text:(NSString*)text textAlignment:(NSTextAlignment)textAlignment;

@end

NS_ASSUME_NONNULL_END
