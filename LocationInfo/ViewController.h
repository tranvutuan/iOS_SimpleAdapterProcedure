//
//  ViewController.h
//  RESTAPI
//
//  Created by VUTUAN TRAN on 2014-09-01.
//  Copyright (c) 2014 TONY TRAN. All rights reserved.
//
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import "WLClient.h"

@interface ViewController : UIViewController <WLDelegate,MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UITextField *locationField;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@end
