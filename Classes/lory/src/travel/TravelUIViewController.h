//
//  TravelUIViewController.h
//  StoryTest
//
//  Created by lbineau on 23/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GenericUIViewController.h"
#import "iCarousel.h"

@interface TravelUIViewController : GenericUIViewController<UITextFieldDelegate>{
    UIActionSheet *actionSheet;
    int currentLine;
    id currentEditedObject;
}
@property (weak, nonatomic) IBOutlet UIPickerView *uiPickerView;
@property (nonatomic, retain) NSMutableDictionary *itemDatas;
@property (nonatomic, retain) NSMutableDictionary *arretDatas;
@property (weak, nonatomic) IBOutlet iCarousel *icarousel;
@property (weak, nonatomic) IBOutlet UIView *travelDetail;
@property (weak, nonatomic) IBOutlet UILabel *departureName;
@property (weak, nonatomic) IBOutlet UILabel *arrivalName;
@property (weak, nonatomic) IBOutlet UILabel *departureLine;
@property (weak, nonatomic) IBOutlet UILabel *arrivalLine;
@property (weak, nonatomic) IBOutlet UITextField *travelName;
@property (weak, nonatomic) IBOutlet UILabel *frequency;
@property (weak, nonatomic) IBOutlet UIButton *departureBtn;
@property (weak, nonatomic) IBOutlet UIButton *arrivalBtn;
- (IBAction)showPickerView:(id)sender;
- (IBAction)validateTravel:(id)sender;
@end
