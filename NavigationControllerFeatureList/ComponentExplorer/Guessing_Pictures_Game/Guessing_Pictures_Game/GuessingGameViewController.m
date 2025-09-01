//
//  ViewController.m
//  Guessing_Pictures_Game
//
//  Created by ByteDance on 2025/8/28.
//

#import "GuessingGameViewController.h"
#import "QuestionModel.h"
#import "CharacterCollectionViewCell.h"

@interface GuessingGameViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) NSArray<QuestionModel*>* questions;
@property(nonatomic, strong) NSMutableArray<OptionModel*>* answerData;
@property(nonatomic, assign) NSInteger currentQuestionIndex;
@property(nonatomic, strong) QuestionModel* currentQuestion;
@end

@implementation GuessingGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"看图猜词";
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    [self setupViews];
    [self setupLayout];
    
    [self loadData];
    self.currentQuestionIndex = 0;
    [self setupNewQuestion];
}

- (void)setupViews{
    // 实例化所有UI组件，对于UICollectionView，需要创建其布局对象
    // 完成所有非布局相关配置
    
    self.questionImageView = [[UIImageView alloc] init];
    self.questionImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.questionImageView];
    
    self.questionTitleLabel = [[UILabel alloc] init];
    self.questionTitleLabel.textColor = [UIColor whiteColor];
    self.questionTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.questionTitleLabel];
    
    UICollectionViewFlowLayout* answerLayout = [[UICollectionViewFlowLayout alloc] init];
    self.answerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:answerLayout];
    self.answerCollectionView.backgroundColor = [UIColor clearColor];
    self.answerCollectionView.delegate = self;
    self.answerCollectionView.dataSource = self;
    [self.answerCollectionView registerClass:[CharacterCollectionViewCell class] forCellWithReuseIdentifier:@"CharacterCell"];
    [self.view addSubview:self.answerCollectionView];
    
    UICollectionViewFlowLayout* optionsLayout = [[UICollectionViewFlowLayout alloc] init];
    self.optionsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:optionsLayout];
    self.optionsCollectionView.backgroundColor = [UIColor clearColor];
    self.optionsCollectionView.delegate = self;
    self.optionsCollectionView.dataSource = self;
    [self.optionsCollectionView registerClass:[CharacterCollectionViewCell class] forCellWithReuseIdentifier:@"CharacterCell"];
    [self.view addSubview:self.optionsCollectionView];
}

