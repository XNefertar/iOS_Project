//
//  MenuViewController.m
//  NavigationControllerFeatureList
//
//  Created by ByteDance on 2025/8/19.
//

#import "MenuViewController.h"
#import "Calcultor_Adder_Frame/Calcultor_Adder_Frame/ViewController.h"
#import "Picture_Browser/Picture_Browser/ViewController.h"
#import "Image_Carousel/Image_Carousel/ViewController.h"

@interface MenuViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView* tableView;
@property(nonatomic, strong) NSArray<NSString*>* menuItems;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"功能列表";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.menuItems = @[@"加法器", @"图片浏览器", @"图片轮播器"];
    
//    [self addControlSubviews];
//    [self setupAutoLaytouConstraints];
    [self setupTableView];
}

#pragma mark - Lazy Load
- (UIButton*)adderButton {
    if (_adderButton == nil) {
        _adderButton = [self createMenuButtonWithTitle:@"加法器" action:@selector(openCalculator)];
    }
    return _adderButton;
}

- (UIButton*)imageBrowserButton {
    if (_imageBrowserButton == nil) {
        _imageBrowserButton = [self createMenuButtonWithTitle:@"图片浏览器" action:@selector(openPictureBrowser)];
    }
    return _imageBrowserButton;
}

- (UIButton*)imageCarouselButton {
    if (_imageCarouselButton == nil) {
        _imageCarouselButton = [self createMenuButtonWithTitle:@"图片轮播器" action:@selector(openImageCarousel)];
    }
    return _imageCarouselButton;
}

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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MenuItemCell" forIndexPath:indexPath];
    NSString* title = self.menuItems[indexPath.row];
    cell.textLabel.text = title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0: {
            CalculatorViewController* calculatorVC = [[CalculatorViewController alloc] init];
            [self.navigationController pushViewController:calculatorVC animated:YES];
            break;
        }
        case 1:{
            PictureBrowserViewController* pictureBrowserVC = [[PictureBrowserViewController alloc] init];
            [self.navigationController pushViewController:pictureBrowserVC animated:YES];
            break;
        }
        case 2:{
            ImageCarouselViewController* imageCarouselVC = [[ImageCarouselViewController alloc] init];
            [self.navigationController pushViewController:imageCarouselVC animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark - Add Subviews
- (void)addControlSubviews {
    [self.view addSubview:self.adderButton];
    [self.view addSubview:self.imageBrowserButton];
    [self.view addSubview:self.imageCarouselButton];
}

#pragma mark - Auto Layout Constraints
- (void)setupAutoLaytouConstraints {
    // Adder Button Constraints
    [self.adderButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.adderButton.bottomAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-10].active = YES;
    [self.adderButton.widthAnchor constraintEqualToConstant:220].active = YES;
    [self.adderButton.heightAnchor constraintEqualToConstant:50].active = YES;
    
    // Image Browser Button Constraints
    [self.imageBrowserButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.imageBrowserButton.topAnchor constraintEqualToAnchor:self.adderButton.bottomAnchor constant:20].active = YES;
    [self.imageBrowserButton.widthAnchor constraintEqualToConstant:220].active = YES;
    [self.imageBrowserButton.heightAnchor constraintEqualToConstant:50].active = YES;
    
    // Image Carousel Button
    [self.imageCarouselButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.imageCarouselButton.topAnchor constraintEqualToAnchor:self.imageBrowserButton.bottomAnchor constant:20].active = YES;
    [self.imageCarouselButton.widthAnchor constraintEqualToConstant:220].active = YES;
    [self.imageCarouselButton.heightAnchor constraintEqualToConstant:50].active = YES;
}


#pragma mark - Button Actions
- (void)openCalculator {
    CalculatorViewController* calculatorVC = [[CalculatorViewController alloc] init];
    [self.navigationController pushViewController:calculatorVC animated:YES];
}

- (void)openPictureBrowser {
    PictureBrowserViewController* pictureBrowserVC = [[PictureBrowserViewController alloc] init];
    [self.navigationController pushViewController:pictureBrowserVC animated:YES];
}

- (void)openImageCarousel {
    ImageCarouselViewController* imageCarouselVC = [[ImageCarouselViewController alloc] init];
    [self.navigationController pushViewController:imageCarouselVC animated:YES];
}

#pragma mark - Create Menu Method
- (UIButton*) createMenuButtonWithTitle:(NSString*) title action:(SEL)action {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
//    button.frame = CGRectMake(0, 0, 220, 50);
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

@end
