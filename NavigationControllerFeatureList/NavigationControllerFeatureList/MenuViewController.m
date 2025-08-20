//
//  MenuViewController.m
//  NavigationControllerFeatureList
//
//  Created by ByteDance on 2025/8/19.
//

#import "MenuViewController.h"
#import "Calcultor_Adder_Frame/Calcultor_Adder_Frame/ViewController.h"
#import "Picture_Browser/Picture_Browser/ViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"功能列表";
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.adderButton.center = CGPointMake(self.view.center.x, self.view.center.y - 40);
//    self.imageBrowserButton.center = CGPointMake(self.view.center.x, self.view.center.y + 40);
    
    [self addControlSubviews];
    [self setupAutoLaytouConstraints];
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

#pragma mark - Add Subviews
- (void)addControlSubviews {
    [self.view addSubview:self.adderButton];
    [self.view addSubview:self.imageBrowserButton];
}

#pragma mark - Auto Layout Constraints
- (void)setupAutoLaytouConstraints {
    // adder Button Constraints
    [self.adderButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.adderButton.bottomAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-10].active = YES;
    [self.adderButton.widthAnchor constraintEqualToConstant:220].active = YES;
    [self.adderButton.heightAnchor constraintEqualToConstant:50].active = YES;
    
    // image Browser Button Constraints
    [self.imageBrowserButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.imageBrowserButton.topAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:10].active = YES;
    [self.imageBrowserButton.widthAnchor constraintEqualToConstant:220].active = YES;
    [self.imageBrowserButton.heightAnchor constraintEqualToConstant:50].active = YES;
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
