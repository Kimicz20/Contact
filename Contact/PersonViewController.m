//
//  PersonViewController.m
//  Contact
//
//  Created by Geek on 16/5/27.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import "PersonViewController.h"
#import "addViewController.h"
#import "EditViewController.h"
#import "ContactCell.h"
#import "Contact.h"

@interface PersonViewController ()<UIActionSheetDelegate,addViewControllerDelegate,editViewControllerDelegate>

@property (nonatomic,strong) NSMutableArray *contacts;
- (IBAction)logout:(id)sender;

@end

@implementation PersonViewController

-(NSMutableArray *)contacts{
    if(_contacts == nil){
        _contacts = [NSMutableArray array];
    }
    return _contacts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置表格的分割线(去除)
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ContactCell *cell = [ContactCell initWithTableView:tableView];
    
    cell.contact = _contacts[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}

#pragma mark 编辑模式
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (IBAction)logout:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"确定要注销吗？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0 ){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 *  在多个控制器之间的连接过程中，传递数据
 *  通过目标控制器的类型来判断下一个要跳转对应所需要做的操作
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id vc = segue.destinationViewController;
    if([vc isKindOfClass:[addViewController class]]){
        addViewController *addVc = vc;
        addVc.delagate = self;
    }else{
        NSIndexPath *index =[self.tableView indexPathForSelectedRow];
        EditViewController *editVc = vc;
        editVc.contact = self.contacts[index.row];
        editVc.delegate = self;
    }
}

/**
 *  代理方法实现 数据回传
 */
-(void)addViewController:(addViewController *)addVc DidAddContact:(Contact *)contact{
    
    //添加数据
    [self.contacts addObject:contact];
    //刷新表格
    [self.tableView reloadData];
    
}

/**
 *  由于回传的数据是在跳转时候 从当前控制器中传递的对象，所以在 目的控制器中的修改在源控制器中的对象也做了修改
 */
-(void)editViewController:(EditViewController *)editVc DidSaveContact:(Contact *)contact{
    
    [self.tableView reloadData];
}
@end
