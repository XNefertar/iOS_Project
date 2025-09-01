//
//  QuestionModel.h
//  Guessing_Pictures_Game
//
//  Created by ByteDance on 2025/8/28.
//

#import <Foundation/Foundation.h>
#import "OptionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuestionModel : NSObject
@property(nonatomic, copy) NSString* answer;
@property(nonatomic, copy) NSString* icon;
@property(nonatomic, copy) NSString* title;
@property(nonatomic, strong) NSArray<OptionModel*>* optionArray;

- (instancetype)initWithDictionary: (NSDictionary*)dict;
@end

NS_ASSUME_NONNULL_END
