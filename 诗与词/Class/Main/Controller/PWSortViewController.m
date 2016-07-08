//
//  PWSortViewController.m
//  诗与词
//
//  Created by apple on 16/6/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PWSortViewController.h"
#import "TRPoetry.h"
#import "TRDBManager.h"
@interface PWSortViewController ()
@property (nonatomic,strong)NSArray *sortArray;

@end

@implementation PWSortViewController
-(NSArray *)sortArray
{
    if(!_sortArray)
    {
        _sortArray=[TRDBManager getAllPoetryKinds];
    }
    return _sortArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat inset = 15;
    CGFloat buttonHeight = 30;
    CGFloat buttonWidth = 100;
    
    //数据源
    NSLog(@"%@",self.sortArray);
    for (int i = 0; i < self.sortArray.count; i++) {
        //创建button
        UIButton *button = [UIButton new];
        //设置button属性
        button.frame = CGRectMake(inset, i*(inset+buttonHeight)+inset, buttonWidth, buttonHeight);
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_selected"] forState:UIControlStateHighlighted];
        //第i个按钮的模型对象
        TRPoetry *poetry = self.sortArray[i];
        [button setTitle:poetry.poetryKindName forState:UIControlStateNormal];
        //字体大小
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        //设置button的tag为循环变量
        button.tag = i;
        //添加button的action
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置button文本颜色
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        //添加到view
        [self.view addSubview:button];
        
    }
    
    //设置弹出控制器显示的宽和高
    self.preferredContentSize = CGSizeMake(2*inset+buttonWidth, self.sortArray.count*(inset+buttonHeight)+inset);
    
    
    

    
}
- (void)clickButton:(UIButton *)button {
    //选中哪个button(发送通知的参数:sort值)
    //button.tag -> TRSort(self.sortArray)
    TRPoetry *poetry = self.sortArray[button.tag];
    //发送通知(参数:sort)
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TRSortDidChange" object:self userInfo:@{@"TRPoetry":poetry}];
    //收回控制器
    [self dismissViewControllerAnimated:YES completion:nil];
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
