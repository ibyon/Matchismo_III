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
//#import <QuartzCore/QuartzCore.h>

@interface SetCardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation SetCardGameViewController

- (CardMatchingGame *)game
{
    if (!_game){
        //reusing CardMatchingGame
        _game = [[CardMatchingGame alloc]
                 initWithCardCount:self.startingCardCount
                 usingDeck:[[PlayingSetCardDeck alloc] init]];
        //as set card is 3 card mode, setting this value as 3
        _game.mode = 3;
    }
    return _game;
}

- (Deck *)createDeck {return nil;}


- (void)updateUI
{
    //NSLog(@"updateUI");
    
//    NSLog(@"flips updated to %d", self.flipCount);

}


@end
