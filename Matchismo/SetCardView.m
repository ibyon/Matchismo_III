//
//  SetCardView.m
//  Matchismo_III
//
//  Created by bgbb on 5/10/13.
//  Copyright (c) 2013 Qpoo Lab. All rights reserved.
//

#import "SetCardView.h"
#import "PlayingSetCard.h"
#define SQG_WIDTH 45.0
#define SQG_HEIGHT 21.0
#define SQG_ORIGIN_X 8.0
#define SQG_ORIGIN_Y 17.0

#define CENTER_X(x)  (x+(SQG_WIDTH/2))
#define CENTER_Y(y)  (y+(SQG_HEIGHT/2))

#define GET_OFFSET_X(x) x-CENTER_X(SQG_ORIGIN_X)
#define GET_OFFSET_Y(y) y-CENTER_Y(SQG_ORIGIN_Y)

#define POINTX_OFFSET  GET_OFFSET_X(12.63)
#define POINTY_OFFSET  GET_OFFSET_Y(34.48)

#define C1_P1X_OFFSET  GET_OFFSET_X(16.71)
#define C1_P1Y_OFFSET  GET_OFFSET_Y(16.72)
#define C1_P2X_OFFSET  GET_OFFSET_X(2.55)
#define C1_P2Y_OFFSET  GET_OFFSET_Y(32.48)
#define C1_P3X_OFFSET  GET_OFFSET_X(9.51)
#define C1_P3Y_OFFSET  GET_OFFSET_Y(18.00)

#define C2_P1X_OFFSET  GET_OFFSET_X(34.99)
#define C2_P1Y_OFFSET  GET_OFFSET_Y(21.23)
#define C2_P2X_OFFSET  GET_OFFSET_X(21.87)
#define C2_P2Y_OFFSET  GET_OFFSET_Y(15.81)
#define C2_P3X_OFFSET  GET_OFFSET_X(26.58)
#define C2_P3Y_OFFSET  GET_OFFSET_Y(20.47)


#define C3_P1X_OFFSET  GET_OFFSET_X(46.53)
#define C3_P1Y_OFFSET  GET_OFFSET_Y(18.53)
#define C3_P2X_OFFSET  GET_OFFSET_X(44.72)
#define C3_P2Y_OFFSET  GET_OFFSET_Y(22.10)
#define C3_P3X_OFFSET  GET_OFFSET_X(41.51)
#define C3_P3Y_OFFSET  GET_OFFSET_Y(23.01)

#define C4_P1X_OFFSET  GET_OFFSET_X(49.88)
#define C4_P1Y_OFFSET  GET_OFFSET_Y(33.15)
#define C4_P2X_OFFSET  GET_OFFSET_X(53.42)
#define C4_P2Y_OFFSET  GET_OFFSET_Y(12.37)
#define C4_P3X_OFFSET  GET_OFFSET_X(56.13)
#define C4_P3Y_OFFSET  GET_OFFSET_Y(27.16)

#define C5_P1X_OFFSET  GET_OFFSET_X(30.97)
#define C5_P1Y_OFFSET  GET_OFFSET_Y(34.20)
#define C5_P2X_OFFSET  GET_OFFSET_X(44.10)
#define C5_P2Y_OFFSET  GET_OFFSET_Y(38.68)
#define C5_P3X_OFFSET  GET_OFFSET_X(37.23)
#define C5_P3Y_OFFSET  GET_OFFSET_Y(35.34)

#define C6_P1X_OFFSET  GET_OFFSET_X(12.44)
#define C6_P1Y_OFFSET  GET_OFFSET_Y(36.33)
#define C6_P2X_OFFSET  GET_OFFSET_X(23.14)
#define C6_P2Y_OFFSET  GET_OFFSET_Y(32.77)
#define C6_P3X_OFFSET  GET_OFFSET_X(21.84)
#define C6_P3Y_OFFSET  GET_OFFSET_Y(25.51)


@interface SetCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;
@property (nonatomic) UIColor *fillColor;
@property (nonatomic) UIColor *strokeColor;
@end

@implementation SetCardView


#pragma mark - Properties

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90

