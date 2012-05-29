//
//  ShopItemUIController.h
//  Tribus
//
//  Created by lbineau on 14/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Color.h"

@interface ShopItemUIController : UIViewController{
    bool clicked;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *motifImage;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (retain, nonatomic) NSDictionary *colors;
@property (retain, nonatomic) NSString *colorsId;
- (IBAction)buyAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *priceImage;

@end
