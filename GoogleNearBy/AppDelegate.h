//
//  AppDelegate.h
//  GoogleNearBy
//
//  Created by Geniusport on 1/2/15.
//  Copyright (c) 2015 Adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)CLLocationManager *locationManager;
@end
