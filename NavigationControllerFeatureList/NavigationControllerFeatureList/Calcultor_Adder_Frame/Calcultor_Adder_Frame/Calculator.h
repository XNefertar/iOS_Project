//
//  Calculator.h
//  Calcultor_Adder_Frame
//
//  Created by ByteDance on 2025/8/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Calculator : NSObject
- (instancetype)initWithDefaultValue;
- (void)setParam1: (NSInteger)param1 AndParam2: (NSInteger)param2;
- (NSInteger)addCompute;
@end

NS_ASSUME_NONNULL_END
