//
//  EditViewController.m
//  Contact
//
//  Created by Geek on 16/6/1.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import "EditViewController.h"
#include "Contact.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *telField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

- (IBAction)save;
- (IBAction)editMode:(UIBarButtonItem *)sender;


@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameField.text = self.contact.name;
    self.telField.text = self.contact.telNum;
    
}
#pragma mark 点击触摸时 取消键盘事件
/**
 *  使用view的touchesBegan:触摸事件来实现对键盘的隐藏，当点击view的区域就会触发这个事件
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nameField resignFirstResponder];
    [self.telField resignFirstResponder];
}

/**
 *  编辑模式改变
 */
- (IBAction)editMode:(UIBarButtonItem *)sender {
    if([sender.title isEqualToString:@"编辑"]){
        _nameField.enabled = YES;
        _telField.enabled = YES;
        _saveBtn.hidden = NO;
        [_telField becomeFirstResponder];
        sender.title = @"取消";
    }else if([sender.title isEqualToString:@"取消"]){
        
        //按钮属性修改
        _nameField.enabled = NO;
        _telField.enabled = NO;
        _saveBtn.hidden = YES;
        
        //重新赋值数据
        self.nameField.text = self.contact.name;
        self.telField.text = self.contact.telNum;
        
        sender.title = @"编辑";
    }
}

- (IBAction)save {
    
    //数据修改保存
    self.contact.name = self.nameField.text;
    self.contact.telNum = self.telField.text;
    
    //控制器出栈
    [self.navigationController popViewControllerAnimated:YES];
    
    //调用代理方法
    if([self.delegate respondsToSelector:@selector(editViewController:DidSaveContact:)]){
        [self.delegate editViewController:self DidSaveContact:self.contact];
    }
}


@end
