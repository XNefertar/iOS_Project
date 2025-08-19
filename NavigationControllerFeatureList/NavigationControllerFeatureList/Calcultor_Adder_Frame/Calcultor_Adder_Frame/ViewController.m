//
//  ViewController.m
//  Calcultor_Adder_Frame
//
//  Created by ByteDance on 2025/8/18.
//

#import "Calculator.h"
#import "ViewController.h"

@interface CalculatorViewController ()

// 计算器类
@property (nonatomic, strong) Calculator* adder;

// 输入框
@property (nonatomic, strong) UITextField *number1Field;
@property (nonatomic, strong) UITextField *number2Field;

// 标签
@property (nonatomic, strong) UILabel *plusLabel;
@property (nonatomic, strong) UILabel *equalLabel;
@property (nonatomic, strong) UILabel *resultLabel;

// 按钮
@property (nonatomic, strong) UIButton *calculateButton;


@end

@implementation CalculatorViewController

//- (void)addCalculateButton{
//    int number1 = [self.number1Field.text intValue];
//    int number2 = [self.number2Field.text intValue];
//    
//    self.resultLabel.text = [NSString stringWithFormat:@"%d", number1 + number2];
//}

- (void) notifyAndRenewResult {
    [self.adder setParam1:[self.number1Field.text intValue] AndParam2:[self.number2Field.text intValue]];
    NSInteger res = [self.adder addCompute];
    self.resultLabel.text = [NSString stringWithFormat:@"%ld", res];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.adder = [[Calculator alloc] initWithDefaultValue];
    
    self.number1Field = [[UITextField alloc] init];
    self.number1Field.placeholder = @"0";
    self.number1Field.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.number1Field];
    
    self.plusLabel = [[UILabel alloc] init];
    self.plusLabel.text = @"+";
    [self.view addSubview:self.plusLabel];
    
    self.number2Field = [[UITextField alloc] init];
    self.number2Field.placeholder = @"0";
    self.number2Field.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.number2Field];
    
    self.equalLabel = [[UILabel alloc] init];
    self.equalLabel.text = @"=";
    [self.view addSubview:self.equalLabel];
    
    self.resultLabel = [[UILabel alloc] init];
    self.resultLabel.text = @"0";
    [self.view addSubview:self.resultLabel];
    
    self.calculateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.calculateButton setTitle:@"Calculate" forState:UIControlStateNormal];
//    [self.calculateButton addTarget:self action:@selector(addCalculateButton) forControlEvents:UIControlEventTouchUpInside];
    [self.calculateButton addTarget:self action:@selector(notifyAndRenewResult) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.calculateButton];
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // 硬编码「不推荐」
    //    self.number1Field.frame = CGRectMake(45, 113, 28, 34);
    //    self.number2Field.frame = CGRectMake(144, 113, 58, 34);
    //    self.plusLabel.frame = CGRectMake(224, 119, 11, 21);
    //    self.equalLabel.frame = CGRectMake(268, 119, 42, 21);
    //    self.calculateButton.frame = CGRectMake(149, 164, 95, 35);
    
    // 定义布局常量
    CGFloat startY = self.view.safeAreaInsets.top + 120.0;
    
    // 左右边距
    CGFloat horizonPadding = 20.0;
    
    // 控件间距
    CGFloat spacing = 15.0;
    
    // 尺寸定义
    CGFloat textFieldHeight = 40.0;
    CGFloat textFieldWidth = 80.0;
    CGFloat operatorLabelWidth = 30.0;
    
    // 设置frame
    self.number1Field.frame = CGRectMake(horizonPadding, startY, textFieldWidth, textFieldHeight);
    
    // + 标签起始坐标 = 第一个输入框的右边界 + 控件间距
    CGFloat plusLabelX = CGRectGetMaxX(self.number1Field.frame) + spacing;
    self.plusLabel.frame = CGRectMake(plusLabelX, startY, operatorLabelWidth, textFieldHeight);
    
    CGFloat number2FieldX = CGRectGetMaxX(self.plusLabel.frame) + spacing;
    self.number2Field.frame = CGRectMake(number2FieldX, startY, textFieldWidth, textFieldHeight);
    
    CGFloat equalLabelX = CGRectGetMaxX(self.number2Field.frame) + spacing;
    self.equalLabel.frame = CGRectMake(equalLabelX, startY, operatorLabelWidth, textFieldHeight);
    
    CGFloat resultLabelX = CGRectGetMaxX(self.equalLabel.frame) + spacing;
    self.resultLabel.frame = CGRectMake(resultLabelX, startY, textFieldWidth, textFieldHeight);
    
    // 按钮的居中布局
    CGFloat buttonWidth = 200.0;
    CGFloat buttonHeight = 45.0;
    
    // 居中的X坐标
    // (屏幕宽度 - 按钮宽度) / 2
    CGFloat buttonX = (self.view.bounds.size.width - buttonWidth) / 2;
    CGFloat buttonY = CGRectGetMaxY(self.number1Field.frame) + 20.0;
    self.calculateButton.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight);
    
}

@end
