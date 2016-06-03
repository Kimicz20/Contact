//
//  ContactCell.m
//  Contact
//
//  Created by Geek on 16/6/2.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import "ContactCell.h"
#import "Contact.h"
#define kCellMaigin 5
#define kSeparatorW 2

@interface ContactCell()
@property (nonatomic,weak) UIView *separator;
@end

@implementation ContactCell

-(void)setContact:(Contact *)contact{
    _contact = contact;
    self.textLabel.text = contact.name;
    self.detailTextLabel.text = contact.telNum;
}

+(instancetype)initWithTableView:(UITableView *)tableview{
    static NSString *ID = @"contact";
    return [tableview dequeueReusableCellWithIdentifier:ID];
}

- (void)awakeFromNib {

    //设置cell中的控件
    UIView *separator = [[UIView alloc] init];
    separator.backgroundColor = [UIColor grayColor];
    separator.alpha = 0.2;
    [self.contentView addSubview:separator];
    self.separator = separator;
}

-(void)layoutSubviews{
    //设置子控件大小
    CGFloat separatorX = kCellMaigin;
    CGFloat separatorW = self.bounds.size.width - 2 * kCellMaigin;
    CGFloat separatorH = kSeparatorW;
    CGFloat separatorY = self.bounds.size.height - separatorH;
    
    _separator.frame = CGRectMake(separatorX, separatorY, separatorW, separatorH);
}

@end
