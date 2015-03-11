//
//  MapViewViewController.m
//  GoogleNearBy
//
//  Created by Sesha Sai Bhargav Bandla on 10/03/15.
//  Copyright (c) 2015 Adeptpros. All rights reserved.
//

#import "MapViewViewController.h"
#import "MKPolyline+MKPolyline_EncodedString.h"
@interface MapViewViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewViewController
@synthesize mapdata;
- (void)viewDidLoad {
    [super viewDidLoad];
    MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = _source.coordinate.latitude;
    region.center.longitude = _source.coordinate.longitude;
    region.span.longitudeDelta = 0.1f;
    region.span.longitudeDelta = 0.1f;
    [_mapView setRegion:region];
    [_mapView addAnnotations:@[_source,_dest]];
    [_mapView addOverlay:[MKPolyline polylineWithEncodedString:mapdata]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    MKPolylineRenderer *polylineRender = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    polylineRender.lineWidth = 3.0f;
    polylineRender.strokeColor = [UIColor blueColor];
    return polylineRender;
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
