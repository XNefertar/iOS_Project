//
//  ViewController.m
//  Calcultor_Adder_Frame
//
//  Created by ByteDance on 2025/8/18.
//

#import "Calculator.h"
#import "ViewController.h"

static const CGFloat topPadding = 120.0;
static const CGFloat spacing = 12.0;
static const CGFloat textFieldHeight = 40.0;
static const CGFloat textFieldWidth = 80.0;
static const CGFloat operatorLabelWidth = 25.0;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupProperties];
    [self addAllSubviews];
    [self setupConstranints];
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

#pragma mark Setup
- (void)setupProperties {
    self.plusLabel.text = @"+";
    self.equalLabel.text = @"=";
    self.resultLabel.text = @"0";
    
    self.number1Field.placeholder = @"0";
    self.number2Field.placeholder = @"0";
    
    self.number1Field.borderStyle = UITextBorderStyleRoundedRect;
    self.number2Field.borderStyle = UITextBorderStyleRoundedRect;
    
    self.calculateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.calculateButton setTitle:@"Calculate" forState:UIControlStateNormal];
    [self.calculateButton addTarget:self action:@selector(notifyAndRenewResult) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addAllSubviews {
    self.number1Field.translatesAutoresizingMaskIntoConstraints = NO;
    self.plusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.number2Field.translatesAutoresizingMaskIntoConstraints = NO;
    self.equalLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.resultLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.calculateButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.number1Field];
    [self.view addSubview:self.number2Field];
    [self.view addSubview:self.plusLabel];
    [self.view addSubview:self.equalLabel];
    [self.view addSubview:self.resultLabel];
    [self.view addSubview:self.calculateButton];
}

- (void)setupConstranints {
    UILayoutGuide* safeArea = self.view.safeAreaLayoutGuide;
    
    // 1. number1Field
    [self.number1Field.leadingAnchor constraintEqualToAnchor:safeArea.leadingAnchor constant:20.0].active = YES;
    [self.number1Field.topAnchor constraintEqualToAnchor:safeArea.topAnchor constant:topPadding].active = YES;
    [self.number1Field.widthAnchor constraintEqualToConstant:textFieldWidth].active = YES;
    [self.number1Field.heightAnchor constraintEqualToConstant:textFieldHeight].active = YES;
    
    // 2. plusLabel
    [self.plusLabel.leadingAnchor constraintEqualToAnchor:self.number1Field.trailingAnchor constant:spacing].active = YES;
    [self.plusLabel.centerYAnchor constraintEqualToAnchor:self.number1Field.centerYAnchor].active = YES;
    [self.plusLabel.widthAnchor constraintEqualToConstant:operatorLabelWidth].active = YES;
    
    // 3. number2Field
    [self.number2Field.leadingAnchor constraintEqualToAnchor:self.plusLabel.trailingAnchor constant:spacing].active = YES;
    [self.number2Field.centerYAnchor constraintEqualToAnchor:self.number1Field.centerYAnchor].active = YES;
    [self.number2Field.widthAnchor constraintEqualToConstant:textFieldWidth].active = YES;
    [self.number2Field.heightAnchor constraintEqualToConstant:textFieldHeight].active = YES;
    
    // 4. equalLabel
    [self.equalLabel.leadingAnchor constraintEqualToAnchor:self.number2Field.trailingAnchor constant:spacing].active = YES;
    [self.equalLabel.centerYAnchor constraintEqualToAnchor:self.number1Field.centerYAnchor].active = YES;
    [self.equalLabel.widthAnchor constraintEqualToConstant:operatorLabelWidth].active = YES;
    
    // 5. resultLabel
    [self.resultLabel.leadingAnchor constraintEqualToAnchor:self.equalLabel.trailingAnchor constant:spacing].active = YES;
    [self.resultLabel.centerYAnchor constraintEqualToAnchor:self.number1Field.centerYAnchor].active = YES;
    // 让 resultLabel 的右边不要超出屏幕
    [self.resultLabel.trailingAnchor constraintLessThanOrEqualToAnchor:safeArea.trailingAnchor constant:-20.0].active = YES;
    
    // --- Calculate Button 约束 ---
    [self.calculateButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.calculateButton.topAnchor constraintEqualToAnchor:self.number1Field.bottomAnchor constant:20.0].active = YES;
    [self.calculateButton.widthAnchor constraintEqualToConstant:200.0].active = YES;
    [self.calculateButton.heightAnchor constraintEqualToConstant:45.0].active = YES;
    
}

#pragma mark - Button Action
- (void)notifyAndRenewResult {
    [self.adder setParam1:[self.number1Field.text intValue] AndParam2:[self.number2Field.text intValue]];
    NSInteger res = [self.adder addCompute];
    self.resultLabel.text = [NSString stringWithFormat:@"%ld", res];
}

@end
