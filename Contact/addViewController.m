//
//  addViewController.m
//  Contact
//
//  Created by Geek on 16/6/1.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import "addViewController.h"
#import "Contact.h"

@interface addViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *telField;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

- (IBAction)add;

@end

@implementation addViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(checkNameAndPwd) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(checkNameAndPwd) name:UITextFieldTextDidChangeNotification object:self.telField];
}

/**
 *  view显示完成时调用 立即弹出键盘
 */
-(void)viewDidAppear:(BOOL)animated{
    [self.nameField becomeFirstResponder];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 点击触摸时 取消键盘事件
/**
 *  使用view的touchesBegan:触摸事件来实现对键盘的隐藏，当点击view的区域就会触发这个事件
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nameField resignFirstResponder];
    [self.telField resignFirstResponder];
}

#pragma mark 登录按钮能否点击
-(void)checkNameAndPwd{
    self.addBtn.enabled = (self.nameField.text.length && self.telField.text.length);
}
#pragma mark 添加联系人操作
- (IBAction)add {
    //1.移除当前控制器 返回上一层控制器
    [self.navigationController popViewControllerAnimated:YES];
    
    //2.通过代理返回数据
    if([self.delagate respondsToSelector:@selector(addViewController:DidAddContact:)]){
        Contact *newContact = [[Contact alloc]init];
        newContact.name = self.nameField.text;
        newContact.telNum = self.telField.text;
        [self.delagate addViewController:self DidAddContact:newContact];
    }
}
@end
