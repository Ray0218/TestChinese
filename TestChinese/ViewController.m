//
//  ViewController.m
//  TestChinese
//
//  Created by Ray on 15/11/20.
//  Copyright © 2015年 Ray. All rights reserved.
//

#import "ViewController.h"
#import "DPFriendModel.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *indexArray;
@property(nonatomic,strong)NSMutableArray *letterResultArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone ;
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *arrsy = [NSArray arrayWithObjects:
                    @"￥hhh, .$",@" ￥Chin ese ",@"开源中国 ",@"www.oschina.net",
                    @"开源技术",@"社区",@"开发者",@"传播",
                    @"2014",@"a1",@"100",@"中国",@"暑假作业",
                    @"键盘", @"鼠标",@"hello",@"world",@"b1",
                    nil];
    
    
    NSMutableArray *modelsToSort = [[NSMutableArray alloc]init];
    for (int i= 0; i<arrsy.count; i++) {
        DPFriendModel *model = [[DPFriendModel alloc]init];
        model.userName = arrsy[i] ;
        model.userAge = i ;
        [modelsToSort addObject:model];
    }
    
    
    self.letterResultArr= [DPFriendModel LetterSortModelArray:modelsToSort] ;
    self.indexArray = [DPFriendModel IndexArray:modelsToSort];
    
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate =self ;
    tableView.dataSource = self ;
    tableView.frame = self.view.bounds ;
    tableView.sectionIndexColor = [UIColor blueColor] ;
    tableView.sectionIndexBackgroundColor = [UIColor greenColor] ;
    [self.view addSubview:tableView];
}

#pragma mark -
#pragma mark - UITableViewDataSource

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [self.indexArray objectAtIndex:section];
    return key;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.indexArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.letterResultArr objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = ((DPFriendModel*)[[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]).userName;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

#pragma mark -
#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    lab.backgroundColor = [UIColor grayColor];
    lab.text = [self.indexArray objectAtIndex:section];
    lab.textColor = [UIColor whiteColor];
    return lab;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"---->%@",[[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:((DPFriendModel*)[[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]).userName
                                                   delegate:nil
                                          cancelButtonTitle:@"YES" otherButtonTitles:nil];
    [alert show];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
