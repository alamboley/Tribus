//
//  BagItemUIViewController.h
//  ChipmunkWrapper
//
//  Created by Mac on 10/06/12.
//  Copyright (c) 2012 Sodeso. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMGridView.h"

@interface BagItemUIViewController : UIViewController <GMGridViewDataSource, GMGridViewActionDelegate>
{
    __gm_weak GMGridView *_gmGridView;
     
    NSMutableArray *_data;
    __gm_weak NSMutableArray *_currentData;
    NSInteger _lastDeleteItemIndexAsked;
}
@end
