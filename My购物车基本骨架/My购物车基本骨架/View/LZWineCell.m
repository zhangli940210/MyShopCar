//
//  LZWineCell.m
//  My购物车基本骨架
//
//  Created by apple on 16/2/20.
//  Copyright © 2016年 m14a.cn. All rights reserved.
//

#import "LZWineCell.h"
#import "LZWine.h"
#import "LZCircleButton.h"

@interface LZWineCell ()
/** 图片*/
@property (weak, nonatomic) IBOutlet UIImageView *imageImageView;
/** 名称*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 价格*/
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
/** 减号按钮*/
@property (weak, nonatomic) IBOutlet LZCircleButton *minusBtn;
/** 显示购买某瓶酒的数量*/
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation LZWineCell

// 重写set方法
- (void)setWine:(LZWine *)wine
{
    _wine = wine;
    self.imageImageView.image = [UIImage imageNamed:wine.image];
    self.nameLabel.text = wine.name;
    self.moneyLabel.text = wine.money;
    // 设置数量
    self.countLabel.text = [NSString stringWithFormat:@"%zd", wine.count];
    // 设置减号按钮是否可点击,不设置的话，重复利用会出错，界面由模型数据决定
    self.minusBtn.enabled = wine.count > 0;
}

/**
 *  +
 */
- (IBAction)plusBtnClick {
    // 设置减号按钮可点击
    self.minusBtn.enabled = YES;
    // 酒的数量+1
    self.wine.count++;
    // 设置给countLabel
    self.countLabel.text = [NSString stringWithFormat:@"%zd", self.wine.count];
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"plusBtnClickName" object:self];
}
/**
 *  -
 */
- (IBAction)minusBtnClick {
    // 酒的数量-1
    self.wine.count--;
    if (self.wine.count == 0) {
        self.minusBtn.enabled = NO;
    }
    // 设置给countLabel
    self.countLabel.text = [NSString stringWithFormat:@"%zd", self.wine.count];
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"minusBtnClickName" object:self];
}



@end
