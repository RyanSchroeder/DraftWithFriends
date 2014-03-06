//
//  StackedImageView.m
//  DraftWithFriends
//
//  Created by Trent Ellingsen on 12/19/13.
//  Copyright (c) 2013 Ryan Schroeder. All rights reserved.
//

#import "StackedImageView.h"
#import "SlidingImageView.h"

#define IMAGE_OFFSET 27
#define IMAGE_HEIGHT 285
#define IMAGE_WIDTH 200

@interface StackedImageView () <UIScrollViewDelegate>

@property (nonatomic) NSArray *imageViews;
@property (nonatomic) CGFloat startingContentOffset;
@property (nonatomic, getter = isConfiguringImages) BOOL configuringImages;

@end

@implementation StackedImageView

- (void)setImageStack:(NSArray *)imageStack
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self configureViewWithImages:imageStack];
    [self displayImages];
    [self scrollToVisibleImage];
}

- (void)displayImages
{
    for (int i = self.imageViews.count - 1; i >= 0; i--) {
        SlidingImageView *imageView = self.imageViews[i];
        imageView.frame = [self imageFrame];
        NSInteger index = self.imageViews.count - i;
        imageView.originalY = imageView.frame.size.height + index * IMAGE_OFFSET;
        imageView.frame = CGRectOffset(imageView.frame, 0, imageView.originalY);
        
        [self addSubview:imageView];
    }
}

- (CGRect)imageFrame
{
    return CGRectMake(0, 0, self.frame.size.width, self.frame.size.width * IMAGE_HEIGHT / IMAGE_WIDTH);
}

- (void)scrollToVisibleImage
{
    [self setContentOffset:CGPointMake(0, self.startingContentOffset - self.visibleImageIndex * IMAGE_OFFSET) animated:NO];
    [self updateImagesAnimated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isConfiguringImages) {
        [self updateImagesAnimated:NO];
        self.configuringImages = NO;
    } else {
        [self updateImagesAnimated:YES];
    }
}

- (void)updateImagesAnimated:(BOOL)animated
{
    for (int i = 0; i < self.imageViews.count; i++) {
        [self updateImageAtIndex:i animated:animated];
    }
}

- (void)updateImageAtIndex:(NSInteger)index animated:(BOOL)animated
{
    SlidingImageView *image = self.imageViews[index];
    
    NSInteger offset = floor((self.startingContentOffset - self.contentOffset.y) / IMAGE_OFFSET);
    BOOL slideAnimationDidOccur = NO;
    
    if (offset > index) {
        slideAnimationDidOccur = [image slideDownAnimated:animated];
    } else if (offset < index) {
        slideAnimationDidOccur = [image slideUpAnimated:animated];
    }
    
    if (offset <= 0) {
        offset = 0;
    } else if (offset >= self.imageViews.count) {
        offset = self.imageViews.count - 1;
    }
    
    if (slideAnimationDidOccur) {
        self.visibleImageIndex = offset;
    }
}

#pragma mark - configure methods

- (void)configureViewWithImages:(NSArray *)images
{
    self.configuringImages = YES;
    
    NSMutableArray *imageViews = [[NSMutableArray alloc] init];
    for (UIImage *image in images) {
        SlidingImageView *imageView = [[SlidingImageView alloc] initWithImage:image];
        [imageViews addObject:imageView];
    }
    
    self.imageViews = [imageViews copy];
    
    // Size of all the images stacked up
    self.contentSize = CGSizeMake(self.frame.size.width,
                                  [self.imageViews[0] size].height * 2 + (self.imageViews.count * IMAGE_OFFSET));
    
    // Scroll to bottom of the list
    self.startingContentOffset = self.contentSize.height - self.frame.size.height;
}

#pragma mark - custom inits

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    self.delegate = self;
    [self setShowsVerticalScrollIndicator:NO];
    [self setShowsHorizontalScrollIndicator:NO];
    
    return self;
}

@end