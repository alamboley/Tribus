//
//  NMCustomLabel.m
//  NewsMe
//
//  Created by Robert Haining on 8/30/11.
//  Copyright 2011 News.me. All rights reserved.
//

#import "NMCustomLabel.h"

@interface NMCustomLabel(Private)
-(void)createAttributedString;
@end

static NSRegularExpression *twitterNameEndRegEx;

@implementation NMCustomLabel

@synthesize  cleanText, ctTextAlignment, textColorBold, lineHeight, numberOfLines, shouldBoldAtNames, kern;

+(void)initialize{
	if(!twitterNameEndRegEx){
		NSError *error = NULL;
		twitterNameEndRegEx = [NSRegularExpression regularExpressionWithPattern:@"[^0-9A-Za-z_]" options:NSRegularExpressionCaseInsensitive error:&error];
		if(!twitterNameEndRegEx){
			NSLog(@"error creating regex: %@", error);
		}
	}
}
-(void)setDefaults{
	if(!self.backgroundColor){
		self.backgroundColor = [UIColor whiteColor];
		
		[self setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
		[self setFontBold:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
		[self setFontItalic:[UIFont fontWithName:@"HelveticaNeue-LightItalic" size:12]];
		
		self.textColor = [UIColor blackColor];
		self.textColorBold = [UIColor blackColor];
		
	}	
}
-(UIColor *)backgroundColor{
	if(backgroundCGColor){
		return [UIColor colorWithCGColor:backgroundCGColor];
	}else{
		return nil;
	}
}
-(void)setBackgroundColor:(UIColor *)backgroundColor{
	if(backgroundCGColor){
		CGColorRelease(backgroundCGColor);
	}
	backgroundCGColor = CGColorRetain(backgroundColor.CGColor);
	if(CGColorGetAlpha(backgroundCGColor) < 0.1){
		[super setBackgroundColor:[UIColor clearColor]];
	}
	[self setNeedsDisplay];
}
-(id)initWithFrame:(CGRect)frame{
	if(self = [super initWithFrame:frame]){
		[self setDefaults];
	}
	return self;
}
- (id)init{
    if (self = [super init]) {
		[self setDefaults];
    }
    return self;
}
-(void)dealloc{
	if(attrString){
		CFRelease(attrString);
	}
	if(framesetter){
		CFRelease(framesetter);
	}
	if(bodyFont){
		CFRelease(bodyFont);
	}
	if(bodyFontItalic){
		CFRelease(bodyFontItalic);
	}
	if(bodyFontBold){
		CFRelease(bodyFontBold);
	}
	if(backgroundCGColor){
		CGColorRelease(backgroundCGColor);
	}
}
-(UIFont *)font{
	if(bodyFont){
		CFStringRef nameRef = CTFontCopyName(bodyFont, kCTFontFullNameKey);
		NSString *name = (__bridge NSString *)nameRef;
		UIFont *font = [UIFont fontWithName:name size:CTFontGetSize(bodyFont)];
		CFRelease(nameRef);
		return font;
	}else{
		return nil;
	}
}
#define MAX_LINE_HEIGHT_OFFSET 3
-(void)setFont:(UIFont *)font{
	if(bodyFont){
		CFRelease(bodyFont);
	}
	bodyFont = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
	
	if(maxLineHeight < font.lineHeight){
		maxLineHeight = font.lineHeight-MAX_LINE_HEIGHT_OFFSET;
	}
}
-(UIFont *)fontBold{
	if(bodyFontBold){
		CFStringRef nameRef = CTFontCopyName(bodyFontBold, kCTFontFullNameKey);
		NSString *name = (__bridge NSString *)nameRef;
		UIFont *font = [UIFont fontWithName:name size:CTFontGetSize(bodyFontBold)];
		CFRelease(nameRef);
		return font;
	}else{
		return nil;
	}
}
-(void)setFontBold:(UIFont *)fontBold{
	if(bodyFontBold){
		CFRelease(bodyFontBold);
	}
	bodyFontBold = CTFontCreateWithName((__bridge CFStringRef)fontBold.fontName, fontBold.pointSize, NULL);
	
	if(maxLineHeight < fontBold.lineHeight){
		maxLineHeight = fontBold.lineHeight-MAX_LINE_HEIGHT_OFFSET;
	}
}
-(UIFont *)fontItalic{
	if(bodyFontItalic){
		CFStringRef nameRef = CTFontCopyName(bodyFontItalic, kCTFontFullNameKey);
		NSString *name = (__bridge NSString *)nameRef;
		UIFont *font = [UIFont fontWithName:name size:CTFontGetSize(bodyFontItalic)];
		CFRelease(nameRef);
		return font;
	}else{
		return nil;
	}
}
-(void)setFontItalic:(UIFont *)fontItalic{
	if(bodyFontItalic){
		CFRelease(bodyFontItalic);
	}
	bodyFontItalic = CTFontCreateWithName((__bridge CFStringRef)fontItalic.fontName, fontItalic.pointSize, NULL);	
	
	if(maxLineHeight < fontItalic.lineHeight){
		maxLineHeight = fontItalic.lineHeight-MAX_LINE_HEIGHT_OFFSET;
	}
}
-(void)clearAttrString{
	if(attrString){
		CFRelease(attrString);
		attrString = nil;
	}
}
-(void)setText:(NSString *)_text{
	if([self.text isEqualToString:_text]){
		return;
	}
	
	[super setText:_text];
	
	if(self.text && self.text.length > 0){
		NSMutableString *_cleanText = [_text mutableCopy];
		[_cleanText replaceOccurrencesOfString:@"<b>" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, _cleanText.length)];
		[_cleanText replaceOccurrencesOfString:@"</b>" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, _cleanText.length)];
		[_cleanText replaceOccurrencesOfString:@"<i>" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, _cleanText.length)];
		[_cleanText replaceOccurrencesOfString:@"</i>" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, _cleanText.length)];
		if(self.shouldBoldAtNames){
			[_cleanText replaceOccurrencesOfString:@"@" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, _cleanText.length)];
		}
		cleanText = [_cleanText copy];

		[self clearAttrString];
	}else{
		if(cleanText){
			cleanText = nil;
		}
		if(attrString){
			CFRelease(attrString);
			attrString = nil;
		}
		if(framesetter){
			CFRelease(framesetter);
			framesetter = nil;
		}
	}
	[self setNeedsDisplay];
}
-(void)setTextColor:(UIColor *)_textColor{
	if([self.textColor isEqual:_textColor]){
		return;
	}
	[super setTextColor:_textColor];
	if(attrString){
		[self clearAttrString];
		[self setNeedsDisplay];
	}
}
-(void)setTextColorBold:(UIColor *)_textColorBold{
	if([textColorBold isEqual:_textColorBold]){
		return;
	}
	textColorBold = _textColorBold;
	if(attrString){
		[self clearAttrString];
		[self setNeedsDisplay];
	}
}

