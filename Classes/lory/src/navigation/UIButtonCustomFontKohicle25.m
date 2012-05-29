//
//  UIButtonCustomFontKohicle25.m
//  ChipmunkWrapper
//
//  Created by lbineau on 30/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "UIButtonCustomFontKohicle25.h"

@implementation UIButtonCustomFontKohicle25

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.font = [UIFont fontWithName:@"Kohicle25" size:self.titleLabel.font.pointSize];
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
