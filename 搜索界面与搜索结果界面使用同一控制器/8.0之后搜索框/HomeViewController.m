
//
//  HomeViewController.m
//  8.0之后搜索框
//
//  Created by Zeus on 2017/2/28.
//  Copyright © 2017年 Zeus. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating>

// 搜索控制器
@property(nonatomic, strong)UISearchController *searchController;

//存放tableView中显示数据的数组
@property (strong,nonatomic) NSMutableArray  *dataArray;
//存放搜索列表中显示数据的数组
@property (strong,nonatomic) NSMutableArray  *searchArray;

@property(nonatomic, strong)UITableView *tableView;
@end

// 屏幕宽高
#define KSCREEN_WIDTCH [UIScreen mainScreen].bounds.size.width
#define KSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //初始化数组并赋值
    self.dataArray=[NSMutableArray arrayWithCapacity:100];
    for (NSInteger i=0; i<1000; i++) {
        [self.dataArray addObject:[NSString
                                  stringWithFormat:@"%ld-hahhaa",(long)i]];
    }
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];// 设置为nil是搜索结果的控制器和用于搜索的控制器是同一个
    self.searchController.searchResultsUpdater = self; //设置代理对象
    self.searchController.dimsBackgroundDuringPresentation = NO; // 开始搜索时，背景变成暗色（当搜索控制器和搜索结果控制器为同一个时，背景是不会变暗的，下同）
    //self.searchController.obscuresBackgroundDuringPresentation = NO; // 开始搜索时，背景变模糊
    //self.searchController.hidesNavigationBarDuringPresentation = NO; // 隐藏导航栏
    // 设置搜索框的frame
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, self.searchController.searchBar.frame.size.height);
    
    // placeholder
    self.searchController.searchBar.placeholder = @"搜索";
    // 将搜索框设置为tableView的表头
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTCH, KSCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"myCell"];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self.view addSubview:self.tableView];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //如果searchController被激活就返回搜索数组的行数，否则返回数据数组的行数
    if (self.searchController.active) {
        return [self.searchArray count];
    }else{
        return [self.dataArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    //如果搜索框被激活，就显示搜索数组的内容，否则显示数据数组的内容
    if (self.searchController.active) {
        [cell.textLabel setText:self.searchArray[indexPath.row]];
    }
    else{
        [cell.textLabel setText:self.dataArray[indexPath.row]];
    }
    return cell;
}


#pragma  mark ---- 执行过滤操作 ---
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    //获取搜索框中用户输入的字符串
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    //如果搜索数组中存在对象，即上次搜索的结果，则清除这些对象
    if (self.searchArray!= nil) {
        [self.searchArray removeAllObjects];
    }
    //通过过滤条件过滤数据
    self.searchArray= [NSMutableArray arrayWithArray:[self.dataArray filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [self.tableView reloadData];
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
