//
//  MyLocaion.h
//  MapIntegration
//
//  Created by Sesha Sai Bhargav Bandla on 04/01/15.
//  Copyright (c) 2015 nivansys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyLocation : NSObject <MKAnnotation>

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;
- (MKMapItem*)mapItem;

@end