//
//  DeckViewController.m
//  DraftWithFriends
//
//  Created by Trent Ellingsen on 12/19/13.
//  Copyright (c) 2013 Ryan Schroeder. All rights reserved.
//

#import "DeckViewController.h"
#import "StackedCardCell.h"
#import "StackedImageView.h"
#import "DeckViewModel.h"
#import "ImageStack.h"

NSString * const kStackedCardCellKey = @"stackedCardCell";

@interface DeckViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

// Raw data for the deck
@property (nonatomic) DeckViewModel *deckViewModel;

// The way the data needs to be stored for the view
@property (nonatomic) NSArray *imageStacks;

@end

@implementation DeckViewController

- (DeckViewModel *)deckViewModel
{
    if (!_deckViewModel) {
        _deckViewModel = [DeckViewModel new];
    }
    
    return _deckViewModel;
}

#pragma mark - Collection View methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageStacks.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    StackedCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kStackedCardCellKey forIndexPath:indexPath];
	
    ImageStack *imageStack = self.imageStacks[indexPath.row];
    [cell.stackedImageView setVisibleImageIndex:[imageStack visibleImageIndex]];
    [cell.stackedImageView setImageStack:[imageStack images]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    StackedCardCell *stackedCardCell = (StackedCardCell *)cell;
	
    ImageStack *imageStack = self.imageStacks[indexPath.row];
    imageStack.visibleImageIndex = stackedCardCell.stackedImageView.visibleImageIndex;
}

#pragma mark - configure methods

- (void)configureCards
{
    NSMutableArray *imageStacks = [NSMutableArray new];
    
    for (NSArray *cards in self.deckViewModel.potentialCards) {
        [imageStacks addObject:[[ImageStack alloc] initWithImages:cards]];
    }
    
    self.imageStacks = imageStacks;
    
    [self.collectionView reloadData];
}

- (void)configureCollectionView
{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

#pragma mark - View methods

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureCollectionView];
    [self configureCards];
}

@end