//
//  MapLocator.h
//  GoogleNearBy
//
//  Created by Sesha Sai Bhargav Bandla on 04/01/15.
//  Copyright (c) 2015 Adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface MapLocator : UIViewController<MKMapViewDelegate>
{
    NSString *name;
    NSString *address;
    CLLocationCoordinate2D coordinates;
}
@property(nonatomic, retain) IBOutlet MKMapView *mapView;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil LocationName:(NSString *)name LocationAddress:(NSString *)address Coordinates:(CLLocationCoordinate2D )coords;
@end
