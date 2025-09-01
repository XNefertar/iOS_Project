//
//  CharacterCollectionViewCell.m
//  Guessing_Pictures_Game
//
//  Created by ByteDance on 2025/8/28.
//

#import "CharacterCollectionViewCell.h"

@implementation CharacterCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.characterLabel = [[UILabel alloc] init];
        self.characterLabel.textColor = [UIColor blackColor];
        self.characterLabel.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.characterLabel];
        self.characterLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.characterLabel.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
        [self.characterLabel.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
    }
    return self;
}
@end
