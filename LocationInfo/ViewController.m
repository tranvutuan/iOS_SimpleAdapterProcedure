//
//  ViewController.m
//  RESTAPI
//
//  Created by VUTUAN TRAN on 2014-09-01.
//  Copyright (c) 2014 TONY TRAN. All rights reserved.
//

#import "ViewController.h"
#import "WLProcedureInvocationData.h"
@interface ViewController ()

@end

@implementation ViewController


#pragma makr - View cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
	// Do any additional setup after loading the view, typically from a nib.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Show Location Event
- (IBAction)showLocation:(id)sender
{
    [self.locationField resignFirstResponder];
    [self.indicator startAnimating];
    
    WLProcedureInvocationData *myInvocationData = [[WLProcedureInvocationData alloc] initWithAdapterName:@"RestAdapter" procedureName:@"getLocation"];
    [myInvocationData setParameters:[NSArray arrayWithObject:self.locationField.text.length > 0 ? self.locationField.text : @"Toronto"]];
    [[WLClient sharedInstance] invokeProcedure:myInvocationData withDelegate:self];
}

#pragma mark - WLDelegate
-(void)onSuccess:(WLResponse *)response {
    dispatch_queue_t bgQueue = dispatch_queue_create("Background Queue",NULL);
    [self.mapView removeAnnotation:[self.mapView.annotations lastObject]];
    
    dispatch_async(bgQueue, ^{
        NSDictionary *location = [[response getResponseJson][@"results"] lastObject][@"geometry"][@"location"];
        MKCoordinateRegion region;
        region.center.latitude = [location[@"lat"] doubleValue];
        region.center.longitude = [location[@"lng"] doubleValue];
        region.span.latitudeDelta = 3;
        region.span.longitudeDelta = 3;
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            MKPointAnnotation *mkAnnotation = [[MKPointAnnotation alloc]init];
            mkAnnotation.title = self.locationField.text.length > 0 ? self.locationField.text : @"Toronto";
            
            mkAnnotation.coordinate = CLLocationCoordinate2DMake(region.center.latitude,region.center.longitude);
            
            [self.mapView addAnnotation:mkAnnotation];
            [self.mapView setRegion:region animated:YES];
            [self.mapView selectAnnotation:[[self.mapView annotations] lastObject] animated:YES];
            [self.indicator stopAnimating];

        });
    });
}

-(void)onFailure:(WLFailResponse *)response {
    [self.indicator stopAnimating];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Can't connect to server" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
}

@end
