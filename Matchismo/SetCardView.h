//
//  SetCardView.h
//  Matchismo_III
//
//  Created by bgbb on 5/10/13.
//  Copyright (c) 2013 Qpoo Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
@property (nonatomic) NSString *shading;
@property (nonatomic) NSString *color;

@property (nonatomic) BOOL faceUp;

@end
