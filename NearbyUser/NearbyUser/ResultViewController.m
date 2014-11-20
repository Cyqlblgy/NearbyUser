//
//  ResultViewController.m
//  NearbyUser
//
//  Created by HaBula on 14/11/17.
//  Copyright (c) 2014年 HaBula. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *locations;
    NSMutableArray *users;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    users = [NSMutableArray arrayWithCapacity:10000];
    locations = [NSMutableArray arrayWithCapacity:10000];
    for(int i =0 ; i< 10000 ; i++){
        CLLocationDegrees longitude = random()%360 - 180;
        CLLocationDegrees latitude  = random()%180 - 90;
        CLLocation *location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
        [users addObject:location];
    }
    [self findNearbyUser];
    [_tableView reloadData];
    // Do any additional setup after loading the view.
}


- (void)findNearbyUser{
    for(CLLocation *loc in users){
      CLLocationDistance distance= [loc distanceFromLocation:_currentLocation];
        if(distance/100000 < 10){
            [locations addObject:loc];
        }
    }
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
    CLLocationDistance dis = [loc distanceFromLocation:_currentLocation];
    cell.textLabel.text = [NSString stringWithFormat:@"Long: %.0f,Lat: %.0f, Distance: %.0f Km", loc.coordinate.longitude, loc.coordinate.latitude,dis/1000];
    return cell;
}



@end
