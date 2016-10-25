//
//  LeftMenuViewController.m
//  Tadpole
//
//  Created by ss-iOS-LLY on 15/12/7.
//  Copyright © 2015年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "MainViewController.h"
#import "SpeechTomViewController.h"
//#import "MineViewController.h"
#import "ScanViewController.h"
#import "LoginViewController.h"


@interface LeftMenuViewController ()
@property (nonatomic, readwrite, strong)UITableView *myTableView;

@end

@implementation LeftMenuViewController
#pragma mark - Method
- (void)installControll
{
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 *5) / 2.0f, self.view.frame.size.width, 54 * 5) style:UITableViewStylePlain];
    self.myTableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin |UIViewAutoresizingFlexibleWidth;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.opaque = NO;
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.backgroundView = nil;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.bounces = NO;
    [self.view addSubview:self.myTableView];

}
#pragma mark -
#pragma mark - UITableView   Delegate 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"leftVC";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor   = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc]init];
    }
    NSArray *titles = @[@"Home", @"Calendar", @"Profile", @"Settings", @"Log Out"];
    NSArray *images = @[@"IconHome", @"IconCalendar", @"IconProfile", @"IconSettings", @"IconEmpty"];
    cell.textLabel.text = titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:[[MainViewController alloc]init]]];
            [self.sideMenuViewController hideMenuViewController];
            
            break;
        case 1:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:[[SpeechTomViewController alloc]init]]];
            [self.sideMenuViewController hideMenuViewController];
            
            break;
        case 4:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc]initWithRootViewController:[[LoginViewController alloc]init]]];
            [self.sideMenuViewController hideMenuViewController];
            
            break;
        default:
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self installControll];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];

    if ([[def objectForKey:@"isFinishedLogin"]boolValue] ) {
        NSLog(@"%@",[def objectForKey:@"isFinishedLogin"]);
        [self tableView:self.myTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    }
   
}

@end
