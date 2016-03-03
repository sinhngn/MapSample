//
//  ViewController.m
//  MapsSample
//
//  Created by NS on 3/2/16.
//  Copyright © 2016 Sinhngn. All rights reserved.
//

#import "ViewController.h"
#import "ShareData.h"
#define STRING(karg,...)  [NSString stringWithFormat:(karg),##__VA_ARGS__]

@interface ViewController () {
    
    GMSPlacesClient *_placesClient;
    GMSMapView *mapView_;
    
    UITextField *selectedTextField;
    NSMutableArray *arrayMaker;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set up layout
    [self setupLayout];
    
    //load map to View
    [self loadMaps];
    
    // new a GMS Place Client
    _placesClient = [[GMSPlacesClient alloc] init];
    
}

- (void)setupLayout{
    self.btnClear.layer.cornerRadius = 10.;
    self.btnDirection.layer.cornerRadius = 10.;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button event
- (IBAction)btnTouchUpInside:(id)sender {
    
    if(sender == self.btnClear){
        arrayMaker = nil;
        [mapView_ clear];
        self.txtEnd.text = @"";
        self.txtStart.text = @"";
        
        return;
    }
    
    if(sender == self.btnDirection){
        //get Root from api
        /*[[ShareData instance].directionsProxy getDirection:@"1 lu gia HO chi minh" destination:@"10 lu gia ho chi minh" key:GOOGLE_API_KEY completed:^(id result, NSString *errorCode, NSString *message) {
            //todo ...
        } error:^(id result, NSString *errorCode, NSString *message) {
            // error to do
        }];*/
        
        NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        if([[self.txtStart.text  stringByTrimmingCharactersInSet:whitespace] isEqualToString:@""]){
            selectedTextField = self.txtStart;
            [self showAutocompleteView];
            return;
        }
        
        if([[self.txtEnd.text  stringByTrimmingCharactersInSet:whitespace] isEqualToString:@""]){
            selectedTextField = self.txtEnd;
            [self showAutocompleteView];
            return;
        }
        
        GMSMutablePath * path = [GMSMutablePath path];
        
        for(GMSMarker *mk in arrayMaker){
            [path addCoordinate:mk.position];
        }
        
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        polyline.map = mapView_;
        
        return;
    }
}

- (IBAction)txtTouchDown:(id)sender {
    //Autocomplete
    if(sender ==  self.txtEnd || sender == self.txtStart){
        
        selectedTextField = sender;
        
        [self showAutocompleteView];
    }
}

- (void)showAutocompleteView {
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    
    [self presentViewController:acController animated:YES completion:nil];
}

#pragma mark - GOOGLE MAPS FUNCTION

- (void)loadMaps{
    
    CGSize _size = [self screenSizeBound];
    
    //Ho Chi Minh 10.7704985,106.6533653,
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:10.7704985
                                                            longitude:106.6533653
                                                                 zoom:16];
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.delegate = self;
    mapView_.myLocationEnabled = YES;
    
    //assign map (showing)
    self.view = mapView_;
    
    // Show control to map.
    self.controlView.frame = CGRectMake(0, 0, _size.width, 140);
    self.controlView.translatesAutoresizingMaskIntoConstraints = YES;
    self.controlView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.4];
    [self.navigationController.view addSubview:self.controlView];
    
}

#pragma mark - Delegate for GMSAutocompleteViewController

// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController didAutocompleteWithPlace:(GMSPlace *)place {
    
    // dismiss view controller
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSString *displayAdress = place.formattedAddress;
    
    if([place.formattedAddress componentsSeparatedByString:@","].count == 1){
        displayAdress = STRING(@"%@ %@", place.name, place.formattedAddress);
    }
    
    //set adrress to textfield
    selectedTextField.text = displayAdress;
    
    //add Maker
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = place.coordinate;
    marker.title =  place.name;
    marker.snippet = place.formattedAddress;
    marker.draggable = YES;
    marker.userData = (selectedTextField == self.txtStart)? self.txtStart : self.txtEnd;
    
    marker.map = mapView_;
    
    if(!arrayMaker){
        arrayMaker = [NSMutableArray array];
    }
    
    [arrayMaker addObject:marker];
    
    // auto zoom when two Maker
    if(arrayMaker.count == 2){
        
        CLLocationCoordinate2D lc1 = ((GMSMarker*)[arrayMaker objectAtIndex:0]).position;
        CLLocationCoordinate2D lc2 = ((GMSMarker*)[arrayMaker objectAtIndex:1]).position;
        
        CLLocationCoordinate2D myLocation = ((GMSMarker *)arrayMaker.firstObject).position;
        GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:myLocation coordinate:myLocation];
        
        for (GMSMarker *marker in arrayMaker)
            bounds = [bounds includingCoordinate:marker.position];
        
        [mapView_ animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:15.0f]];

        
        return;
    }
    
    
    //move to Maker
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:place.coordinate.latitude
                                                            longitude:place.coordinate.longitude
                                                                 zoom:16];
    [mapView_ setCamera:camera];
    
}

- (void)viewController:(GMSAutocompleteViewController *)viewController didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Error: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark - Delegate for MapView

- (void)mapView:(GMSMapView *)mapView didEndDraggingMarker:(GMSMarker *)marker {
    
    CLLocationCoordinate2D addressCoordinates = marker.position;
    
    GMSGeocoder* coder = [[GMSGeocoder alloc] init];
    [coder reverseGeocodeCoordinate:addressCoordinates completionHandler:^(GMSReverseGeocodeResponse *results, NSError *error) {
        
        if (error) {
            NSLog(@"Error %@", error.description);
        } else {
            
            GMSAddress* address = [results firstResult];
            
            marker.title =  address.thoroughfare;
            marker.snippet = address.locality;
            
            if(marker.userData == self.txtEnd){
                self.txtEnd.text = STRING(@"%@ %@ %@",address.thoroughfare,address.subLocality,address.country);
            } else {
                self.txtStart.text = STRING(@"%@ %@ %@",address.thoroughfare,address.subLocality,address.country);
            }
            
            GMSMutablePath * path = [GMSMutablePath path];
            
            for(GMSMarker *mk in arrayMaker){
                [path addCoordinate:mk.position];
            }
            
            GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
            polyline.strokeColor = [self randomColor];
            polyline.map = mapView_;
        }
    }];
}

#pragma mark - function
- (CGSize)screenSizeBound {
    CGSize screenSize1 = [UIScreen mainScreen].bounds.size;
    
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return CGSizeMake(screenSize1.height, screenSize1.width);
    } else {
        return screenSize1;
    }
}

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
