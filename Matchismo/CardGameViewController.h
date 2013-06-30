//
//  CardGameViewController.h
//  Matchismo
//
//  Created by bgbb on 2/11/13.
//  Copyright (c) 2013 Qpoo Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

- (Deck *)createDeck; //abstract
- (void) updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card; //abstract
@property (nonatomic) NSUInteger startingCardCount;
@property (nonatomic) NSUInteger mode;
@property (strong, nonatomic) CardMatchingGame *game;

@end
