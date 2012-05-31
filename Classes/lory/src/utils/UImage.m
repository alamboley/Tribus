//
//  UImage.m
//  ChipmunkWrapper
//
//  Created by Mac on 31/05/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import "UImage.h"

@implementation UImage
// Tint the image
- (UIView*)image:(UIImage*)image WithTint:(UIColor *)tintColor {
    
    UIImageView *originalImageView = [[UIImageView alloc] initWithImage:image];
    [originalImageView setFrame:CGRectMake(0.0f, 0.0f, image.size.width, image.size.height)];
    //[self.view addSubview:originalImageView];
    
    UIView *overlay = [[UIView alloc] initWithFrame:[originalImageView frame]];
    
    UIImageView *maskImageView = [[UIImageView alloc] initWithImage:image];
    [maskImageView setFrame:[overlay bounds]];
    
    [[overlay layer] setMask:[maskImageView layer]];
    
    [overlay setBackgroundColor:[UIColor redColor]];
    
    return overlay;
}
@end