- (CGFloat)faceCardScaleFactor
{
    if (!_faceCardScaleFactor) _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    return _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor
{
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

- (void)setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

- (void)setShading:(NSString *)shading
{
    _shading = shading;
    [self setNeedsDisplay];
}

- (void)setColor:(NSString *)color
{
    _color = color;
    [self setNeedsDisplay];
}

- (UIColor *)getUIColorWithAlpha:(CGFloat)alpha
{
    //color
    UIColor *targetColor;
    if ([self.color isEqualToString: COLOR_RED]) {
        targetColor = [UIColor colorWithRed:(CGFloat)238.0f/255.0f
                                      green:(CGFloat)38.0f/255.0f
                                       blue:(CGFloat)105.0f/255.0f
                                      alpha:alpha ];
    }else if ([self.color isEqualToString: COLOR_GREEN]) {
        targetColor = [UIColor colorWithRed:(CGFloat)0.0
                                      green:(CGFloat)128.0f/255.0f
                                       blue:(CGFloat)40.0f/255.0f
                                      alpha:alpha ];
    }else if ([self.color isEqualToString: COLOR_BLUE]){
        targetColor = [UIColor colorWithRed:(CGFloat)37.0f/255.0f
                                      green:(CGFloat)0.0
                                       blue:(CGFloat)138.0f/255.0f
                                      alpha:alpha ];
    }
    return targetColor;
}


#define CORNER_RADIUS 12.0
#define TWO_CARD_CENTER_PADDING_PERCENTAGE 0.20
#define SIDE_BORDER_PADDING_PERCENTAGE 0.18
#define LEADING_PERCENTAGE 0.8

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CORNER_RADIUS];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [self drawCard];
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
}

- (void)drawCard
{
    NSLog(@"color %@", self.color);
    NSLog(@"suit %@", self.suit);
    NSLog(@"shade %@", self.shading);
    NSLog(@"rank %d", self.rank);
    

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // setting fill color
    if ( [self.shading isEqualToString:SHADE_SOLID])    {
        self.fillColor = [self getUIColorWithAlpha:(CGFloat)1.0];
    }else if ([self.shading isEqualToString:SHADE_STRIPED]){
        self.fillColor = [self getUIColorWithAlpha:(CGFloat)0.2];
    }else if ( [self.shading isEqualToString:SHADE_CLEAR]){
        self.fillColor = [self getUIColorWithAlpha:(CGFloat)0.0];
    }
    //setting stroke color
    self.strokeColor = [self getUIColorWithAlpha:(CGFloat)1.0];
    
    NSMutableArray *centers = [[NSMutableArray alloc] init];
    
    if (self.rank == 1 || self.rank == 3)
    {
        [centers addObject:[NSValue valueWithCGPoint:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)]];
    }

    if ( self.rank == 2)
    {
        [centers addObject:[NSValue valueWithCGPoint:CGPointMake(self.bounds.size.width/2,
                                                                 self.bounds.size.height/2 - self.bounds.size.height*TWO_CARD_CENTER_PADDING_PERCENTAGE)]];
        [centers addObject:[NSValue valueWithCGPoint:CGPointMake(self.bounds.size.width/2,
                                                                 self.bounds.size.height/2 + self.bounds.size.height*TWO_CARD_CENTER_PADDING_PERCENTAGE)]];

    }
    
    if ( self.rank == 3)
    {
        [centers addObject:[NSValue valueWithCGPoint:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/4)]];
         [centers addObject:[NSValue valueWithCGPoint:CGPointMake(self.bounds.size.width/2, 3*(self.bounds.size.height/4))]];
    }
    
    
    
    for (int i = 0; i < self.rank; i++){
        CGPoint center = [[centers objectAtIndex:i] CGPointValue];
        if ([self.suit isEqualToString:SUIT_DIAMOND]){
            [self drawDiamond: center ];
            [self pushContextUpsideDownRotate:YES];
            [self drawDiamond: center ];
            [self popContext];
        }else if ([self.suit isEqualToString:SUIT_CIRCLE]){
            [self drawOval: center ];
            //[self pushContextUpsideDownRotate:YES];
            //[self drawOval: center ];
            //[self popContext];
        }else if ([self.suit isEqualToString:SUIT_SQUARE]){
            [self drawSquiggle: center ];
            //[self popContext];
        }
    }
    
    
}

#define DIAMOND_HOFFSET_PERCENTAGE 0.32
#define DIAMOND_VOFFSET_PERCENTAGE 0.10

- (void)drawDiamond:(CGPoint) center
{
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    CGPoint origin = CGPointMake(center.x - DIAMOND_HOFFSET_PERCENTAGE*self.bounds.size.width,center.y);
    [aPath moveToPoint:origin];
    [aPath addLineToPoint:CGPointMake(center.x, center.y - DIAMOND_VOFFSET_PERCENTAGE*self.bounds.size.height)];
    [aPath addLineToPoint:CGPointMake(center.x+DIAMOND_HOFFSET_PERCENTAGE*self.bounds.size.width,
                                      center.y)];
    
    [self.fillColor setFill];
    [self.strokeColor setStroke];
    [aPath fill];
    [aPath stroke];
}

