//
//  MenuViewController.m
//  NavigationControllerFeatureList
//
//  Created by ByteDance on 2025/8/19.
//

#import "MenuViewController.h"
#import "Calculator_Adder_Frame/Calculator_Adder_Frame/ViewController.h"
#import "Picture_Browser/Picture_Browser/ViewController.h"
#import "Image_Carousel/Image_Carousel/ViewController.h"
#import "Guessing_Pictures_Game/Guessing_Pictures_Game/GuessingGameViewController.h"

@interface MenuViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView* tableView;
@property(nonatomic, strong) NSArray<NSArray<NSString*>*>* menuData;
@property(nonatomic, strong) NSArray<NSString*>* sectionTitles;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"功能列表";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.menuData = @[
        @[@"加法器"],
        @[@"图片浏览器", @"图片轮播器"],
        @[@"超级猜图"]
    ];
    
    self.sectionTitles = @[
        @"计算工具", @"媒体功能", @"游戏"
    ];
    
    [self setupTableView];
}

#pragma mark - Lazy Load


#pragma mark - Setup UI
- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MenuItemCell"];
    [self.view addSubview:self.tableView];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor].active = YES;
    [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor].active = YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.menuData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuData[section].count;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionTitles[section];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MenuItemCell" forIndexPath:indexPath];
    NSString* menuItemText = self.menuData[indexPath.section][indexPath.row];
    cell.textLabel.text = menuItemText;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: {
                    CalculatorViewController* calculatorVC = [[CalculatorViewController alloc] init];
                    [self.navigationController pushViewController:calculatorVC animated:YES];
                    break;
                }
                case 1: {
                    
                    break;
                }
                default: {
                    break;
                }
            }
        }
        case 1: {
            switch (indexPath.row) {
                case 0: {
                    PictureBrowserViewController* pictureBrowserVC = [[PictureBrowserViewController alloc] init];
                    [self.navigationController pushViewController:pictureBrowserVC animated:YES];
                    break;
                }
                case 1: {
                    ImageCarouselViewController* imageCarouselVC = [[ImageCarouselViewController alloc] init];
                    [self.navigationController pushViewController:imageCarouselVC animated:YES];
                    break;
                }
                default: {
                    break;
                }
            }
        }
        case 2: {
            switch (indexPath.row) {
                case 0: {
                    GuessingGameViewController* guessingGameVC = [[GuessingGameViewController alloc] init];
                    [self.navigationController pushViewController:guessingGameVC animated:YES];
                    break;
                }
                case 1: {
                    
                    break;
                }
                default:
                    break;
            }
        }
        default: {
            break;
        }
    }
}

@end
