//
//  UntouchableUIView.m
//  Tribus
//
//  Created by lbineau on 03/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UntouchableUIView.h"

@implementation UntouchableUIView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
/*
 * Override method to no receive event on the background !
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    for (UIView * view in [self subviews]) {
        if ([view pointInside:[self convertPoint:point toView:view] withEvent:event]) {
            return YES;
        }
    }
    return NO;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
