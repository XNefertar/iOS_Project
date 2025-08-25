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
@property(nonatomic, strong) UIPageControl* pageControl;

@property(nonatomic, strong) UIImageView* leftImageView;
@property(nonatomic, strong) UIImageView* centerImageView;
@property(nonatomic, strong) UIImageView* rightImageView;

@property(nonatomic, strong) NSArray<UIImage*>* images;
@property(nonatomic, assign) NSInteger currentIndex;
@end

@implementation ImageCarouselViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self setupScrollView];
    [self setupPageControl];
    [self updateImageViews];
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
    
//    CGFloat contentWidth = SCREEN_WIDTH * IMAGE_COUNT;
//    self.scrollView.contentSize = CGSizeMake(contentWidth, SCROLL_VIEW_H - 1);
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 3, SCROLL_VIEW_H - 1);
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:NO];
    [self.view addSubview:self.scrollView];
    
//    for (int i = 0; i < IMAGE_COUNT; ++i) {
//        UIImageView* imageView = [[UIImageView alloc] initWithImage:self.images[i]];
//        CGFloat imageX = i * SCREEN_WIDTH;
//        imageView.frame = CGRectMake(imageX, 0, SCREEN_WIDTH, SCROLL_VIEW_H);
//        
//        imageView.contentMode = UIViewContentModeScaleAspectFit;
//        [self.scrollView addSubview:imageView];
//    }
//    [self.view addSubview:self.scrollView];
    
    self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCROLL_VIEW_H)];
    self.centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCROLL_VIEW_H)];
    self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, SCROLL_VIEW_H)];
    
    for (UIImageView* imageView in @[self.leftImageView, self.centerImageView, self.rightImageView]) {
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.scrollView addSubview:imageView];
    }
}

- (void) updateImageViews {
    if (self.images.count == 0) return;
    
    NSInteger leftIndex = (self.currentIndex - 1 + self.images.count) % self.images.count;
    NSInteger rightIndex = (self.currentIndex + 1) % self.images.count;
    NSInteger currentIndex = self.currentIndex;
    
    self.leftImageView.image = self.images[leftIndex];
    self.rightImageView.image = self.images[rightIndex];
    self.centerImageView.image = self.images[currentIndex];
    self.pageControl.currentPage = currentIndex;
}

- (void)setupPageControl {
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.numberOfPages = self.images.count;
    self.pageControl.currentPage = 0;
    self.pageControl.userInteractionEnabled = NO;
    
    [self.pageControl sizeToFit];
    self.pageControl.center = CGPointMake(SCREEN_WIDTH / 2, SCROLL_VIEW_H + SCROLL_VIEW_Y + 10);
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    
    [self.view addSubview:self.pageControl];
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    CGFloat offsetX = scrollView.contentOffset.x;
//    CGFloat pageWidth = scrollView.frame.size.width;
//    int currentPage = round(offsetX / pageWidth);
//    self.pageControl.currentPage = currentPage;
//}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat width = scrollView.frame.size.width;
    
    if (offsetX >= 2 * width) {
        self.currentIndex = (self.currentIndex + 1) % self.images.count;
    } else if (offsetX <= 0) {
        self.currentIndex = (self.currentIndex - 1 + self.images.count) % self.images.count;
    }
    
    [self updateImageViews];
    [scrollView setContentOffset:CGPointMake(width, 0)];
}
@end
