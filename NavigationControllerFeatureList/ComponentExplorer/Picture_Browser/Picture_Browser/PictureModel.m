//
//  PictureModel.m
//  Picture_Browser
//
//  Created by ByteDance on 2025/8/18.
//

#import "PictureModel.h"

@implementation PictureModel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithDescription: (NSString*)string AndImage: (UIImage*)image {
    if (self = [super init]) {
        self.descriptionText = string;
        self.image = image;
    }
    return self;
}
+ (instancetype)pictureModelWithDescription:(NSString *)string AndImage:(UIImage *)image {
    return [[self alloc] initWithDescription:string AndImage:image];
}

@end
