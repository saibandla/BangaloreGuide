//
//  AppDelegate.m
//  GoogleNearBy
//
//  Created by Geniusport on 1/2/15.
//  Copyright (c) 2015 Adeptpros. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "NearestAttractionsViewController.h"
#import "TabViewController.h"
@implementation AppDelegate
@synthesize locationManager=_locationManager;
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSDate* eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0)
    {
        if(newLocation.horizontalAccuracy<35.0){
            //Location seems pretty accurate, let's use it!
            NSLog(@"latitude %+.6f, longitude %+.6f\n",
                  newLocation.coordinate.latitude,
                  newLocation.coordinate.longitude);
            NSLog(@"Horizontal Accuracy:%f", newLocation.horizontalAccuracy);
            [ViewController setLatitude:[NSString stringWithFormat:@"%.6f",newLocation.coordinate.latitude] andLongitude:[NSString stringWithFormat:@"%.6f",newLocation.coordinate.longitude]];
            [[ViewController sharedInsta] getJsonData];
            //Optional: turn off location services once we've gotten a good location
        }
        //Location timestamp is within the last 15.0 seconds, let's use it!
    }
}
//- (void)locationManager:(CLLocationManager *)manager
//	 didUpdateLocations:(NSArray *)locations
//{
//    CLLocation *newLocation=[locations objectAtIndex:0];
//    NSDate* eventDate = newLocation.timestamp;
//    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
//    if (abs(howRecent) < 15.0)
//    {
//        if(newLocation.horizontalAccuracy<35.0){
//            //Location seems pretty accurate, let's use it!
//            NSLog(@"latitude %+.6f, longitude %+.6f\n",
//                  newLocation.coordinate.latitude,
//                  newLocation.coordinate.longitude);
//            NSLog(@"Horizontal Accuracy:%f", newLocation.horizontalAccuracy);
//            [ViewController setLatitude:[NSString stringWithFormat:@"%.6f",newLocation.coordinate.latitude] andLongitude:[NSString stringWithFormat:@"%.6f",newLocation.coordinate.longitude]];
//            [[ViewController sharedInsta] getJsonData];
//            //Optional: turn off location services once we've gotten a good location
////            [manager stopUpdatingLocation];
//        }
//        //Location timestamp is within the last 15.0 seconds, let's use it!
//    }
//}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    if(self.locationManager==nil){
        _locationManager=[[CLLocationManager alloc] init];
        //I'm using ARC with this project so no need to release
        
        _locationManager.delegate=self;
        _locationManager.purpose = @"We will try to tell you where you are if you get lost";
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        _locationManager.distanceFilter=500;
        self.locationManager=_locationManager;
    }
//    if([CLLocationManager locationServicesEnabled]){
//        [self.locationManager startUpdatingLocation];
//    }
    ViewController *obj=[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    UINavigationController *nav1=[[UINavigationController alloc]initWithRootViewController:obj];
    nav1.tabBarItem.image=[UIImage imageNamed:@"mode_transit_icon copy.png"];
    nav1.tabBarItem.title=@"BMTC";
    NearestAttractionsViewController *obbj2=[[NearestAttractionsViewController alloc]initWithNibName:@"NearestAttractionsViewController" bundle:nil];
    UINavigationController *nav2=[[UINavigationController alloc]initWithRootViewController:obbj2];
    [nav2.tabBarItem setImage:[UIImage imageNamed:@"ic_maps_indicator_startpoint_list copy.png"]];
    [nav2.tabBarItem setTitle:@"Nearest Attractions"];
    TabViewController *tabview=[[TabViewController alloc]initWithNibName:@"TabViewController" bundle:nil];
    tabview.viewControllers=@[nav1,nav2];
    
    [self.window setRootViewController:tabview];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
