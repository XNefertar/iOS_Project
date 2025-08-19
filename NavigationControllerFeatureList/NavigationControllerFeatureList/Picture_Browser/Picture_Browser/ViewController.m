//
//  ViewController.m
//  Picture_Browser
//
//  Created by ByteDance on 2025/8/18.
//

#import "ViewController.h"
#import "PictureModel.h"

@interface PictureBrowserViewController ()
@property(nonatomic, strong) NSArray* pictureModels;
@property(nonatomic, strong) UILabel* descriptionField;
@property(nonatomic, assign) NSInteger currentIndex;
@property(nonatomic, strong) UIImageView* imageView;

@property(nonatomic, strong) UIButton* previousButton;
@property(nonatomic, strong) UIButton* nextButton;
@end

@implementation PictureBrowserViewController

- (void)loadData {
    self.pictureModels = @[
        [PictureModel pictureModelWithDescription:@"picture1" AndImage:[UIImage imageNamed:@"biaoqingdi"]],
        [PictureModel pictureModelWithDescription:@"picture2" AndImage:[UIImage imageNamed:@"bingli"]],
        [PictureModel pictureModelWithDescription:@"picture3" AndImage:[UIImage imageNamed:@"chiniupa"]],
        [PictureModel pictureModelWithDescription:@"picture4" AndImage:[UIImage imageNamed:@"danteng"]],
        [PictureModel pictureModelWithDescription:@"picture5" AndImage:[UIImage imageNamed:@"wangba"]]
    ];
}

- (void)updateVisibility {
    self.previousButton.hidden = (self.currentIndex == 0 ? YES : NO);
    self.nextButton.hidden = (self.currentIndex == 4 ? YES : NO);
}

- (void)updatePictureModel {
    self.imageView.image = ((PictureModel*)self.pictureModels[self.currentIndex]).image;
    self.descriptionField.text = ((PictureModel*)self.pictureModels[self.currentIndex]).descriptionText;
}

- (void)switchPreviousPicture {
    self.currentIndex -= 1;
    [self updateVisibility];
    [self updatePictureModel];
}

- (void)switchNextPicture {
    self.currentIndex += 1;
    [self updateVisibility];
    [self updatePictureModel];
}

- (void)initButtonVisibility {
    if (self.currentIndex == 0) {
        self.previousButton.hidden = YES;
    } else if (self.currentIndex == 4) {
        self.nextButton.hidden = YES;
    } else {
        self.nextButton.hidden = self.previousButton.hidden = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.currentIndex = 0;
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    self.descriptionField = [[UILabel alloc] init];
    
    self.imageView.image = ((PictureModel*)self.pictureModels[self.currentIndex]).image;
    self.descriptionField.text = ((PictureModel*)self.pictureModels[self.currentIndex]).descriptionText;
    
    self.previousButton = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImage* preivousIcon = [UIImage imageNamed:@"left_highlighted"];
    [self.previousButton setImage:preivousIcon forState:UIControlStateNormal];
    [self.previousButton addTarget:self action:@selector(switchPreviousPicture) forControlEvents:UIControlEventTouchUpInside];
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImage* nextIcon = [UIImage imageNamed:@"right_highlighted"];
    [self.nextButton setImage:nextIcon forState:UIControlStateNormal];
    [self.nextButton addTarget:self action:@selector(switchNextPicture) forControlEvents:UIControlEventTouchUpInside];
    
    [self initButtonVisibility];
    
    [self.view addSubview:self.previousButton];
    [self.view addSubview:self.nextButton];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.descriptionField];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    CGFloat startY = self.view.safeAreaInsets.top + 400;
    CGFloat horizonPadding = 20.0;
    CGFloat spacing = 20.0;
    
    CGFloat buttonWidth = 25.0;
    CGFloat buttonHeight = 25.0;
    
    CGFloat textFieldWidth = 100;
    CGFloat textFieldHeight = 100.0;
    
    CGFloat textFieldX = (self.view.bounds.size.width - textFieldWidth) / 2;
    self.descriptionField.frame = CGRectMake(textFieldX, startY, textFieldWidth, textFieldHeight);
    
    self.previousButton.frame = CGRectMake(horizonPadding, startY, buttonWidth, buttonHeight);
    CGFloat pictureMaxX = CGRectGetMaxX(self.imageView.frame);
    self.nextButton.frame = CGRectMake(pictureMaxX + spacing, startY, buttonWidth, buttonHeight);
}

@end
