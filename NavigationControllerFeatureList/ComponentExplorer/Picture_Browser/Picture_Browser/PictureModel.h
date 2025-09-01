//
//  PictureModel.h
//  Picture_Browser
//
//  Created by ByteDance on 2025/8/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PictureModel : NSObject
@property(nonatomic, copy) NSString* descriptionText;
@property(nonatomic, strong) UIImage* image;

+ (instancetype)pictureModelWithDescription: (NSString*)string AndImage: (UIImage*)image;
@end

NS_ASSUME_NONNULL_END
