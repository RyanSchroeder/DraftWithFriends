//
//  DrawViewController.h
//  DraftWithFriends
//
//  Created by Trent Ellingsen on 3/8/14.
//  Copyright (c) 2014 Trent Ellingsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompleteDeck.h"

@interface DrawViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSArray *cards;
@property (nonatomic) Card *firstPick;

@property (nonatomic) CompleteDeck *completeDeck;

@end