-(void)createAttributedString{
	if(!self.text || self.text.length == 0){ 
		//no text. return.
		return; 
	}
//	NSLog(@"customlabel - create - %@", text);
	
	[self clearAttrString];
	attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
	
	CFAttributedStringReplaceString (attrString, CFRangeMake(0, 0), (__bridge CFStringRef)cleanText);
	
	//set default color
	CFAttributedStringSetAttribute(attrString, CFRangeMake(0, CFAttributedStringGetLength(attrString)), kCTForegroundColorAttributeName, [self.textColor CGColor]);
	
	//set default font
	CFAttributedStringSetAttribute(attrString, CFRangeMake(0, CFAttributedStringGetLength(attrString)), kCTFontAttributeName, bodyFont);
	
	int locOfTag = -1;
	int totalTagLength = 0;
	int eachTagLength = 7;
	
	NSRange range0 = NSMakeRange(0, 0);
	while(range0.location != NSNotFound){
		NSRange range1 = [self.text rangeOfString:@"<b>" options:NSLiteralSearch range:NSMakeRange(range0.location+range0.length, self.text.length - range0.location- range0.length)];
		if(range1.location != NSNotFound){
			NSRange range2 = [self.text rangeOfString:@"</b>" options:NSLiteralSearch range:NSMakeRange(range1.location+range1.length, self.text.length - range1.location- range1.length)];
			if(range2.location != NSNotFound){
				CFRange boldRange = CFRangeMake(range1.location, range2.location-range1.location-3);
				if(locOfTag >= 0 && locOfTag < boldRange.location){
					boldRange.location -= totalTagLength;
				}
				locOfTag = boldRange.location + boldRange.length;
				totalTagLength += eachTagLength;

				NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)bodyFontBold, kCTFontAttributeName, [textColorBold CGColor], kCTForegroundColorAttributeName, nil];
				CFAttributedStringSetAttributes(attrString, boldRange, (__bridge CFDictionaryRef)attributes, NO);
				range0 = range2;
			}else{
				break;
			}
		}else{
			break;
		}
	}
	if(bodyFontItalic){
		range0 = NSMakeRange(0, 0);
		//	locOfTag = -1;
		while(range0.location != NSNotFound){
			NSRange range1 = [self.text rangeOfString:@"<i>" options:NSLiteralSearch range:NSMakeRange(range0.location+range0.length, self.text.length - range0.location- range0.length)];
			if(range1.location != NSNotFound){
				NSRange range2 = [self.text rangeOfString:@"</i>" options:NSLiteralSearch range:NSMakeRange(range1.location+range1.length, self.text.length - range1.location- range1.length)];
				if(range2.location != NSNotFound){
					CFRange italRange = CFRangeMake(range1.location, range2.location-range1.location-3);
					if(locOfTag >= 0 && locOfTag < italRange.location){
						italRange.location -= totalTagLength;
					}
					locOfTag = italRange.location + italRange.length;
					totalTagLength += eachTagLength;
					//				NSLog(@"i %@ boldRange = %d,%d - length = %d", self.text, (int)italRange.location, (int)italRange.length, self.cleanText.length);
					
					CFAttributedStringSetAttribute(attrString, italRange, kCTFontAttributeName, bodyFontItalic);
					range0 = range2;
				}else{
					break;
				}
			}else{
				break;
			}
		}
	}

	if(self.shouldBoldAtNames){
		NSRange range0 = NSMakeRange(0, 0);
		while(range0.location != NSNotFound){
			NSRange range1 = [self.text rangeOfString:@"@" options:NSLiteralSearch range:NSMakeRange(range0.location+range0.length, self.text.length - range0.location- range0.length)];
			if(range1.location != NSNotFound){
				NSRange range2 = [twitterNameEndRegEx rangeOfFirstMatchInString:self.text options:0 range:NSMakeRange(range1.location+range1.length, self.text.length - range1.location- range1.length)];
				if(range2.location != NSNotFound){
					CFRange boldRange = CFRangeMake(range1.location, range2.location-range1.location-1);
					if(locOfTag >= 0 && locOfTag < boldRange.location){
						boldRange.location -= totalTagLength;
					}
					locOfTag = boldRange.location + boldRange.length;
					totalTagLength += 1;
//					NSLog(@"@ %@ boldRange = %d,%d - length = %d", self.text, (int)boldRange.location, (int)boldRange.length, self.cleanText.length);

					NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)bodyFontBold, kCTFontAttributeName, [textColorBold CGColor], kCTForegroundColorAttributeName, nil];
					CFAttributedStringSetAttributes(attrString, boldRange, (__bridge CFDictionaryRef)attributes, NO);

					range0 = range2;
				}else{
					break;
				}
			}else{
				break;
			}
		}
	}
	
	//create paragraph style and assign text alignment to it
	int numParagraphSpecifiers = 3;
	maxLineHeight = lineHeight;
	CGFloat minLineHeight = lineHeight;
	CTParagraphStyleSetting _settings[] = { 
		{kCTParagraphStyleSpecifierAlignment, sizeof(ctTextAlignment), &ctTextAlignment},
		{kCTParagraphStyleSpecifierMaximumLineHeight, sizeof(CGFloat), &maxLineHeight},
		{kCTParagraphStyleSpecifierMinimumLineHeight, sizeof(CGFloat), &minLineHeight},
		{kCTParagraphStyleSpecifierCount, sizeof(int), &numParagraphSpecifiers}
	};
	CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(_settings, sizeof(_settings) / sizeof(_settings[0]));
	CFAttributedStringSetAttribute(attrString, CFRangeMake(0, CFAttributedStringGetLength(attrString)), kCTParagraphStyleAttributeName, paragraphStyle);
	
	CFNumberRef kernValue = (__bridge  CFNumberRef) [NSNumber numberWithFloat:kern];
	CFAttributedStringSetAttribute(attrString, CFRangeMake(0, CFAttributedStringGetLength(attrString)), kCTKernAttributeName, kernValue);
	
	if(framesetter){
		CFRelease(framesetter);
	}
	framesetter = CTFramesetterCreateWithAttributedString(attrString);
	
	CFRelease(paragraphStyle);
}


