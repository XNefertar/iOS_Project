//
//  QuestionModel.m
//  Guessing_Pictures_Game
//
//  Created by ByteDance on 2025/8/28.
//

#import "QuestionModel.h"

@implementation QuestionModel
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.answer = dict[@"answer"];
        self.icon = dict[@"icon"];
        self.title = dict[@"title"];
        
        NSMutableArray<OptionModel*>* optionModels = [NSMutableArray array];
        NSArray<NSString*>* optionStrings = dict[@"options"];
        
        for (int i = 0; i < optionStrings.count; ++i) {
            OptionModel* optionModel = [[OptionModel alloc] init];
            optionModel.text = optionStrings[i];
            optionModel.isSelected = FALSE;
            optionModel.currentIndex = i;
            
            [optionModels addObject:optionModel];
        }
        self.optionArray = [optionModels copy];
    }
    return self;
}
@end
