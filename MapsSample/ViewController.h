//
//  ViewController.h
//  MapsSample
//
//  Created by NS on 3/2/16.
//  Copyright © 2016 Sinhngn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@import GoogleMaps;

@interface ViewController : UIViewController <GMSAutocompleteViewControllerDelegate, UITextFieldDelegate, GMSMapViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtStart;
@property (weak, nonatomic) IBOutlet UITextField *txtEnd;

@property (weak, nonatomic) IBOutlet UIView *controlView;

@property (weak, nonatomic) IBOutlet UIButton *btnDirection;
@property (weak, nonatomic) IBOutlet UIButton *btnClear;

- (IBAction)btnTouchUpInside:(id)sender;
- (IBAction)txtTouchDown:(id)sender;

@end

