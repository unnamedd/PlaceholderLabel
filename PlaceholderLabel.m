//
//  PlaceholderLabel.m
//  CustomElements
//
//  Created by Thiago Holanda on 11/8/15.
//  Copyright © 2015 holanda.mobi. All rights reserved.
//

#import "PlaceholderLabel.h"
#import "NSDictionary+Custom.h"

NSString * const placeHolderFirst   = @"{firstValue}";
NSString * const placeHolderSecond  = @"{secondValue}";
NSString * const placeHolderThird   = @"{thirdValue}";

@interface PlaceholderLabel() {
    dispatch_once_t onceTokenViewLiveRendering;
}

@property (strong, nonatomic) NSMutableAttributedString *attributedStrings;

@end

@implementation PlaceholderLabel

-(void) prepareForInterfaceBuilder {
    [self viewLiveRendering];
}

- (void) drawRect:(CGRect) rect {
    [super drawRect: rect];
    
#ifndef TARGET_INTERFACE_BUILDER
    [self viewLiveRendering];
#endif
}

- (void) viewLiveRendering {
    dispatch_once(&onceTokenViewLiveRendering, ^{
        NSMutableArray *items = [NSMutableArray new];
        
        if (self.firstValue && ![self.firstValue isEqualToString:@""]) {
            [items addObject:@{
                               @"value"         : self.firstValue,
                               @"placeholder"   : placeHolderFirst,
                               @"color"         : self.firstColor ? self.firstColor : self.textColor,
                               @"bold"          : @(self.firstBold),
                               @"height"        : @(self.firstHeight),
                               @"customFont"    : self.firstFont ? self.firstFont : @""
                               }];
        }
        
        if (self.secondValue && ![self.secondValue isEqualToString:@""]) {
            [items addObject: @{
                                @"value"        : self.secondValue,
                                @"placeholder"  : placeHolderSecond,
                                @"color"        : self.secondColor ? self.firstColor : self.textColor,
                                @"bold"         : @(self.secondBold),
                                @"height"       : @(self.secondHeight),
                                @"customFont"   : self.secondFont ? self.secondFont : @""
                                }];
        }
        
        if (self.thirdValue && ![self.thirdValue isEqualToString:@""]) {
            [items addObject: @{
                                @"value"        : self.thirdValue,
                                @"placeholder"  : placeHolderThird,
                                @"color"        : self.thirdColor   ? self.thirdColor : self.textColor,
                                @"bold"         : @(self.thirdBold),
                                @"height"       : @(self.thirdHeight),
                                @"customFont"   : self.thirdFont ? self.thirdFont : @""
                                }];
        }
        
        
        // replace all placeholders to values
        [items enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![[obj objectForKey:@"value"] isEqualToString:@""])
                self.text = [self.text stringByReplacingOccurrencesOfString: [obj valueForKey: @"placeholder"]
                                                                 withString: [obj valueForKey: @"value"]];
        }];
        
        // apply the custom settings to each placeholder
        self.attributedStrings = [[NSMutableAttributedString alloc] initWithString: self.text];
        
        [items enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![[obj valueForKey:@"value"] isEqualToString:@""]) {
                
                NSRange valueRange = [self.text rangeOfString: [obj valueForKey: @"value"]];
                if (valueRange.location != NSNotFound) {
                    
                    NSNumber *height = [obj numberForKey:@"height"];
                    
                    if (![[obj valueForKey: @"customFont"] isEqualToString:@""]) {
                        // the best way to do this kind of change is using the
                        // UIFontDescriptor, but until now, we are getting touch some issues
                        // to change attributes on UIFont. Now, we are use the customFont
                        // as property, but we need to change to UIFontDescriptor as soon
                        // as we can.
                        
                        CGFloat pointSize = self.font.pointSize;
                        if (height)
                            pointSize = [height floatValue];
                        
                        UIFont *customFont = [UIFont fontWithName: [obj valueForKey: @"customFont"]
                                                             size: [height floatValue]];
                        
                        [self.attributedStrings addAttribute: NSFontAttributeName
                                                       value: customFont
                                                       range: valueRange];
                    }
                    else if ([[obj valueForKey: @"bold"] boolValue]) {
                        
                        CGFloat pointSize = self.font.pointSize;
                        if (height)
                            pointSize = [height floatValue];
                        
                        UIFontDescriptor *boldDescriptor = [[self.font fontDescriptor] fontDescriptorWithSymbolicTraits: UIFontDescriptorTraitBold];
                        UIFont *boldVersion = [UIFont fontWithDescriptor: boldDescriptor
                                                                    size: pointSize];
                        
                        [self.attributedStrings addAttribute: NSFontAttributeName
                                                       value: boldVersion
                                                       range: valueRange];
                    }
                    else if (height) {
                        UIFont *font = [UIFont fontWithName: self.font.fontName
                                                       size: [height floatValue]];
                        
                        [self.attributedStrings addAttribute: NSFontAttributeName
                                                       value: font
                                                       range: valueRange];
                    }
                    
                    if ([obj valueForKey: @"color"])
                        [self.attributedStrings addAttribute: NSForegroundColorAttributeName
                                                       value: [obj valueForKey: @"color"]
                                                       range: valueRange];
                    
                }
            }
        }];
        
        if (self.attributedStrings && [self.attributedStrings length] > 0)
            self.attributedText = self.attributedStrings;
    });
}

- (void) forceRender {
    onceTokenViewLiveRendering = 0;
    [self viewLiveRendering];
}

@end
