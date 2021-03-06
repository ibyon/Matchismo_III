//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by bgbb on 2/18/13.
//  Copyright (c) 2013 Qpoo Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *) deck;

- (void)flipCardAtIndex:(NSUInteger) index;

- (Card *)cardAtIndex:(NSUInteger) index;

- (void)removeCard:(Card *) card;

- (void)removeCardAtIndex:(NSUInteger) index;

- (NSUInteger)indexOfCard:(Card *)card;

- (NSUInteger) numberOfCardsInPlay;


@property (readonly,nonatomic) int score;
@property (nonatomic) int mode;
@property (readonly,nonatomic) NSString *gameStatus;
@property (readonly,nonatomic) BOOL isGameOn;
@property (readonly,nonatomic) NSArray *flippedCards;

@end
