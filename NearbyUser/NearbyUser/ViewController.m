//
//  ViewController.m
//  NearbyUser
//
//  Created by HaBula on 14/11/17.
//  Copyright (c) 2014年 HaBula. All rights reserved.
//

#import "ViewController.h"
#import "ResultViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<UITextFieldDelegate,CLLocationManagerDelegate>{
    NSArray *calculateResult;
}
@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UITextField *longitudeTextfield;
@property (weak, nonatomic) IBOutlet UITextField *latitudeTextfield;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *getLocationButton;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.Delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    if([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [_locationManager requestWhenInUseAuthorization];
    }
    [_locationManager startUpdatingLocation];

    [self.getLocationButton addTarget:self action:@selector(Docalculate:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)Docalculate:(id)sender{
    _longitudeTextfield.text = [NSString stringWithFormat:@"%f",_locationManager.location.coordinate.longitude];
    _latitudeTextfield.text = [NSString stringWithFormat:@"%f",_locationManager.location.coordinate.latitude];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"resultIdentifier"]){
        ResultViewController *resultVC= segue.destinationViewController;
        resultVC.currentLocation = _locationManager.location;
    }
}



#pragma TextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self.view endEditing:YES];
    return NO;
}

#pragma LocationManager
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Updated Failed");
    [_locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    NSLog(@"Updated Location");
    [_locationManager stopUpdatingLocation];
}

@end
