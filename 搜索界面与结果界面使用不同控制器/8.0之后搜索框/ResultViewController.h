//
//  ResultViewController.h
//  8.0之后搜索框
//
//  Created by Zeus on 2017/3/3.
//  Copyright © 2017年 Zeus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *resultArray; //用于显示搜索结果的数组
@end
