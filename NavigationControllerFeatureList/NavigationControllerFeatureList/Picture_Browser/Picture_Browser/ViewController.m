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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self loadData];
    [self setupInitialState];
    [self addAllSubviews];
    [self setupConstraints];
}

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
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.clipsToBounds = YES;
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

#pragma mark - Setup
- (void)setupInitialState {
    self.currentIndex = 0;
    [self updatePictureModel];
    
    UIImage* preivousIcon = [UIImage imageNamed:@"left_highlighted"];
    [self.previousButton setImage:preivousIcon forState:UIControlStateNormal];
    [self.previousButton addTarget:self action:@selector(switchPreviousPicture) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage* nextIcon = [UIImage imageNamed:@"right_highlighted"];
    [self.nextButton setImage:nextIcon forState:UIControlStateNormal];
    [self.nextButton addTarget:self action:@selector(switchNextPicture) forControlEvents:UIControlEventTouchUpInside];
    
    [self updateVisibility];
}

- (void)addAllSubviews {
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.descriptionField.translatesAutoresizingMaskIntoConstraints = NO;
    self.previousButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.nextButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.previousButton];
    [self.view addSubview:self.nextButton];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.descriptionField];
}

- (void)setupConstraints {
    UILayoutGuide *safeArea = self.view.safeAreaLayoutGuide;
        
    [self.imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.imageView.topAnchor constraintEqualToAnchor:safeArea.topAnchor constant:20.0].active = YES;
    [self.imageView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.8].active = YES;
    
    [self.imageView.heightAnchor constraintLessThanOrEqualToAnchor:self.imageView.widthAnchor].active = YES;
    [self.imageView.heightAnchor constraintLessThanOrEqualToAnchor:safeArea.heightAnchor multiplier:0.65].active = YES;
    
//    [self.descriptionField.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
//    [self.descriptionField.topAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:20.0].active = YES;
//    [self.descriptionField.topAnchor constraintGreaterThanOrEqualToAnchor:self.imageView.bottomAnchor constant:20.0].active = YES;
//    [self.descriptionField.bottomAnchor constraintEqualToAnchor:self.previousButton.topAnchor constant:-30.0].active = YES;
//    [self.descriptionField.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
    UILayoutGuide* verticalSpaceGuide = [[UILayoutGuide alloc] init];
    [self.view addLayoutGuide:verticalSpaceGuide];
    
    [verticalSpaceGuide.topAnchor constraintEqualToAnchor:self.imageView.bottomAnchor].active = YES;
    [verticalSpaceGuide.bottomAnchor constraintEqualToAnchor:self.previousButton.topAnchor].active = YES;
    [verticalSpaceGuide.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
    [self.descriptionField.centerYAnchor constraintEqualToAnchor:verticalSpaceGuide.centerYAnchor].active = YES;
    [self.descriptionField.centerXAnchor constraintEqualToAnchor:verticalSpaceGuide.centerXAnchor].active = YES;
    [self.descriptionField.topAnchor constraintGreaterThanOrEqualToAnchor:verticalSpaceGuide.topAnchor constant:5.0].active = YES;
    [self.descriptionField.bottomAnchor constraintLessThanOrEqualToAnchor:verticalSpaceGuide.bottomAnchor constant:-5.0].active = YES;
    
    [self.previousButton.bottomAnchor constraintEqualToAnchor:safeArea.bottomAnchor constant:-20.0].active = YES;
    
    CGFloat buttonSize = 44.0;
    [self.previousButton.widthAnchor constraintEqualToConstant:buttonSize].active = YES;
    [self.previousButton.heightAnchor constraintEqualToConstant:buttonSize].active = YES;
    [self.nextButton.widthAnchor constraintEqualToConstant:buttonSize].active = YES;
    [self.nextButton.heightAnchor constraintEqualToConstant:buttonSize].active = YES;
    
    CGFloat buttonSpacing = 100.0;
    [self.nextButton.leadingAnchor constraintEqualToAnchor:self.previousButton.trailingAnchor constant:buttonSpacing].active = YES;
    [self.nextButton.centerYAnchor constraintEqualToAnchor:self.previousButton.centerYAnchor].active = YES;
    [self.previousButton.trailingAnchor constraintEqualToAnchor:self.view.centerXAnchor constant:-(buttonSpacing / 2)].active = YES;
    
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

@end
