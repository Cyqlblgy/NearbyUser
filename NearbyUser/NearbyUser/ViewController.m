//
//  ViewController.m
//  NearbyUser
//
//  Created by HaBula on 14/11/17.
//  Copyright (c) 2014年 HaBula. All rights reserved.
//

#import "ViewController.h"
#import "ResultViewController.h"

@interface ViewController ()<UITextFieldDelegate>{
    NSArray *defaultUser;
    NSString *longitude;
    NSString *latitude;
    NSArray *calculateResult;
}
@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UITextField *longitudeTextfield;
@property (weak, nonatomic) IBOutlet UITextField *latitudeTextfield;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    defaultUser = [NSArray arrayWithObjects:@"21.90",@"22.90",nil];
    _longitudeTextfield.tag = 0;
    _latitudeTextfield.tag = 1;
//    [self.submitButton addTarget:self action:@selector(Docalculate:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSString *defaultLon = defaultUser[0];
    NSString *defaultLat = defaultUser[1];
    if([latitude isEqualToString:defaultLat] && [longitude isEqualToString:defaultLon]){
        calculateResult = defaultUser;
    }
    if([[segue identifier] isEqualToString:@"resultIdentifier"]){
        ResultViewController *resultVC= segue.destinationViewController;
        resultVC.result = calculateResult;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField.tag == 0){
        longitude = [textField text];
    }
    else{
        latitude = [textField text];
    }
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self.view endEditing:YES];
    return NO;
}

@end
