//
//  NMCustomLabel.h
//  NewsMe
//
//  Created by Robert Haining on 8/30/11.
//  Copyright 2011 News.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface NMCustomLabel : UILabel {
	CGFloat maxLineHeight;
	
	CTFramesetterRef framesetter;
	CFMutableAttributedStringRef attrString;
	
	BOOL shouldTruncate;
	
	CTFontRef bodyFont;
	CTFontRef bodyFontBold;
	CTFontRef bodyFontItalic;
	
	CGColorRef backgroundCGColor;
}

@property (nonatomic, readonly) NSString *cleanText;
@property (nonatomic, strong) UIFont *fontBold;
@property (nonatomic, strong) UIFont *fontItalic;
@property (nonatomic) CTTextAlignment ctTextAlignment;
@property (nonatomic, strong) UIColor *textColorBold;
@property (nonatomic) CGFloat lineHeight;
@property (nonatomic) int numberOfLines;
@property (nonatomic) BOOL shouldBoldAtNames;
@property (nonatomic) CGFloat kern;

@end