- (void)setupLayout {
    self.questionImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.questionTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.answerCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.optionsCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.questionImageView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20].active = YES;
    [self.questionImageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.questionImageView.widthAnchor constraintEqualToConstant:200].active = YES;
    [self.questionImageView.heightAnchor constraintEqualToConstant:200].active = YES;
            
    [self.questionTitleLabel.topAnchor constraintEqualToAnchor:self.questionImageView.bottomAnchor constant:10].active = YES;
    [self.questionTitleLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    [self.questionTitleLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = YES;
    [self.questionTitleLabel.heightAnchor constraintEqualToConstant:30].active = YES;
            
    [self.answerCollectionView.topAnchor constraintEqualToAnchor:self.questionTitleLabel.bottomAnchor constant:20].active = YES;
    [self.answerCollectionView.heightAnchor constraintEqualToConstant:60].active = YES;
    [self.answerCollectionView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.answerCollectionView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:1.0 constant:-40].active = YES;
            
    [self.optionsCollectionView.topAnchor constraintEqualToAnchor:self.answerCollectionView.bottomAnchor constant:20].active = YES;
    [self.optionsCollectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    [self.optionsCollectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = YES;
    [self.optionsCollectionView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-20].active = YES;
}

- (void)loadData {
    NSString* path = [[NSBundle mainBundle] pathForResource:@"questions" ofType:@"plist"];
    NSArray* plistArray = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray<QuestionModel*>* tempQuestions = [NSMutableArray array];
    for (NSDictionary* dict in plistArray) {
        QuestionModel* model = [[QuestionModel alloc] initWithDictionary:dict];
        [tempQuestions addObject:model];
    }
    self.questions = [tempQuestions copy];
}

- (void)setupNewQuestion {
    if (self.currentQuestionIndex >= self.questions.count) {
        NSLog(@"Game Complete!");
        return;
    }
    
    self.currentQuestion = self.questions[self.currentQuestionIndex];
    
    self.questionImageView.image = [UIImage imageNamed:self.currentQuestion.icon];
    self.questionTitleLabel.text = self.currentQuestion.title;
    
    self.answerData = [NSMutableArray array];
    for (int i = 0; i < self.currentQuestion.answer.length; ++i) {
        OptionModel* emptyModel = [[OptionModel alloc] init];
        emptyModel.text = @"";
        emptyModel.isSelected = NO;
        [self.answerData addObject:emptyModel];
    }
    
    [self.answerCollectionView reloadData];
    [self.optionsCollectionView reloadData];
}

- (void)checkAnswer {
    NSMutableString* userAnswer = [NSMutableString string];
    for (OptionModel* model in self.answerData) {
        [userAnswer appendString:model.text != nil ? model.text : @""];
    }
    
    if (userAnswer.length < self.currentQuestion.answer.length) {
        return;
    }
    
    if ([userAnswer isEqualToString:self.currentQuestion.answer]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恭喜" message:@"答对了！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *nextAction = [UIAlertAction actionWithTitle:@"下一题" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.currentQuestionIndex++;
            [self setupNewQuestion];
        }];
        [alert addAction:nextAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"答案不对，请再试试！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            for (OptionModel *answerSlot in self.answerData) {
                if (answerSlot.text.length > 0) {
                    // 找到对应的选项，恢复它的可见性
                    if (answerSlot.currentIndex >= 0 && answerSlot.currentIndex < self.currentQuestion.optionArray.count) {
                        OptionModel *option = self.currentQuestion.optionArray[answerSlot.currentIndex];
                        option.isSelected = NO;
                    }
                    // 清空答案格子
                    answerSlot.text = @"";
                    answerSlot.isSelected = NO;
                    answerSlot.currentIndex = -1;
                }
            }
            // 刷新 UI
            [self.answerCollectionView reloadData];
            [self.optionsCollectionView reloadData];
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    int columns = 7;
    CGFloat spacing = 10;
    CGFloat totalSpacing = (columns - 1) * spacing;
    CGFloat width = (collectionView.bounds.size.width - totalSpacing) / columns;
    return CGSizeMake(width, width);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (collectionView == self.answerCollectionView) {
        NSInteger count = self.answerData.count;
        if (count == 0) return UIEdgeInsetsZero;
        
        CGSize cellSize = [self collectionView:collectionView
                                layout:collectionViewLayout
                                sizeForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        CGFloat cellWidth = cellSize.width;
        
        CGFloat spacing = [self collectionView:collectionView layout:collectionViewLayout minimumLineSpacingForSectionAtIndex:section];
        
        CGFloat totalContentWidth = count * cellWidth + (count - 1) * spacing;

        // 如果内容宽度 < collectionView 宽度，则左右留空实现居中
        CGFloat inset = MAX((collectionView.bounds.size.width - totalContentWidth) / 2, 0);

        return UIEdgeInsetsMake(0, inset, 0, inset);
    }
    // 选项区不需要居中
    return UIEdgeInsetsZero;
}


#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CharacterCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CharacterCell" forIndexPath:indexPath];
    
    if (collectionView == self.answerCollectionView) {
        // 答案分区
        OptionModel* model = self.answerData[indexPath.item];
        cell.characterLabel.text = model.text;
    } else {
        // 选项分区
        OptionModel* model = self.currentQuestion.optionArray[indexPath.item];
        cell.characterLabel.text = model.text;
        cell.hidden = model.isSelected;
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.answerCollectionView) {
        return self.answerData.count;
    } else {
        return self.currentQuestion.optionArray.count;
    }
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.optionsCollectionView) {
        OptionModel *option = self.currentQuestion.optionArray[indexPath.item];
        if (option.isSelected) return;
        
        // 找答案区的第一个空格
        for (int i = 0; i < self.answerData.count; i++) {
            OptionModel *answerSlot = self.answerData[i];
            if (answerSlot.text.length == 0) {
                answerSlot.text = option.text;
                answerSlot.isSelected = YES;
                // 记录来自哪个选项
                answerSlot.currentIndex = indexPath.item;
                option.isSelected = YES;
                break;
            }
        }
        
        [self.answerCollectionView reloadData];
        [self.optionsCollectionView reloadData];
        // 自动检查答案是否填满
        [self checkAnswer];
    }
    else if (collectionView == self.answerCollectionView) {
        // 点了答案区
        OptionModel *answerSlot = self.answerData[indexPath.item];
        if (answerSlot.text.length == 0) return;
        
        NSInteger currentIndex = answerSlot.currentIndex;
        if (currentIndex >= 0 && currentIndex < self.currentQuestion.optionArray.count) {
            OptionModel *option = self.currentQuestion.optionArray[currentIndex];
            option.isSelected = NO;
        }
        
        // 清除答案格子
        answerSlot.text = @"";
        answerSlot.isSelected = NO;
        answerSlot.currentIndex = -1;
        
        [self.answerCollectionView reloadData];
        [self.optionsCollectionView reloadData];
    }
}


@end
