//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by bgbb on 2/18/13.
//  Copyright (c) 2013 Qpoo Lab. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame()
@property (nonatomic) int score;
@property (nonatomic) NSString *gameStatus;
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) BOOL isGameOn;
@property (nonatomic) NSArray *flippedCards;
@end

@implementation CardMatchingGame
#define MATCH_BONUS 4
#define MISMATCH_PENALITY 2
#define FLIP_COST 1


- (NSMutableArray *) cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSMutableArray *selectedCards = [[NSMutableArray alloc] init] ;
    self.gameStatus = nil;
    int matchScore = 0;
    
    if(!self.isGameOn) self.isGameOn = YES;
    
    if(card.isUnplayable) return;

    NSLog(@"mode:%d", self.mode);

    if(!card.isFaceUp) {
        //check if there is other card to compare
        for(Card *otherCard in self.cards){
            if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                [selectedCards addObject:otherCard];
                /**
                if ([selectedCards count]>=self.mode-1){
                    matchScore = [card match:@[otherCard]];
                    break;
                }**/
                
            }
        }// end of for loop

        

        // if there is other card then checking for match
        if ([selectedCards count]>0){
           matchScore = [card match:selectedCards];
        
           // there were more than one card opened and they matched
           if ( matchScore){
               // if it reached max open count - 1 (that is current card)
              if ([selectedCards count] >= self.mode-1){
                 card.unplayable = YES;
                 self.score += matchScore * MATCH_BONUS;
                 self.gameStatus = [NSString stringWithFormat:@"Matching %@",card.contents];
                
                 for(Card *otherCard in selectedCards) {
                     if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                        otherCard.unplayable = YES;
                        self.gameStatus = [self.gameStatus stringByAppendingString:otherCard.contents];
                     }
                 }
                 
                 self.gameStatus = [NSString stringWithFormat:@" %@ for %d points", self.gameStatus, (matchScore*MATCH_BONUS-FLIP_COST)];
                 //remove from table

              }else{
                  self.score += matchScore;
              }
               
           }else{
                self.score -= MISMATCH_PENALITY;
                self.gameStatus = [NSString stringWithFormat:@"%@",card.contents];
               
                for(Card *otherCard in selectedCards) {
                    if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                        otherCard.faceUp = NO;
                        self.gameStatus = [self.gameStatus stringByAppendingString:otherCard.contents];
                    }
                }
                self.gameStatus = [NSString stringWithFormat:@"%@ don't match! %d points penalty", self.gameStatus, (MISMATCH_PENALITY+FLIP_COST)];
            }
        }else{//if there is no other card flipped
            self.gameStatus = [NSString stringWithFormat:@"Flipped up %@", card.contents];
        }

     self.score -= FLIP_COST;
     card.faceUp = !card.isFaceUp;
     [selectedCards addObject:card];
     self.flippedCards = [[NSArray alloc] initWithArray:selectedCards];
        
    
     NSLog(@"card contents: %@ at index %d faceUp %c matchScore %d: flippedCard %d", card.contents, index, card.isFaceUp, matchScore, [self.flippedCards count]);
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

-(NSUInteger)indexOfCard:(Card *)card
{
    return [self.cards indexOfObject:card];
}

- (void)removeCard:(Card *)card
{
    [self.cards removeObject:(card)];
}

-(void)removeCardAtIndex:(NSUInteger)index
{
    assert(index < [self.cards count]);
    
    [self.cards removeObjectAtIndex:index];
}

-(NSUInteger)numberOfCardsInPlay
{
    return self.cards.count;
}

//designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *) deck
{
    self = [super init];
    self.score = 0;
    self.gameStatus = @"Let's begin";
    self.isGameOn = NO;
    self.mode = 2;
    
    if (self) {
        for (int i = 0; i< count;i++){
            Card *card = [deck drawRandomCard];
            
            if (card) {
                self.cards[i] = card;
            }else{
                self = nil;
                break;
            }
        }
        
    }
    return self;
}

@end
