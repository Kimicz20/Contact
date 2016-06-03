//
//  addViewController.h
//  Contact
//
//  Created by Geek on 16/6/1.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import <UIKit/UIKit.h>
@class addViewController,Contact;

@protocol addViewControllerDelegate <NSObject>
@optional
-(void)addViewController:(addViewController *)addVc DidAddContact:(Contact *)contact;
@end

@interface addViewController : UIViewController
@property (nonatomic,weak) id<addViewControllerDelegate> delagate;
@end
