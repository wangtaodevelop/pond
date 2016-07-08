//
//  PWViewController.m
//  诗与词
//
//  Created by apple on 16/6/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PWViewController.h"
#import "PWTableViewController.h"
#import "TRPoetry.h"
#import "TRPoetryKind.h"
#import "TRDBManager.h"
@interface PWViewController ()
@property (nonatomic,strong)NSArray *poetryArray;
@end

@implementation PWViewController
-(NSArray *)poetryArray
{
    if(!_poetryArray)
    {
        _poetryArray=[TRDBManager getAllPoetryKinds];
    }
    return _poetryArray;
}
- (IBAction)startReadClick:(id)sender {
    for (int i=0; i<self.poetryArray.count; i++) {
        
    
    TRPoetryKind *potrykind=self.poetryArray[i];
   PWTableViewController *tab=[[PWTableViewController alloc]initWithPoetryKind:potrykind.poetryKindName];
        [self presentViewController:tab animated:YES completion:nil];
        
        
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];

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
