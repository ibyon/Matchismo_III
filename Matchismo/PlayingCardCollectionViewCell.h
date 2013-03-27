//
//  PlayingCardCollectionViewCell.h
//  Matchismo
//
//  Created by bgbb on 3/24/13.
//  Copyright (c) 2013 Qpoo Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardView.h"

@interface PlayingCardCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end
