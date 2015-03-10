//
//  MKPolyline+MKPolyline_EncodedString.h
//  GoogleNearBy
//
//  Created by Sesha Sai Bhargav Bandla on 11/01/15.
//  Copyright (c) 2015 Adeptpros. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKPolyline (MKPolyline_EncodedString)
+ (MKPolyline *)polylineWithEncodedString:(NSString *)encodedString;
@end
