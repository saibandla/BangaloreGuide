//
//  MapViewViewController.h
//  GoogleNearBy
//
//  Created by Sesha Sai Bhargav Bandla on 10/03/15.
//  Copyright (c) 2015 Adeptpros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLocaion.h"
@import MapKit;

@interface MapViewViewController : UIViewController<MKMapViewDelegate>
@property(nonatomic,strong)NSString *mapdata;
@property(nonatomic,assign)CLLocationCoordinate2D sourceCoords;
@property(nonatomic,assign)CLLocationCoordinate2D destCoords;
@property(nonatomic,strong)MyLocation *source;
@property(nonatomic,strong)MyLocation *dest;
@end
