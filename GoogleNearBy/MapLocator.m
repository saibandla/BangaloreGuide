//
//  MapLocator.m
//  GoogleNearBy
//
//  Created by Sesha Sai Bhargav Bandla on 04/01/15.
//  Copyright (c) 2015 Adeptpros. All rights reserved.
//

#import "MapLocator.h"
#import "MyLocaion.h"
@interface MapLocator ()

@end

@implementation MapLocator
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil LocationName:(NSString *)Locname LocationAddress:(NSString *)addr Coordinates:(CLLocationCoordinate2D )coords
{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self!=nil)
    {
        name=Locname;
        address=addr;
        [self.navigationItem setTitle :@"Map View"];
        coordinates=coords;
    }
    return  self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mapView setDelegate:self];
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = coordinates.latitude;
    region.center.longitude = coordinates.longitude;
    region.span.longitudeDelta = 0.005f;
    region.span.longitudeDelta = 0.005f;
   
    MyLocation *annotation = [[MyLocation alloc] initWithName:name address:address coordinate:coordinates] ;
    [self.mapView setRegion:region animated:YES];
    [_mapView addAnnotation:annotation];

    // Do any additional setup after loading the view from its nib.
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

@end
