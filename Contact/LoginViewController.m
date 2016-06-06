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

#define LoginFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"login.data"]

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
    
    //页面显示后 做的预处理：是否自动记住密码，是否自动登录，设置通知机制
    [self preLogin];
    
}

#pragma mark 去除控制器中所有的通知
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 记住密码以及自动登录处理
-(void)preLogin{
    
    //是否记住密码或自动登录
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL rmbPwd = [defaults boolForKey:@"rmbPwd"];
    BOOL autoLogin = [defaults boolForKey:@"auto"];
    if(rmbPwd){
        [self.rmbSwitch setOn:YES animated:NO];
        self.nameTextField.text = [defaults objectForKey:@"name"];
        self.pwdTextField.text = [defaults objectForKey:@"pwd"];
    }
    if(autoLogin){
        [self.auoLoginSwitch setOn:YES animated:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self Login];
        });
    }
    
    //设置文本框 通知机制
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(checkNameAndPwd) name:UITextFieldTextDidChangeNotification object:self.nameTextField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(checkNameAndPwd) name:UITextFieldTextDidChangeNotification object:self.pwdTextField];
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

#pragma mark 记住密码处理
- (IBAction)rmbPwd {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(self.rmbSwitch.isOn == NO){
        [self.auoLoginSwitch setOn:NO animated:YES];
        [defaults setBool:NO forKey:@"rmbPwd"];
    }else{
        //用户名和密码存储
        [defaults setBool:YES forKey:@"rmbPwd"];
        [defaults setObject:self.nameTextField.text forKey:@"name"];
        [defaults setObject:self.pwdTextField.text forKey:@"pwd"];
    }
}

#pragma mark 自动登录处理
- (IBAction)autoLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (self.auoLoginSwitch.isOn) {
        [self.rmbSwitch setOn:YES animated:YES];
        [defaults setBool:YES forKey:@"auto"];
        [defaults setBool:YES forKey:@"rmbPwd"];
    }else{
        [defaults setBool:NO forKey:@"auto"];
    }
}

#pragma mark 登录
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
#pragma mark 控制器跳转传数据
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //获取目标控制器
    UIViewController *destination = segue.destinationViewController;
    destination.title = [NSString stringWithFormat:@"%@的联系人",self.nameTextField.text];
}
@end