- (void)drawSquiggle:(CGPoint) center
{
    UIBezierPath *aPath = [[UIBezierPath alloc] init];
    double x = center.x;
    double y = center.y;
    
    //NSLog(@"squiggle center:%f, %f",x,y);
    
    //NSLog(@"squigle 1st point:%f, %f, offset:%f, %f ",x+POINTX_OFFSET, y+POINTY_OFFSET, POINTX_OFFSET, POINTY_OFFSET);
    
    [aPath moveToPoint:CGPointMake(x+POINTX_OFFSET, y+POINTY_OFFSET)];
    
    //NSLog(@"squiggle 1st curve point 1:%f, %f", x+C1_P1X_OFFSET,y+C1_P1Y_OFFSET);
    [aPath addCurveToPoint:CGPointMake(x+C1_P1X_OFFSET, y+C1_P1Y_OFFSET) controlPoint1:CGPointMake(x+C1_P2X_OFFSET, y+C1_P2Y_OFFSET) controlPoint2:CGPointMake(x+C1_P3X_OFFSET, y+C1_P3Y_OFFSET)];
    
    [aPath addCurveToPoint:CGPointMake(C2_P1X_OFFSET+x, C2_P1Y_OFFSET+y) controlPoint1:CGPointMake(x+C2_P2X_OFFSET, y+C2_P2Y_OFFSET) controlPoint2:CGPointMake(x+C2_P3X_OFFSET, y+C2_P3Y_OFFSET)];
    
    [aPath addCurveToPoint:CGPointMake(x+C3_P1X_OFFSET, y+C3_P1Y_OFFSET) controlPoint1:CGPointMake(x+C3_P2X_OFFSET, y+C3_P2Y_OFFSET) controlPoint2:CGPointMake(x+C3_P3X_OFFSET, y+C3_P3Y_OFFSET)];
    
    
    [aPath addCurveToPoint:CGPointMake(x+C4_P1X_OFFSET, y+C4_P1Y_OFFSET) controlPoint1:CGPointMake(x+C4_P2X_OFFSET, y+C4_P2Y_OFFSET) controlPoint2:CGPointMake(x+C4_P3X_OFFSET, y+C4_P3Y_OFFSET)];
    
    [aPath addCurveToPoint:CGPointMake(x+C5_P1X_OFFSET, y+C5_P1Y_OFFSET) controlPoint1:CGPointMake(x+C5_P2X_OFFSET, y+C5_P2Y_OFFSET) controlPoint2:CGPointMake(x+C5_P3X_OFFSET, y+C5_P3Y_OFFSET)];
    
    [aPath addCurveToPoint:CGPointMake(x+C6_P1X_OFFSET, y+C6_P1Y_OFFSET) controlPoint1:CGPointMake(x+C6_P2X_OFFSET, y+C6_P2Y_OFFSET) controlPoint2:CGPointMake(x+C6_P3X_OFFSET, y+C6_P3Y_OFFSET)];
    
    [self.fillColor setFill];
    [self.strokeColor setStroke];
    [aPath fill];
    [aPath stroke];    
    
}

#define OVAL_HOFFSET_PERCENTAGE 0.22
#define OVAL_VOFFSET_PERCENTAGE 0.15
#define DEGREES_TO_RADIAN(angle) ((angle) / 180.0 * M_PI)

- (void)drawOval:(CGPoint) center
{
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    CGPoint origin = CGPointMake(center.x - OVAL_HOFFSET_PERCENTAGE*self.bounds.size.width,
                                 center.y - OVAL_VOFFSET_PERCENTAGE*self.bounds.size.width);

    [aPath moveToPoint:origin];
    [aPath addLineToPoint:CGPointMake(center.x + OVAL_HOFFSET_PERCENTAGE*self.bounds.size.width,
                                      center.y - OVAL_VOFFSET_PERCENTAGE*self.bounds.size.width)];
   
    [aPath addArcWithCenter:CGPointMake([aPath currentPoint].x,center.y)
                     radius:OVAL_VOFFSET_PERCENTAGE*self.bounds.size.width
                 startAngle:DEGREES_TO_RADIAN(270)
                   endAngle:DEGREES_TO_RADIAN(90)
                  clockwise:YES];
    
    [aPath addLineToPoint:CGPointMake(center.x-OVAL_HOFFSET_PERCENTAGE*self.bounds.size.width,
                                      center.y + OVAL_VOFFSET_PERCENTAGE*self.bounds.size.width)];

    [aPath addArcWithCenter:CGPointMake(origin.x, center.y)
                     radius:OVAL_VOFFSET_PERCENTAGE*self.bounds.size.width
                 startAngle:DEGREES_TO_RADIAN(90)
                   endAngle:DEGREES_TO_RADIAN(270)
                  clockwise:YES];

    [self.fillColor setFill];
    [self.strokeColor setStroke];
    [aPath fill];
    [aPath stroke];
    
}

- (void)pushContextUpsideDownRotate: (Boolean)rotate
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
}

- (void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

#pragma mark - Gesture Handlers

- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        self.faceCardScaleFactor *= gesture.scale;
        gesture.scale = 1;
    }
}

@end
