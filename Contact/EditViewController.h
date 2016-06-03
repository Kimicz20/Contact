//
//  EditViewController.h
//  Contact
//
//  Created by Geek on 16/6/1.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact,EditViewController;

@protocol editViewControllerDelegate <NSObject>
@optional
-(void)editViewController:(EditViewController *)editVc DidSaveContact:(Contact *)contact;
@end

@interface EditViewController : UIViewController
@property (nonatomic,strong) Contact *contact;
@property (nonatomic,strong) id<editViewControllerDelegate> delegate;
@end
