//
//  ViewController.m
//  Image_Carousel
//
//  Created by ByteDance on 2025/8/25.
//

#import "ViewController.h"

#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCROLL_VIEW_Y  100.0f
#define SCROLL_VIEW_H  250.0f
#define IMAGE_COUNT    6

@interface ImageCarouselViewController () <UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView* scrollView;
@property(nonatomic, strong) NSArray<UIImage*>* images;
@end

@implementation ImageCarouselViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self setupScrollView];
}


#pragma mark - Setup
- (void)loadData {
    self.images = @[
        [UIImage imageNamed:@"image1"],
        [UIImage imageNamed:@"image2"],
        [UIImage imageNamed:@"image3"],
        [UIImage imageNamed:@"image4"],
        [UIImage imageNamed:@"image5"],
        [UIImage imageNamed:@"image6"]
    ];
}

- (void)setupScrollView {
    CGRect frame = CGRectMake(0, SCROLL_VIEW_Y, SCREEN_WIDTH, SCROLL_VIEW_H);
    self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    CGFloat contentWidth = SCREEN_WIDTH * IMAGE_COUNT;
    self.scrollView.contentSize = CGSizeMake(contentWidth, 0);
    
    for (int i = 0; i < IMAGE_COUNT; ++i) {
        UIImageView* imageView = [[UIImageView alloc] initWithImage:self.images[i]];
        CGFloat imageX = i * SCREEN_WIDTH;
        imageView.frame = CGRectMake(imageX, 0, SCREEN_WIDTH, SCROLL_VIEW_H);
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:imageView];
    }
    [self.view addSubview:self.scrollView];
}


@end
