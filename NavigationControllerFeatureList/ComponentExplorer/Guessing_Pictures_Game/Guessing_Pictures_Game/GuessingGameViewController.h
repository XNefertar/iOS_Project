//
//  ViewController.h
//  Guessing_Pictures_Game
//
//  Created by ByteDance on 2025/8/28.
//

#import <UIKit/UIKit.h>

@interface GuessingGameViewController : UIViewController
@property(nonatomic, strong) UIImageView* questionImageView;
@property(nonatomic, strong) UILabel* questionTitleLabel;
@property(nonatomic, strong) UICollectionView* answerCollectionView;
@property(nonatomic, strong) UICollectionView* optionsCollectionView;

@end
