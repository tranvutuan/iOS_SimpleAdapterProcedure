//
//  TNAConnection.m
//  FormBaseAuthentication
//
//  Created by VuTuan Tran on 2014-09-06.
//  Copyright (c) 2014 dhltd.apple. All rights reserved.
//
#import "AppDelegate.h"
#import "ViewController.h"
#import "TNAConnectionListener.h"
@interface TNAConnectionListener ()
@end

@implementation TNAConnectionListener

#pragma mark - Initalization
- (id)initWithViewController :(ViewController*)controller;{
    if ( self = [super init] )
        self.controller = controller;
    return self;
}

#pragma mark - WLDelegate
#pragma mark - WLDelegate
-(void)onSuccess:(WLResponse *)response {
    [self.controller displayMap:response];
    
}

-(void)onFailure:(WLFailResponse *)response {
    [self.controller showError:response];
}
@end
