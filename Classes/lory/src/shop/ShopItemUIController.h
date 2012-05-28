//
//  ShopItemUIController.h
//  Tribus
//
//  Created by lbineau on 14/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Color.h"
#import "UntouchableUIView.h"

@interface ShopItemUIController : UIViewController{
    int step;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *motifImage;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (retain, nonatomic) NSDictionary *colors;
@property (retain, nonatomic) NSString *colorsId;
@property (retain, nonatomic) NSString *itemId;
@property (retain, nonatomic) NSNumber *bought;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *priceImage;
@property (weak, nonatomic) IBOutlet UntouchableUIView *step1UIView;
@property (weak, nonatomic) IBOutlet UntouchableUIView *step2UIView;
@property (weak, nonatomic) IBOutlet UntouchableUIView *step3UIView;

- (IBAction)buyAction:(id)sender;
- (void) switchStep:(int)theStep;
@end
