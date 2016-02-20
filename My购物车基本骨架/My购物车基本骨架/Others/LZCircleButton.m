//
//  LZCircleButton.m
//  My购物车基本骨架
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 m14a.cn. All rights reserved.
//

#import "LZCircleButton.h"

@implementation LZCircleButton

// 从xib或者storyboard中调用
- (void)awakeFromNib
{
    // 边框宽度
    self.layer.borderWidth = 1;
    // 边框颜色
    self.layer.borderColor = [UIColor redColor].CGColor;
    // 圆角
    self.layer.cornerRadius = self.bounds.size.width * 0.5;
}

@end
