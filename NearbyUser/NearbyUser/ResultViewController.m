//
//  ResultViewController.m
//  NearbyUser
//
//  Created by HaBula on 14/11/17.
//  Copyright (c) 2014年 HaBula. All rights reserved.
//

#import "ResultViewController.h"
#import "SVProgressHUD.h"
#import "UserLocation.h"

@interface ResultViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
    NSMutableArray *locations;
    NSMutableArray *users;
    NSMutableArray *currentusers;
    NSInteger maxPages;
    NSInteger currentPage;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    currentPage = 0;
    users = [NSMutableArray arrayWithCapacity:10000];
    locations = [NSMutableArray arrayWithCapacity:10000];
    currentusers = [NSMutableArray arrayWithCapacity:100000];
    for(int i =0 ; i< 10000 ; i++){
        CLLocationDegrees longitude = random()%360 - 180;
        CLLocationDegrees latitude  = random()%180 - 90;
        CLLocation *location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
        [locations addObject:location];
    }
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self findNearbyUser];
    if([users count] == 0){
        [self showError];
    }else{
        [self getMoreData];
    }
}

- (void)findNearbyUser{
    for(CLLocation *loc in locations){
      CLLocationDistance distance= [loc distanceFromLocation:_currentLocation];
        
        if(distance/1000 < 1000){
            UserLocation *user = [[UserLocation alloc] init];
            user.longitude = loc.coordinate.longitude;
            user.latitude = loc.coordinate.latitude;
            user.distance = distance/1000;
            [users addObject:user];
        }
    }
    [self sortUsers];
    maxPages = [users count]/50;
}

- (void)sortUsers{
       [users sortUsingComparator:^NSComparisonResult(id a, id b){
        CLLocationDistance disOne = [(UserLocation *)a distance];
        CLLocationDistance disTwo = [(UserLocation *)b distance];
           if(disOne <= disTwo){
               return NSOrderedAscending;
           }
           else{
               return NSOrderedDescending;
           }
    }];
}

- (void)getMoreData{
    [SVProgressHUD showProgress:2 status:@"Loading..." maskType:SVProgressHUDMaskTypeBlack];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self
                                   selector:@selector(myDismiss) userInfo:nil repeats:NO];
    if(currentPage < maxPages){
        for(NSInteger i= currentPage*50;i <(currentPage+1)*50; i++){
            [currentusers addObject:users[i]];
        }
    }
    else{
        NSInteger usercount = [users count];
        for(NSInteger i = currentPage*50; i <usercount; i++){
            [currentusers addObject:users[i]];
        }
    }
    currentPage++;
    [_tableView reloadData];
}

- (void)myDismiss{
   [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showError{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No More!" message:@"There is no more users nearby." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *button = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    [alert addAction:button];
    [self presentViewController:alert animated:NO completion:nil];

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
    return  [currentusers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"resultcell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"resultcell"];
    }
    UserLocation *loc = currentusers[indexPath.row];
    CLLocationDistance dis = loc.distance;
    cell.textLabel.text = [NSString stringWithFormat:@"Long: %.0f,Lat: %.0f, Distance: %.0f Km", loc.longitude, loc.latitude,dis];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.frame.size.height -44){
        if(currentPage <= maxPages){
            [self getMoreData];
        }
        else{
            [self showError];
        }
    }
}


@end
