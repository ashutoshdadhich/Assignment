//
//  AboutImageLoader.h
//  AboutApp
//
//  Created by khushboo on 18/07/16.
//  Copyright © 2016 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AboutEntity;

@interface AboutImageLoader : NSObject

@property (nonatomic, strong) AboutEntity *entity;
@property (nonatomic, copy) void(^completionHandler)(void);
@property (nonatomic, copy) void(^failureHandler)(void);


-(void)startImageDownloading;
-(void)cancelImageDownloading;
@end
