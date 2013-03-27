//
//  CardGameViewController.h
//  Matchismo
//
//  Created by bgbb on 2/11/13.
//  Copyright (c) 2013 Qpoo Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

- (Deck *)createDeck; //abstract
- (void) updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card; //abstract
@property (nonatomic) NSUInteger startingCardCount;

// to do: clean up
//-(IBAction)dealButton;

//-(IBAction)flipCard:(UIButton *)sender;

//-(void) setCardButtons:(NSArray *)cardButtons;

//-(void) setFlippedCount:(int)flippedCount;
@end
