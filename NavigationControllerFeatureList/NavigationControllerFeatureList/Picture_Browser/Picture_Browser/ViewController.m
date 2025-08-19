//
//  ViewController.m
//  Picture_Browser
//
//  Created by ByteDance on 2025/8/18.
//

#import "ViewController.h"
#import "PictureModel.h"

@interface PictureBrowserViewController ()

// Layout Constants
@property(nonatomic, assign) CGFloat startY;
@property(nonatomic, assign) CGFloat horizonPadding;
@property(nonatomic, assign) CGFloat spacing;
@property(nonatomic, assign) CGFloat buttonWidth;
@property(nonatomic, assign) CGFloat buttonHeight;
@property(nonatomic, assign) CGFloat textFieldWidth;
@property(nonatomic, assign) CGFloat textFieldHeight;

@property(nonatomic, strong) NSArray* pictureModels;
@property(nonatomic, strong) UILabel* descriptionField;
@property(nonatomic, assign) NSInteger currentIndex;
@property(nonatomic, strong) UIImageView* imageView;

@property(nonatomic, strong) UIButton* previousButton;
@property(nonatomic, strong) UIButton* nextButton;
@end

@implementation PictureBrowserViewController

#pragma mark - Lazy Load
- (NSArray*)pictureModels {
    if (_pictureModels == nil) {
        _pictureModels = [[NSArray alloc] init];
    }
    return _pictureModels;
}

- (UILabel*)descriptionField {
    if (_descriptionField == nil) {
        _descriptionField = [[UILabel alloc] init];
    }
    return _descriptionField;
}

- (UIImageView*)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    }
    return _imageView;
}

- (UIButton*)previousButton {
    if (_previousButton == nil) {
        _previousButton = [[UIButton alloc] init];
    }
    return _previousButton;
}

- (UIButton*)nextButton {
    if (_nextButton == nil) {
        _nextButton = [[UIButton alloc] init];
    }
    return _nextButton;
}

#pragma mark - Set Layout Constants
- (void)setupLayoutConstants {
    self.startY = self.view.safeAreaInsets.top + 400;
    self.horizonPadding = 20.0;
    self.spacing = 20.0;
    
    self.buttonWidth = 25.0;
    self.buttonHeight = 25.0;
    
    self.textFieldWidth = 100;
    self.textFieldHeight = 100.0;
}


#pragma mark - Add Control Subview
- (void)addControlSubview {
    [self.view addSubview:self.previousButton];
    [self.view addSubview:self.nextButton];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.descriptionField];
}


#pragma mark - Load Picture Models Data
- (void)loadData {
    self.pictureModels = @[
        [PictureModel pictureModelWithDescription:@"picture1" AndImage:[UIImage imageNamed:@"biaoqingdi"]],
        [PictureModel pictureModelWithDescription:@"picture2" AndImage:[UIImage imageNamed:@"bingli"]],
        [PictureModel pictureModelWithDescription:@"picture3" AndImage:[UIImage imageNamed:@"chiniupa"]],
        [PictureModel pictureModelWithDescription:@"picture4" AndImage:[UIImage imageNamed:@"danteng"]],
        [PictureModel pictureModelWithDescription:@"picture5" AndImage:[UIImage imageNamed:@"wangba"]]
    ];
}

#pragma mark - Update State
- (void)updateVisibility {
    self.previousButton.hidden = (self.currentIndex == 0 ? YES : NO);
    self.nextButton.hidden = (self.currentIndex == 4 ? YES : NO);
}

- (void)updatePictureModel {
    self.imageView.image = ((PictureModel*)self.pictureModels[self.currentIndex]).image;
    self.descriptionField.text = ((PictureModel*)self.pictureModels[self.currentIndex]).descriptionText;
}

#pragma mark - Switch Picture
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

#pragma mark - Initialize Button
- (void)setupButtonInitalState {
    UIImage* preivousIcon = [UIImage imageNamed:@"left_highlighted"];
    [self.previousButton setImage:preivousIcon forState:UIControlStateNormal];
    [self.previousButton addTarget:self action:@selector(switchPreviousPicture) forControlEvents:UIControlEventTouchUpInside];
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImage* nextIcon = [UIImage imageNamed:@"right_highlighted"];
    [self.nextButton setImage:nextIcon forState:UIControlStateNormal];
    [self.nextButton addTarget:self action:@selector(switchNextPicture) forControlEvents:UIControlEventTouchUpInside];
    
    [self updateVisibility];
}

#pragma mark - Initialize Display Page
- (void)setupDefaultDisplayPage {
    self.currentIndex = 0;
    self.imageView.image = ((PictureModel*)self.pictureModels[self.currentIndex]).image;
    self.descriptionField.text = ((PictureModel*)self.pictureModels[self.currentIndex]).descriptionText;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self setupLayoutConstants];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupDefaultDisplayPage];
    [self setupButtonInitalState];
    [self addControlSubview];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    CGFloat textFieldX = (self.view.bounds.size.width - self.textFieldWidth) / 2;
    self.descriptionField.frame = CGRectMake(textFieldX, self.startY, self.textFieldWidth, self.textFieldHeight);
    
    self.previousButton.frame = CGRectMake(self.horizonPadding, self.startY, self.buttonWidth, self.buttonHeight);
    CGFloat pictureMaxX = CGRectGetMaxX(self.imageView.frame);
    self.nextButton.frame = CGRectMake(pictureMaxX + self.spacing, self.startY, self.buttonWidth, self.buttonHeight);
}

@end