- (CGSize)sizeThatFits:(CGSize)size{
	if(!self.text || self.text.length == 0){
		return CGSizeZero;
	}
	CGSize suggestedSize = CGSizeZero;
	if(!attrString){
		[self createAttributedString];
	}
	if(framesetter){
		if(size.width < 1){ size.width = 10000; }
		if(size.height < 1){ size.height = 10000; }
		suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(
																	 framesetter, /* Framesetter */
																	 CFRangeMake(0, CFAttributedStringGetLength(attrString)), /* String range (entire string) */
																	 NULL, /* Frame attributes */
																	 size, /* Constraints (CGFLOAT_MAX indicates unconstrained) */
																	 NULL /* Gives the range of string that fits into the constraints, doesn't matter in your situation */
																	 );
		//on iOS 4, we were getting heights of 14.9 where the line height was 15, so it was getting cut off.  after we stop supporting iOS 4, we could safely kill these lines.
		suggestedSize.width = round(suggestedSize.width);
		suggestedSize.height = round(suggestedSize.height);
	}else{
		suggestedSize = size;
	}
	return suggestedSize;
}
-(void)setFrame:(CGRect)frame{
	if(!CGRectEqualToRect(self.frame, frame)){
		[super setFrame:frame];
		[self setNeedsDisplay];
	}
}
- (void)drawTextInRect:(CGRect)rect{
//	NSLog(@"drawRect: %@ - %@", NSStringFromCGRect(rect), text);
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClearRect(context, rect);
	if(backgroundCGColor){
		CGContextSetFillColorWithColor(context, backgroundCGColor);
		CGContextFillRect(context, rect);
	}

	if(!self.text || self.text.length == 0){
		return;
	}
	CGSize fullSize = [self sizeThatFits:CGSizeMake(rect.size.width, 1000.0)];
	
//	NSLog(@"taco - %f > %d", fullSize.height /  self.lineHeight, self.numberOfLines);
	if(self.numberOfLines && self.lineHeight && fullSize.height / self.lineHeight > self.numberOfLines){
		shouldTruncate = YES;
	}	

	if(!attrString){
		[self createAttributedString];
	}
	if(YES && numberOfLines > 0 && shouldTruncate){
		// don't set any line break modes, etc, just let the frame draw as many full lines as will fit 
		CGRect frameRect = rect;
		CGMutablePathRef framePath = CGPathCreateMutable(); 
		
		CGContextSetTextMatrix(context, CGAffineTransformIdentity);
		CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
		CGContextScaleCTM(context, 1.0, -1.0);
		
		CGAffineTransform reverseT = CGAffineTransformIdentity;
		reverseT = CGAffineTransformScale(reverseT, 1.0, -1.0);
		reverseT = CGAffineTransformTranslate(reverseT, 0.0, -self.bounds.size.height);
		
		CGPathAddRect(framePath, NULL, CGRectApplyAffineTransform(frameRect, reverseT));

		
		CTFrameRef aFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, CFAttributedStringGetLength(attrString)), framePath, NULL); 
		CFArrayRef lines = CTFrameGetLines(aFrame); 
		CFIndex count = CFArrayGetCount(lines);
		if(count == 0){
			CGPathRelease(framePath);
			CFRelease(aFrame);
			return;
		}
		CGPoint origins[count];//the origins of each line at the baseline
		CFRange range = CFRangeMake(0, count);
		CTFrameGetLineOrigins(aFrame, range, origins); 
		// note that we only enumerate to count-1 in here-- we draw the last line separately 
		for (CFIndex i = 0; i < count-1; i++) 
		{ 
			// draw each line in the correct position as-is 
			CGContextSetTextPosition(context, origins[i].x, origins[i].y); 
			CTLineRef line = (CTLineRef)CFArrayGetValueAtIndex(lines, i); 
			CTLineDraw(line, context); 
		} 
		
		// truncate the last line before drawing it 
		CGPoint lastOrigin = origins[count-1]; 
		CTLineRef lastLine = CFArrayGetValueAtIndex(lines, count-1); 
		// truncation token is a CTLineRef itself 
		CFDictionaryRef stringAttrs = nil;
		CFAttributedStringRef truncationString = CFAttributedStringCreate(NULL, CFSTR("\u2026"), stringAttrs); 
		CTLineRef truncationToken = CTLineCreateWithAttributedString(truncationString); 
		CFRelease(truncationString); 
		// now create the truncated line -- need to grab extra characters from the source string, 
		// or else the system will see the line as already fitting within the given width and 
		// will not truncate it. 
		// range to cover everything from the start of lastLine to the end of the string 
		CFRange rng = CFRangeMake(CTLineGetStringRange(lastLine).location, 0); 
		rng.length = CFAttributedStringGetLength(attrString) - rng.location; 
		// substring with that range 
		CFAttributedStringRef longString = CFAttributedStringCreateWithSubstring(NULL, attrString, rng); 
		// line for that string 
		CTLineRef longLine = CTLineCreateWithAttributedString(longString); 
		CFRelease(longString); 
		CTLineRef truncated = CTLineCreateTruncatedLine(longLine, frameRect.size.width, kCTLineTruncationEnd, truncationToken); 
		CFRelease(longLine); 
		CFRelease(truncationToken); 
		// if 'truncated' is NULL, then no truncation was required to fit it 
		if (truncated == NULL) 
			truncated = (CTLineRef)CFRetain(lastLine); 
		// draw it at the same offset as the non-truncated version 
		CGContextSetTextPosition(context, lastOrigin.x, lastOrigin.y); 
		CTLineDraw(truncated, context); 
		CFRelease(truncated);
		CGPathRelease(framePath);
		CFRelease(aFrame);

	}else{
		
		CGRect topRect = self.frame;
		topRect.origin = CGPointZero;
		
		CGContextSetTextMatrix(context, CGAffineTransformIdentity);
		CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
		CGContextScaleCTM(context, 1.0, -1.0);
		
		CGAffineTransform reverseT = CGAffineTransformIdentity;
		reverseT = CGAffineTransformScale(reverseT, 1.0, -1.0);
		reverseT = CGAffineTransformTranslate(reverseT, 0.0, -self.bounds.size.height);
		
		
		CGMutablePathRef topFramePath = CGPathCreateMutable();
		CGPathAddRect(topFramePath, NULL, CGRectApplyAffineTransform(topRect, reverseT));
		
		CTFrameRef topFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0,0), topFramePath, NULL);  
		CFRelease(topFramePath);
		CTFrameDraw(topFrame, context);
		CFRelease(topFrame);
		
		CGAffineTransform ctm = CGContextGetCTM(context);
		CGContextConcatCTM(context, CGAffineTransformInvert(ctm));

	}	
}


@end
