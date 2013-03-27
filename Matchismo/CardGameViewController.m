//
//  CardGameViewController.m
//  Matchismo
//
//  Created by bgbb on 2/11/13.
//  Copyright (c) 2013 Qpoo Lab. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController () <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
//@property (weak, nonatomic) IBOutlet UILabel *gameStatusLabel;
//@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSegm;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;

@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation CardGameViewController


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.startingCardCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card];
    return cell;
}

- (void) updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    //abstract
}

- (CardMatchingGame *)game
{
    if (!_game)
        _game = [[CardMatchingGame alloc]
                 initWithCardCount:self.startingCardCount
                 usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck {return nil;} //abstract

- (void)updateUI
{
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]){
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card];
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
//    self.modeSegm.enabled = !self.game.isGameOn;
}


- (void) setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    NSLog(@"flips updated to %d", self.flipCount);
    self.flipLabel.text = [NSString stringWithFormat:@"Flip: %d", self.flipCount];

}
/**
- (void) setGameStatusLabelText{
    self.gameStatusLabel.text = [NSString stringWithFormat:@"%@", self.game.gameStatus];
}
 **/

- (void) setScoreLabelText{
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}


- (IBAction)flipCard:(UITapGestureRecognizer *)gesture {
    
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    //in case clicked in between space
    if (indexPath) {
        [self.game flipCardAtIndex:indexPath.item];
        self.flipCount++;
        //    [self setGameStatusLabelText];
        [self setScoreLabelText];
        [self updateUI];
    }
}

- (IBAction)dealButton {
    
    self.game = nil;
    self.flipCount = 0;
    
    [self updateUI];
}

/**
- (IBAction)selectModeSegm {
    
    if (self.modeSegm.selectedSegmentIndex == 0){
        self.game.mode = 2;
        NSLog(@" 2 card mode");
    }else if (self.modeSegm.selectedSegmentIndex == 1){
        self.game.mode = 3;
        NSLog(@" 3 card mode");
    }
}
**/




@end
