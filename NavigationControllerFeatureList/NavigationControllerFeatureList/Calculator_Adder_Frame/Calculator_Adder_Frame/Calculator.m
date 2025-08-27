//
//  Calculator.m
//  Calcultor_Adder_Frame
//
//  Created by ByteDance on 2025/8/18.
//

#import "Calculator.h"
@interface Calculator()
@property(nonatomic, assign) NSInteger number1;
@property(nonatomic, assign) NSInteger number2;
@end

@implementation Calculator
- (instancetype)initWithDefaultValue {
    if (self = [super init]) {
        self.number1 = self.number2 = 0;
    }
    return self;
}

- (void)setParam1: (NSInteger)param1 AndParam2: (NSInteger)param2 {
    self.number1 = param1;
    self.number2 = param2;
}

- (NSInteger)addCompute {
    return self.number1 + self.number2;
}
@end
