//
//  LoginViewController.m
//  Contact
//
//  Created by Geek on 16/5/27.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD+MJ.h"
#import "Contact.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UISwitch *rmbSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *auoLoginSwitch;
- (IBAction)rmbPwd;
- (IBAction)autoLogin;
- (IBAction)Login;
@property (weak, nonatomic) IBOutlet UIButton *jjj;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(checkNameAndPwd) name:UITextFieldTextDidChangeNotification object:self.nameTextField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(checkNameAndPwd) name:UITextFieldTextDidChangeNotification object:self.pwdTextField];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 点击触摸时 取消键盘事件
/**
 *  使用view的touchesBegan:触摸事件来实现对键盘的隐藏，当点击view的区域就会触发这个事件
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nameTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
}
#pragma mark 登录按钮能否点击
-(void)checkNameAndPwd{
    self.loginBtn.enabled = (self.nameTextField.text.length && self.pwdTextField.text.length);
}

- (IBAction)rmbPwd {
    if(self.rmbSwitch.isOn == NO){
        [self.auoLoginSwitch setOn:NO animated:YES];
    }else{
//        //将界面数据存储
//        //1.获取沙盒路径
//        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/pwd.data"];
//        
//        //2.获取UI界面数据封装成对象
//        Contact *contact = [[Contact alloc] init];
//        contact.name = self.nameTextField.text;
//        contact.telNum = self.pwdTextField.text;
//        
//        //3.存储数据
//        [NSKeyedArchiver archiveRootObject:contact toFile:path];
    }
}

- (IBAction)autoLogin {
    if (self.auoLoginSwitch.isOn) {
        [self.rmbSwitch setOn:YES animated:YES];
    }
}

- (IBAction)Login {
    
    //错误信息处理
    if(![self.nameTextField.text isEqualToString:@"cz"]){
        [MBProgressHUD showError:@"用户名不存在"];
        return;
    }
    if(![self.pwdTextField.text isEqualToString:@"123"]){
        [MBProgressHUD showError:@"密码错误！"];
        return;
    }
    

    //创建蒙板
    [MBProgressHUD showMessage:@"正在登录..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        [self performSegueWithIdentifier:@"login2contacts" sender:nil];
    });
}
/**
 *  执行segue之后，跳转之前调用
 *  在此可以向下一个控制器传递数据
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //获取目标控制器
    UIViewController *destination = segue.destinationViewController;
    destination.title = [NSString stringWithFormat:@"%@的联系人",self.nameTextField.text];
}
@end
