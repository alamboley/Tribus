//
//  UILabelCustomFontTwCenMT.m
//  ChipmunkWrapper
//
//  Created by Mac on 03/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "UILabelCustomFontTwCenMT.h"

@implementation UILabelCustomFontTwCenMT
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
    self.font = [UIFont fontWithName:@"TwCenMT-Regular" size:self.font.pointSize];
}
@end
