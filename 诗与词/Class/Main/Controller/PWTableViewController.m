//
//  PWTableViewController.m
//  诗与词
//
//  Created by apple on 16/6/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PWTableViewController.h"
#import "TRDBManager.h"
#import "TRPoetry.h"
#import "PWSortViewController.h"
#import "poetryCell.h"
#import "TRPoetryKind.h"
@interface PWTableViewController ()<UIPopoverPresentationControllerDelegate>

@property (nonatomic, strong) NSString *poetryKindStr;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (nonatomic,strong)NSArray *listArray;
//排序值
@property (nonatomic, assign) int selectedSort;
@property (nonatomic,strong)PWSortViewController *sortViewController;
@property (nonatomic,strong)NSArray *poetryArray;
@end

@implementation PWTableViewController
-(NSArray *)poetryArray
{
    if(!_poetryArray)
    {
        _poetryArray=[TRDBManager getAllPoetryKinds];
    }
    return _poetryArray;
}

-(PWSortViewController *)sortViewController
{
    if(!_sortViewController)
    {
        _sortViewController=[PWSortViewController new];
    }
    return _sortViewController;
}
-(NSArray *)listArray
{
    if(!_listArray)
    {
        _listArray=[TRDBManager getAllPoetries:_poetryKindStr];
    }
    return _listArray;
}
- (id)initWithPoetryKind:(NSString *)kindName {
    if (self = [super init]) {
        self.poetryKindStr = kindName;
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"标签"]];
    image.frame=CGRectMake(0, 0, self.tableView.bounds.size.width, 100);
    self.tableView.tableHeaderView =image;
    UIImageView *image2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"欢迎图片1"]];
    image2.frame=CGRectMake(0, 0, self.tableView.bounds.size.width, self.tableView.bounds.size.height-100);
    self.tableView.tableHeaderView =image;
    self.tableView.backgroundView=image2;
//    self.tableView.tableHeaderView.hidden=YES;
    self.tableView.backgroundView.hidden=YES;
 
    
    
    
   
   }
- (IBAction)sortClick:(id)sender {
    self.sortViewController.modalPresentationStyle = UIModalPresentationPopover;
    self.sortViewController.popoverPresentationController.sourceView = self.rightButton;
    self.sortViewController.popoverPresentationController.sourceRect =self.rightButton.bounds;
    self.sortViewController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    self.sortViewController.popoverPresentationController.delegate = self;
    
    //显示
    [self presentViewController:self.sortViewController animated:YES completion:nil];

    
}
//使得popoverController在iphone可以使用
-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    // Return no adaptive presentation style, use default presentation behaviour
    return UIModalPresentationNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   poetryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    TRPoetry *poetry=self.listArray[indexPath.row];
    NSLog(@"数组里的个数%@",self.listArray);
    cell.textLabel.text = poetry.poetryTitle;
    cell.detailTextLabel.text = poetry.poetryAuthor;
    

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
