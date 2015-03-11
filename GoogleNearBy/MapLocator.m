//
//  MapLocator.m
//  GoogleNearBy
//
//  Created by Sesha Sai Bhargav Bandla on 04/01/15.
//  Copyright (c) 2015 Adeptpros. All rights reserved.
//

#import "MapLocator.h"
#import "MyLocaion.h"
#import "ViewController.h"
@interface MapLocator ()

@end

@implementation MapLocator
@synthesize coordinates;
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
-(CLLocationCoordinate2D )getCords
{
    return coordinates;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mapView setDelegate:self];
    for (id<MKAnnotation> annotation in _mapView.annotations) {
        [_mapView removeAnnotation:annotation];
    }
    UIBarButtonItem *searchBus=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"mode_transit_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(searchBus)];
    self.navigationItem.rightBarButtonItem=searchBus;
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
-(void)searchBus
{UINavigationController *searchNav=(UINavigationController *) self.tabBarController.viewControllers[0];
           [searchNav popToRootViewControllerAnimated:YES];
    [ (ViewController *) searchNav.topViewController setDestination:address];
    [self.tabBarController setSelectedIndex:0];
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
