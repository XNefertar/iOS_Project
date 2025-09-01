//
//  OptionModel.h
//  Guessing_Pictures_Game
//
//  Created by ByteDance on 2025/8/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OptionModel : NSObject
@property(nonatomic, copy) NSString* text;
@property(nonatomic, assign) BOOL isSelected;
@property(nonatomic, assign) NSInteger currentIndex;

@end

NS_ASSUME_NONNULL_END
