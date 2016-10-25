//
//  AddressViewController.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/5/10.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "AddressViewController.h"
#import "HomeModel.h"
#import "CityTableViewCell.h"
#import "MJChiBaoZiHeader.h"
#import "MJNIndexView.h"



@interface AddressViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate,UISearchBarDelegate,MJNIndexViewDataSource>
{
    UISearchBar *_searchBar;
    MJChiBaoZiHeader *_header;
}
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UISearchDisplayController *searchVC;


//
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *cityList;
@property (nonatomic, strong) NSMutableArray *hotCityList;
@property (nonatomic, strong) NSMutableArray *titleArr;

//
@property (nonatomic, strong) NSMutableArray *locatedCityArr;
@property (nonatomic, strong) NSMutableArray *recentVisitArr;

// MJNIndexView
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) MJNIndexView *indexView;

#pragma mark all properties from MJNIndexView

// set this to NO if you want to get selected items during the pan (default is YES)
@property (nonatomic, assign) BOOL getSelectedItemsAfterPanGestureIsFinished;

// set the font of the selected index item (usually you should choose the same font with a bold style and much larger)
// (default is the same font as previous one with size 40.0 points)
@property (nonatomic, strong) UIFont *selectedItemFont;

// set the color for index items
@property (nonatomic, strong) UIColor *fontColor;

// set if items in index are going to darken during a pan (default is YES)
@property (nonatomic, assign) BOOL darkening;

// set if items in index are going ti fade during a pan (default is YES)
@property (nonatomic, assign) BOOL fading;

// set the color for the selected index item
@property (nonatomic, strong) UIColor *selectedItemFontColor;

// set index items aligment (NSTextAligmentLeft, NSTextAligmentCenter or NSTextAligmentRight - default is NSTextAligmentCenter)
@property (nonatomic, assign) NSTextAlignment itemsAligment;

// set the right margin of index items (default is 10.0)
@property (nonatomic, assign) CGFloat rightMargin;

// set the upper margin of index items (default is 20.0)
// please remember that margins are set for the largest size of selected item font
@property (nonatomic, assign) CGFloat upperMargin;

// set the lower margin of index items (default is 20.0)
// please remember that margins are set for the largest size of selected item font
@property (nonatomic, assign) CGFloat lowerMargin;

// set the maximum amount for item deflection (default is 75.0)
@property (nonatomic,assign) CGFloat maxItemDeflection;

// set the number of items deflected below and above the selected one (default is 5)
@property (nonatomic, assign) int rangeOfDeflection;

// set the curtain color if you want a curtain to appear (default is none)
@property (nonatomic, strong) UIColor *curtainColor;

// set the amount of fading for the curtain between 0 to 1 (default is 0.2)
@property (nonatomic, assign) CGFloat curtainFade;

// set if you need a curtain not to hide completely
@property (nonatomic, assign) BOOL curtainStays;

// set if you want a curtain to move while panning (default is NO)
@property (nonatomic, assign) BOOL curtainMoves;

// set if you need curtain to have the same upper and lower margins (default is NO)
@property (nonatomic, assign) BOOL curtainMargins;

// set this property to YES and it will automatically set margins so that gaps between items are 5.0 points (default is YES)
@property BOOL ergonomicHeight;

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self change];
    [self setupMyTableView];
    [self refreshBoard];

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f---------%f",self.myTableView.contentOffset.x,self.myTableView.contentOffset.y);
}
- (void)change
{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.title = @"当前城市－上海";
    
}

