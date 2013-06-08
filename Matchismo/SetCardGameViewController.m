//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by bgbb on 3/5/13.
//  Copyright (c) 2013 Qpoo Lab. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "PlayingSetCard.h"
#import "PlayingSetCardDeck.h"
#import "CardMatchingGame.h"
#import "SetCardCollectionViewCell.h"
#import "SetCardView.h"

@interface SetCardGameViewController ()
//@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation SetCardGameViewController

-(NSUInteger) startingCardCount
{
    return 20;
}

- (Deck *)createDeck
{
    return [[PlayingSetCardDeck alloc] init];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SetCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card];
    return cell;
}


- (void) updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    if ([cell isKindOfClass:[SetCardCollectionViewCell class]]){
        SetCardView *setCardView = ((SetCardCollectionViewCell *) cell).setCardView;
        if ([card isKindOfClass:[PlayingSetCard class]]){
            PlayingSetCard *setCard = (PlayingSetCard *)card;

            NSLog(@"card content:%@",card.contents);
            
            setCardView.rank = setCard.rank;
            setCardView.suit = setCard.suit;
            setCardView.color = setCard.color;
            setCardView.shading = setCard.shading;
            setCardView.faceUp = setCard.isFaceUp;
            setCardView.alpha = setCard.isUnplayable ? 0.3 : 1.0;
        }
    }
}


@end
