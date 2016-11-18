//
//  PlaceholderLabel.h
//  CustomElements
//
//  Created by Thiago Holanda on 11/8/15.
//  Copyright © 2015 holanda.mobi. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface PlaceholderLabel : UILabel

/**
 @class PlaceholderLabel
 
 To use this modified label, is really simple. You just need to do the steps below.
 
 1 - In your storyboard or xib, create a new UILabel
 2 - with your new label selected, show the Identity Inspector tab, pressing Option + Command + 3
 3 - On Class Field, type: PlaceholderLabel.h
 4 - Change to Attribute Inspector tab, pressing Option + Command + 4
 5 - Now, you can see new properties available to use.
 
 How can you see, now you have three new groups of properties to use. The main goal of this designable
 is to allow the user to change the main text configured into the Label without any NSAttributedString 
 by yourself.
 
 The placeholders are:
 - {firstValue}
 - {secondValue}
 - {thirdValue}
 
 Example:
 
 Configure to your label this text: 
 "Hello {firstValue}, welcome to our new {secondValue}. <> with love by {thirdValue}"
 
 Into your properties:
 First Value = "Mr. President"
 Second Value = "CTU"
 Third Value = "Jack Bauer"
 
 And finally you will see this result:
 "Hello Mr.President, welcome to our new CTU. <> with love by Jack Bauer"
 
 When you create a property for this element and configure the values in storyboard,
 it will try to render the properties with values that it have. If you need to reload
 the data, do not call the method `viewLiveRendering`, it will doesn't work. 
 Use the `forceRender`.
 
 
*/


@property (strong, nonatomic)                           IBInspectable NSString  *firstValue;
@property (strong, nonatomic)                           IBInspectable UIColor   *firstColor;
@property (readwrite, nonatomic, getter=isFirstBold)    IBInspectable BOOL      firstBold;
@property (readwrite, nonatomic)                        IBInspectable CGFloat   firstHeight;
@property (strong, nonatomic)                           IBInspectable NSString  *firstFont;

@property (strong, nonatomic)                           IBInspectable NSString  *secondValue;
@property (strong, nonatomic)                           IBInspectable UIColor   *secondColor;
@property (readwrite, nonatomic, getter=isSecondBold)   IBInspectable BOOL      secondBold;
@property (readwrite, nonatomic)                        IBInspectable CGFloat   secondHeight;
@property (strong, nonatomic)                           IBInspectable NSString  *secondFont;

@property (strong, nonatomic)                           IBInspectable NSString  *thirdValue;
@property (strong, nonatomic)                           IBInspectable UIColor   *thirdColor;
@property (readwrite, nonatomic, getter=isThirdBold)    IBInspectable BOOL      thirdBold;
@property (readwrite, nonatomic)                        IBInspectable CGFloat   thirdHeight;
@property (strong, nonatomic)                           IBInspectable NSString  *thirdFont;

/*!
 this method render the designable is better used in your code to render after values be configured
*/
- (void) viewLiveRendering;

/*! 
 use this method to force the reload data into element, once you have passed by 'viewLiveRendering', only this method will does render as you will need.
 */
- (void) forceRender;

@end