- (void)setupMyTableView
{
    // addTableView
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
//    self.myTableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin |UIViewAutoresizingFlexibleWidth;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsHorizontalScrollIndicator = NO;
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.opaque = NO;
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.backgroundView = nil;
    self.myTableView.separatorColor = UITableViewCellSeparatorStyleNone;
    self.myTableView.bounces = YES;
    UIView *bView = [[UIView alloc] initWithFrame:self.myTableView.frame];
    bView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.myTableView.backgroundView = bView;
    // 右侧索引
    self.myTableView.sectionIndexColor = [UIColor redColor];
    self.myTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    //self.myTableView.sectionIndexTrackingBackgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.myTableView];
    
    if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.myTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.myTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.myTableView setTableFooterView:view];
    
    //
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    _searchBar.showsScopeBar = YES;
    _searchBar.delegate = self;
    _searchBar.backgroundColor = [UIColor clearColor];
    //    _searchBar.barStyle = UIBarStyleBlack;
    _searchBar.keyboardType = UIKeyboardTypeDefault;
    _searchBar.placeholder = @"  请输入城市中文名称或拼音";
    
    UITextField *searchField;
    if ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0) {
        searchField  = [_searchBar.subviews objectAtIndex:1];
        UIView *segment = [_searchBar.subviews objectAtIndex:0];
        UIView *searchBackView = [[UIView alloc]initWithFrame:segment.bounds];
        searchBackView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [segment addSubview:searchBackView];
    } else {
        
        searchField =[((UIView *)[_searchBar.subviews objectAtIndex:0]).subviews lastObject];
        
        [[[[_searchBar.subviews objectAtIndex:0]subviews]objectAtIndex:0]removeFromSuperview];
        
        [_searchBar setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        
    }
    
    searchField.layer.borderWidth = 0.5;
    searchField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.myTableView setTableHeaderView:_searchBar];
    self.searchVC = [[UISearchDisplayController alloc]initWithSearchBar:_searchBar contentsController:self];
    self.searchVC.delegate = self;
    self.searchVC.searchResultsDataSource = self;
    self.searchVC.searchResultsDelegate = self;
    
    // initialise MJNIndexView
    self.indexView = [[MJNIndexView alloc]initWithFrame:self.myTableView.frame];
    self.indexView.dataSource = self;
    [self firstAttributesForMJNIndexView];
    [self readAttributes];
    [self.view addSubview:self.indexView];
}
- (void)readAttributes
{
    self.getSelectedItemsAfterPanGestureIsFinished = self.indexView.getSelectedItemsAfterPanGestureIsFinished;
    self.font = self.indexView.font;
    self.selectedItemFont = self.indexView.selectedItemFont;
    self.fontColor = self.indexView.fontColor;
    self.selectedItemFontColor = self.indexView.selectedItemFontColor;
    self.darkening = self.indexView.darkening;
    self.fading = self.indexView.fading;
    self.itemsAligment = self.indexView.itemsAligment;
    self.rightMargin = self.indexView.rightMargin;
    self.upperMargin = self.indexView.upperMargin;
    self.lowerMargin = self.indexView.lowerMargin;
    self.maxItemDeflection = self.indexView.maxItemDeflection;
    self.rangeOfDeflection = self.indexView.rangeOfDeflection;
    self.curtainColor = self.indexView.curtainColor;
    self.curtainFade = self.indexView.curtainFade;
    self.curtainMargins = self.indexView.curtainMargins;
    self.curtainStays = self.indexView.curtainStays;
    self.curtainMoves = self.indexView.curtainMoves;
    self.ergonomicHeight = self.indexView.ergonomicHeight;
}

- (void)firstAttributesForMJNIndexView
{
    
    self.indexView.getSelectedItemsAfterPanGestureIsFinished = YES;
    self.indexView.font = [UIFont fontWithName:@"HelveticaNeue" size:13.0];
    self.indexView.selectedItemFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0];
    self.indexView.backgroundColor = [UIColor clearColor];
    self.indexView.curtainColor = nil;
    self.indexView.curtainFade = 0.0;
    self.indexView.curtainStays = NO;
    self.indexView.curtainMoves = YES;
    self.indexView.curtainMargins = NO;
    self.indexView.ergonomicHeight = YES;
    self.indexView.upperMargin = 5.0;
    self.indexView.lowerMargin = 5.0;
    self.indexView.rightMargin = 5.0;
    self.indexView.itemsAligment = NSTextAlignmentRight;
    self.indexView.maxItemDeflection = 100.0;
    self.indexView.rangeOfDeflection = 5;
    self.indexView.fontColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
    self.indexView.selectedItemFontColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    self.indexView.darkening = NO;
    self.indexView.fading = YES;
    
}
#pragma mark --MJNIndexDataSource
- (NSArray *)sectionIndexTitlesForMJNIndexView:(MJNIndexView *)indexView{
    
    
    return self.titleArr;
    
}

