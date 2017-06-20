//
//  Photo.h
//  Cats2
//
//  Created by Noor Alhoussari on 2017-06-19.
//  Copyright © 2017 Noor Alhoussari. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Photo : NSObject

@property (nonatomic, strong) NSString *server;
@property (nonatomic, strong) NSNumber *farm;
@property (nonatomic, strong) NSString *iD;
@property (nonatomic, strong) NSString *secret;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, readonly, strong) NSString *urlString;
@property (nonatomic, strong) UIImage *catImage;

- (instancetype)initWithServer: (NSString *)server andFarm: (NSNumber *)farm andId: (NSString *)iD andSecret: (NSString *)secret andTitle: (NSString *)title;

// server, farm, id, and secret



@end
