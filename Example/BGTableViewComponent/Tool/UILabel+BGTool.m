//
//  UILabel+BGTool.m
//  BGTableViewComponent_Example
//
//  Created by Bingo on 2022/11/7.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import "UILabel+BGTool.h"

@implementation UILabel (BGTool)

+ (UILabel *)createLableWithFont:(UIFont*)font textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.font = font;
    return label;
}

+ (UILabel *)createLableWithFont:(UIFont*)font textColor:(UIColor *)textColor text:(NSString*)text
{
    UILabel *label = [UILabel createLableWithFont:font textColor:textColor];
    label.text = text;
    return label;
}

+ (UILabel *)createLableWithFont:(UIFont*)font textColor:(UIColor *)textColor text:(NSString*)text textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [UILabel createLableWithFont:font textColor:textColor text:text];
    label.textAlignment = textAlignment;
    return label;
}

@end
