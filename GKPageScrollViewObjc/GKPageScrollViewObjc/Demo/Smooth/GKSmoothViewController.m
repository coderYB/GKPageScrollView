//
//  GKSmoothViewController.m
//  GKPageScrollViewObjc
//
//  Created by QuintGao on 2020/5/8.
//  Copyright © 2020 gaokun. All rights reserved.
//

#import "GKSmoothViewController.h"
#import "GKPageSmoothView.h"
#import <JXCategoryView/JXCategoryView.h>
#import "GKSmoothListView.h"
#import "GKDYHeaderView.h"
#import "GKBaseListViewController.h"
#import <GKNavigationBar/UIScrollView+GKGestureHandle.h>

@interface GKSmoothViewController ()<GKPageSmoothViewDelegate, GKSmoothListViewDelegate>

@property (nonatomic, strong) GKPageSmoothView  *smoothView;

//@property (nonatomic, strong) UIImageView       *headerView;
@property (nonatomic, strong) GKDYHeaderView    *headerView;

@property (nonatomic, strong) JXCategoryTitleView *categoryView;

@end

@implementation GKSmoothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gk_navTitle = @"滑动延续";
    self.gk_navTitleColor = UIColor.whiteColor;
    self.gk_navBarAlpha = 0.0f;
    self.gk_navBackgroundColor = GKColorRGB(34, 33, 37);
    self.gk_statusBarStyle = UIStatusBarStyleLightContent;
    
    [self.view addSubview:self.smoothView];
    [self.smoothView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGRect frame = self.headerView.frame;
        frame.size.height = kDYHeaderHeight;
        self.headerView.frame = frame;
        
        self.categoryView.contentScrollView = self.smoothView.listCollectionView;

        [self.smoothView refreshHeaderView];

        [self.smoothView reloadData];
    });
}

#pragma mark - GKPageSmoothViewDelegate
- (UIView *)headerViewInSmoothView:(GKPageSmoothView *)smoothView {
    return self.headerView;
}

- (UIView *)segmentedViewInSmoothView:(GKPageSmoothView *)smoothView {
    return self.categoryView;
}

- (NSInteger)numberOfListsInSmoothView:(GKPageSmoothView *)smoothView {
    return self.categoryView.titles.count;
}

- (id<GKPageSmoothListViewDelegate>)smoothView:(GKPageSmoothView *)smoothView initListAtIndex:(NSInteger)index {
    GKSmoothListView *listView = [[GKSmoothListView alloc] initWithListType:index];
    listView.delegate = self;
    
    [listView requestData];
    
    return listView;
}

#pragma mark - GKSmoothListViewDelegate
- (void)listViewDidScrollView:(UIScrollView *)scrollView {
    // 导航栏显隐
    CGFloat offsetY = scrollView.contentOffset.y + kDYHeaderHeight + kBaseSegmentHeight;
    // 0-200 0
    // 200 - KDYHeaderHeigh - kNavBarheight 渐变从0-1
    // > KDYHeaderHeigh - kNavBarheight 1
    CGFloat alpha = 0;
    if (offsetY < 200) {
        alpha = 0;
    }else if (offsetY > (kDYHeaderHeight - kNavBarHeight)) {
        alpha = 1;
    }else {
        alpha = (offsetY - 200) / (kDYHeaderHeight - kNavBarHeight - 200);
    }
    self.gk_navBarAlpha = alpha;
    
    [self.headerView scrollViewDidScroll:offsetY];
}

#pragma mark - 懒加载
- (GKPageSmoothView *)smoothView {
    if (!_smoothView) {
        _smoothView = [[GKPageSmoothView alloc] initWithDelegate:self];
        _smoothView.listCollectionView.gk_openGestureHandle = YES;
    }
    return _smoothView;
}

- (GKDYHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[GKDYHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 400)];
    }
    return _headerView;
}

//- (UIImageView *)headerView {
//    if (!_headerView) {
//        _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kBaseHeaderHeight)];
//        _headerView.contentMode = UIViewContentModeScaleAspectFill;
//        _headerView.clipsToBounds = YES;
//        _headerView.image = [UIImage imageNamed:@"test"];
//    }
//    return _headerView;
//}

- (JXCategoryTitleView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kBaseSegmentHeight)];
        _categoryView.titles = @[@"UITableView", @"UICollectionView", @"UIScrollView"];
        _categoryView.backgroundColor = [UIColor whiteColor];
        _categoryView.titleFont = [UIFont systemFontOfSize:14.0f];
        _categoryView.titleSelectedFont = [UIFont systemFontOfSize:16.0f];
        _categoryView.titleColor = [UIColor blackColor];
        _categoryView.titleSelectedColor = [UIColor blackColor];
        _categoryView.titleLabelZoomEnabled = YES;
        
        JXCategoryIndicatorLineView *lineView = [JXCategoryIndicatorLineView new];
        lineView.lineStyle = JXCategoryIndicatorLineStyle_Lengthen;
        _categoryView.indicators = @[lineView];
        
//        _categoryView.contentScrollView = self.smoothView.listCollectionView;
    }
    return _categoryView;
}

@end
