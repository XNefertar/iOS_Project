//
//  ViewController.m
//  Calcultor_Adder_Frame
//
//  Created by ByteDance on 2025/8/18.
//

#import "Calculator.h"
#import "ViewController.h"

@interface CalculatorViewController ()
// Frame常量属性
@property(nonatomic, assign) CGFloat startY;
@property(nonatomic, assign) CGFloat horizonPadding;
@property(nonatomic, assign) CGFloat spacing;
@property(nonatomic, assign) CGFloat textFieldHeight;
@property(nonatomic, assign) CGFloat textFieldWidth;
@property(nonatomic, assign) CGFloat operatorLabelWidth;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self setupLabelText];
    [self setupTextFieldProperty];
    [self setupButtonProperty];
    [self setupControlSubview];
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setupLayoutConstants];
    [self setupControlFrame];
    [self setupButtonFrame];
}

#pragma mark - Lazy Load
- (Calculator*)adder {
    if (_adder == nil) {
        _adder = [[Calculator alloc] initWithDefaultValue];
    }
    return _adder;
}

- (UITextField*)number2Field {
    if (_number2Field == nil) {
        _number2Field = [[UITextField alloc] init];
    }
    return _number2Field;
}

- (UILabel*)plusLabel {
    if (_plusLabel == nil) {
        _plusLabel = [[UILabel alloc] init];
    }
    return _plusLabel;
}

- (UILabel*)equalLabel {
    if (_equalLabel == nil) {
        _equalLabel = [[UILabel alloc] init];
    }
    return _equalLabel;
}

- (UILabel*)resultLabel {
    if (_resultLabel == nil) {
        _resultLabel = [[UILabel alloc] init];
    }
    return _resultLabel;
}

- (UITextField*)number1Field {
    if (_number1Field == nil) {
        _number1Field = [[UITextField alloc] init];
    }
    return _number1Field;
}

#pragma mark - Set Label Text
- (void)setupLabelText {
    self.plusLabel.text = @"+";
    self.equalLabel.text = @"=";
    self.resultLabel.text = @"0";
}

#pragma mark - Set TextField Property
- (void)setupTextFieldProperty {
    self.number1Field.placeholder = @"0";
    self.number2Field.placeholder = @"0";
    
    self.number1Field.borderStyle = UITextBorderStyleRoundedRect;
    self.number2Field.borderStyle = UITextBorderStyleRoundedRect;
}

#pragma mark - Set Button Property
- (void)setupButtonProperty {
    self.calculateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.calculateButton setTitle:@"Calculate" forState:UIControlStateNormal];
    [self.calculateButton addTarget:self action:@selector(notifyAndRenewResult) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Button Action
- (void)notifyAndRenewResult {
    [self.adder setParam1:[self.number1Field.text intValue] AndParam2:[self.number2Field.text intValue]];
    NSInteger res = [self.adder addCompute];
    self.resultLabel.text = [NSString stringWithFormat:@"%ld", res];
}

#pragma mark - Add Control Subview
- (void)setupControlSubview {
    [self.view addSubview:self.number1Field];
    [self.view addSubview:self.number2Field];
    [self.view addSubview:self.plusLabel];
    [self.view addSubview:self.equalLabel];
    [self.view addSubview:self.resultLabel];
    [self.view addSubview:self.calculateButton];
}

#pragma mark - Set Layout Constants
- (void)setupLayoutConstants {
    self.startY = self.view.safeAreaInsets.top + 120.0;
    self.horizonPadding = 20.0;
    self.spacing = 15.0;
    self.textFieldHeight = 40.0;
    self.textFieldWidth = 80.0;
    self.operatorLabelWidth = 30.0;
}

#pragma mark - Set Control Frame
- (void)setupControlFrame {
    // 设置frame
    self.number1Field.frame = CGRectMake(self.horizonPadding, self.startY, self.textFieldWidth, self.textFieldHeight);
    
    // + 标签起始坐标 = 第一个输入框的右边界 + 控件间距
    CGFloat plusLabelX = CGRectGetMaxX(self.number1Field.frame) + self.spacing;
    self.plusLabel.frame = CGRectMake(plusLabelX, self.startY, self.operatorLabelWidth, self.textFieldHeight);
    
    CGFloat number2FieldX = CGRectGetMaxX(self.plusLabel.frame) + self.spacing;
    self.number2Field.frame = CGRectMake(number2FieldX, self.startY, self.textFieldWidth, self.textFieldHeight);
    
    CGFloat equalLabelX = CGRectGetMaxX(self.number2Field.frame) + self.spacing;
    self.equalLabel.frame = CGRectMake(equalLabelX, self.startY, self.operatorLabelWidth, self.textFieldHeight);
    
    CGFloat resultLabelX = CGRectGetMaxX(self.equalLabel.frame) + self.spacing;
    self.resultLabel.frame = CGRectMake(resultLabelX, self.startY, self.textFieldWidth, self.textFieldHeight);
}

#pragma mark - Set Button Frame
- (void)setupButtonFrame {
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
