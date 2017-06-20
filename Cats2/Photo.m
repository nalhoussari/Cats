//
//  Photo.m
//  Cats2
//
//  Created by Noor Alhoussari on 2017-06-19.
//  Copyright © 2017 Noor Alhoussari. All rights reserved.
//

#import "Photo.h"

@implementation Photo

// server, farm, id, and secret
- (instancetype)initWithServer: (NSString *)server andFarm: (NSNumber *)farm andId: (NSString *)iD andSecret: (NSString *)secret andTitle: (NSString *)title
{
    self = [super init];
    if (self) {
        _server = server;
        _farm = farm;
        _iD = iD;
        _secret = secret;
        _title = title;
        NSString *string = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", _farm, _server, _iD, _secret];
        _urlString = string;
        
    }
    return self;
}

@end
