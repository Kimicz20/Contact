//
//  ContactCell.h
//  Contact
//
//  Created by Geek on 16/6/2.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact;

@interface ContactCell : UITableViewCell
@property (nonatomic,strong) Contact *contact;
+(instancetype)initWithTableView:(UITableView *)tableview;
@end
