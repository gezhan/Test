//
//  CustormAlertBottomView.m
//  WinShare
//
//  Created by GZH on 2017/5/13.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "CustormAlertBottomView.h"
#import "AlertBottomCell.h"

@interface CustormAlertBottomView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)UITableView * myTableView;

@end

@implementation CustormAlertBottomView
-(NSArray * )dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithObject:@[@"取消"]];
    }
    return _dataArray ;
}

-(UITableView *)myTableView {
    if (_myTableView == nil) {
        //创建tableView
        _myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0) style:UITableViewStylePlain];
        
        //设置tableView的代理和属性
        _myTableView.delegate=self;
        _myTableView.dataSource=self;
        _myTableView.scrollEnabled = NO;
        //    _tableView.backgroundColor = [UIColor whiteColor];
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.tableFooterView = [UIView new];
        [self.view addSubview:_myTableView];
        //这个应该是那个线
        if ([_myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_myTableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_myTableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return _myTableView ;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.titleArr.count > 0) {
        [self.dataArray insertObject:self.titleArr atIndex:0];
    }
    
    CGFloat rowHeight = 44 ;
    CGFloat headerHeight = 12 ;
    /** 设置myTableView的高度 */
    CGFloat myTableViewHeight = 0 ;
    for (NSArray * array in self.dataArray) {
        myTableViewHeight +=rowHeight*array.count ;
    }
    myTableViewHeight += headerHeight*(self.dataArray.count -1);
    
    self.myTableView.height = myTableViewHeight ;
    
    //延迟.1秒执行这个方法
    [self performSelector:@selector(delayAction) withObject:nil afterDelay:.1];
    
}


- (void)delayAction {
    [UIView animateWithDuration:.5 animations:^{
        _myTableView.top = SCREEN_HEIGHT-_myTableView.height;
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}



////选中单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0) {
        [self dismissViewControllerAnimated:NO completion:^{
            if (_clickBlock) {
                _clickBlock(indexPath.row);
            }
        }];
    } else {
        [self disissViewController];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AlertBottomCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[AlertBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.nameLab.text = self.dataArray[indexPath.section][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else {
        return 12;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}




//点击蒙版 蒙版退下
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([touches anyObject].view == self.view) {
        [self disissViewController];
    }
}

-(void)disissViewController {
    [UIView animateWithDuration:.35 animations:^{
        _myTableView.top = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
