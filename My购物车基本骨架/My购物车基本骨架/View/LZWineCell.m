//
//  LZWineCell.m
//  My购物车基本骨架
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 m14a.cn. All rights reserved.
//

#import "LZWineCell.h"
#import "LZWine.h"

@interface LZWineCell ()
/** 图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imageImageView;
/** 名称*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 价格*/
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;



@end

@implementation LZWineCell

// 重写set方法
- (void)setWine:(LZWine *)wine
{
    _wine = wine;
    self.imageImageView.image = [UIImage imageNamed:wine.image];
    self.nameLabel.text = wine.name;
    self.moneyLabel.text = wine.money;
}

@end