// you have to implement this method to get the selected index item
- (void)sectionForSectionMJNIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (index == 0) {
        [self.myTableView setContentOffset:CGPointMake(0,-64)];
    }else {
        [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:index - 1] atScrollPosition: UITableViewScrollPositionTop animated:self.getSelectedItemsAfterPanGestureIsFinished];
    }
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArr.count + 3 ;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ( section == 0 || section == 1 || section == 2) {
        return 1;
    }
    
    return [[self.dataArr objectAtIndex:section - 3] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return 48 + (30 + 8) ;
        
    } else if (indexPath.section == 1){
        return 48 + (30 + 8) ;
    } else if (indexPath.section == 2){
        
        if (self.hotCityList.count / 3 ==0) {
            return 48 + (30 + 8) ;
        } else {
            return 48 + (30 + 8) *(self.hotCityList.count / 3) ;
        }
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 0 || section == 1|| section == 2) {
        return 0;
    }
    
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ( section == 0 || section ==1 || section == 2){
        return nil;
        
    } else {
        // UILabel
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth,30 )];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.text = [NSString stringWithFormat:@"    %@",[self.titleArr objectAtIndex:section + 1]];
        label.backgroundColor = [UIColor purpleColor];
        return label;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.section < 3) {
        CityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CityCell"];
        if (!cell) {
            cell = [[CityTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CityCell"];
        }
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        if (indexPath.section == 0 && self.locatedCityArr.count) {
            //            cell.backgroundColor = [UIColor blackColor];
            [cell setContentWithData:self.locatedCityArr withSection:indexPath.section];
        }
        if (indexPath.section == 1 && self.recentVisitArr.count) {
            [cell setContentWithData:self.recentVisitArr withSection:indexPath.section];
        }
        if (indexPath.section == 2 && self.hotCityList.count) {
            [cell setContentWithData:self.hotCityList withSection:indexPath.section];
        }
        
        return cell;
    } else if (indexPath.section >= 3){
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LoginCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LoginCell"];
        }
        
        
        NSDictionary *dic = [[self.dataArr objectAtIndex:indexPath.section - 3]objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14.f];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.text = [dic objectForKey:@"city_name"];
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark --searchMethod

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;
{
    _header.hidden = YES;
    self.indexView.hidden = YES;
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    
    _header.hidden = NO;
    self.indexView.hidden = NO;
    return YES;
}
#pragma mark --BtnClicked
- (void)buttonClicked:(UIButton*)sender
{
    switch (sender.tag) {
        case 1987:
            //  seacher
            
            break;
            
        default:
            break;
    }
}

#pragma mark --refresh
- (void)refreshBoard
{
    
    _header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    _header.lastUpdatedTimeLabel.hidden = YES;
    [_header beginRefreshing];
    self.myTableView.mj_header = _header;
    
}

- (void)loadNewData
{
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[[HomeModel sharedInstance]getCityData]];
    self.cityList = [NSMutableArray arrayWithArray:[[dic objectForKey:@"data"]objectForKey:@"city_list"]];
    self.hotCityList = [NSMutableArray arrayWithArray:[[dic objectForKey:@"data"]objectForKey:@"hot_city_list"]];
    self.titleArr = [NSMutableArray arrayWithObjects:@"🔍",
                     @"#",
                     @"$",
                     @"✿",
                     @"A",
                     @"B",
                     @"C",
                     @"D",
                     @"E",
                     @"F",
                     @"G",
                     @"H",
                     @"J",
                     @"K",
                     @"L",
                     @"M",
                     @"N",
                     @"P",
                     @"Q",
                     @"R",
                     @"S",
                     @"T",
                     @"W",
                     @"X",
                     @"Y",
                     @"Z",nil];
    NSArray *arrTitles = [NSMutableArray arrayWithObjects:
                          @"🔍",
                          @"#",
                          @"$",
                          @"✿",
                          @"a",
                          @"b",
                          @"c",
                          @"d",
                          @"e",
                          @"f",
                          @"g",
                          @"h",
                          @"j",
                          @"k",
                          @"l",
                          @"m",
                          @"n",
                          @"p",
                          @"q",
                          @"r",
                          @"s",
                          @"t",
                          @"w",
                          @"x",
                          @"y",
                          @"z",nil];
    
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 4; i < arrTitles.count; i++) {
        NSMutableArray *sectionArr = [NSMutableArray arrayWithCapacity:0];
        
        for (NSDictionary *dict in self.cityList) {
            NSString *cityUrl = [dict objectForKey:@"city_url"];
            if ([[cityUrl substringToIndex:1] isEqualToString:arrTitles[i]]) {
                [sectionArr addObject:dict];
            }
        }
        
        [self.dataArr addObject:sectionArr];
    }
    
    //定位
    self.locatedCityArr = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in self.cityList) {
        NSString *cityUrl = [dic objectForKey:@"city_url"];
        if ([cityUrl  isEqualToString:@"shanghai"]) {
            [self.locatedCityArr addObject:dic];
            break;
        }
    }
    
    
    // 最近访问
    self.recentVisitArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 14; i <  17; i++) {
        [self.recentVisitArr addObject:self.cityList[i]];
    }
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.myTableView reloadData];
        [self.myTableView reloadSectionIndexTitles];
        [self.indexView refreshIndexItems];
        // [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:[self.dataArr count] + 2] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        
        // [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [self.myTableView.mj_header endRefreshing];
    });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
