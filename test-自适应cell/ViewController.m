//
//  ViewController.m
//  test-自适应cell
//
//  Created by lzh on 2017/1/18.
//  Copyright © 2017年 lzh. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewCell.h"
#import "MyTableModel.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

/**
 tableView
 @remark tab
 @
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 dataSource
 */
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    
    [self initDataSource];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTableViewCell *cell = (MyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell" forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTableViewCell *cell = (MyTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.model.unfold = !cell.model.unfold;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)initTableView {
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 20;
    [_tableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:@"MyTableViewCell"];
    [self.view addSubview:_tableView];
}

- (void)initDataSource {
    
    NSArray *arr = @[@"我们开发中，在使用UITableView的时候经常会遇到这样的需求：table view的cell中的内容是动态的。于是我们就在table view的代理中手动去计算cell中的内容高度。这样做有两个问题",
                     @"计算代码冗长、复杂。" ,
                     @"每次 reload tableview 的时候，系统会先计算出每一个 cell 的高度，等所有高度计算完毕，确定了 tableview 的contentSize后，才开始渲染视图并显示在屏幕上。如果数据比较多，就会感受到非常明显的卡顿。" ,
                     @"所以，我们应该寻找其他的解决方案。如果你的项目只支持iOS8及以上，那么恭喜你，你只用简单的几步就可以实现自适应cell了。如果是iOS7也没关系，后面我也会讲到，如何在iOS下实现自适应cell。" ,
                     @"在讲具体的实现之前，必须得说一下iOS7中新增的一个API：" ,
                     @"-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath;",
                     @"这个方法用于返回一个 cell 的预估高度，如果实现了这个代理方法，tableview 首次加载的时候就不会调用heightForRowAtIndexPath 方法，而是用 estimatedHeightForRowAtIndexPath 返回的预估高度计算 tableview 的contentSize，然后 tableview 就可以显示出来了，等到 cell 可见的时候，再去调用heightForRowAtIndexPath 获取 cell 的正确高度。", ];
    
    _dataArray = [NSMutableArray array];
    for (NSString *str in arr) {
        MyTableModel *model = [[MyTableModel alloc] init];
        model.content = str;
        [_dataArray addObject:model];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
