//
//  UserLocation.h
//  NearbyUser
//
//  Created by HaBula on 14/11/23.
//  Copyright (c) 2014年 HaBula. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface UserLocation : NSObject

@property (nonatomic) CLLocationDegrees longitude;

@property (nonatomic) CLLocationDegrees latitude;

@property (nonatomic) CLLocationDistance distance;


@end
