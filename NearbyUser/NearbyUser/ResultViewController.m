//
//  ResultViewController.m
//  NearbyUser
//
//  Created by HaBula on 14/11/17.
//  Copyright (c) 2014年 HaBula. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *locations;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CLLocationDegrees d1= 10;
    CLLocationDegrees d2= 120;
    CLLocationDegrees d3= 230;
    CLLocationDegrees d4= -40;
    CLLocationDegrees d5= 50;
    CLLocationDegrees d6= 160;
    CLLocation *location1= [[CLLocation alloc] initWithLatitude:d1 longitude:d2];
    CLLocation *location2= [[CLLocation alloc] initWithLatitude:d3 longitude:d4];
    CLLocation *location3= [[CLLocation alloc] initWithLatitude:d5 longitude:d6];
    locations = [NSArray arrayWithObjects:location1,location2,location3,nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section{
    return  [locations count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultcell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"resultcell"];
    }
    CLLocation *loc = locations[indexPath.row];
    CLLocationDistance distance= [loc distanceFromLocation:_currentLocation];
//    cell.textLabel.text =[NSString stringWithFormat:@"%f,  %f",loc.coordinate.longitude,loc.coordinate.latitude];
    cell.textLabel.text = [NSString stringWithFormat:@"Distance: %f Km", distance/1000];
    return cell;
}

@end
