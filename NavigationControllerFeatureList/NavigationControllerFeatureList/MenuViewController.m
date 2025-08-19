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
    
    UIButton* adderButton = [self createMenuButtonWithTitle:@"加法器" action:@selector(openCalculator)];
    adderButton.center = CGPointMake(self.view.center.x, self.view.center.y - 40);
    
    UIButton* imageBrowserButton = [self createMenuButtonWithTitle:@"图片浏览器" action:@selector(openPictureBrowser)];
    imageBrowserButton.center = CGPointMake(self.view.center.x, self.view.center.y + 40);
    
    [self.view addSubview:adderButton];
    [self.view addSubview:imageBrowserButton];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    button.frame = CGRectMake(0, 0, 220, 50);
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}



@end
