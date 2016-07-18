//
//  AboutEntity.h
//  AboutApp
//
//  Created by khushboo on 18/07/16.
//  Copyright © 2016 Self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AboutEntity : NSObject

@property (nonatomic, strong) NSString *strTitle;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *strDescription;
@property (nonatomic, strong) NSString *strImageURL;

-(id)initWithData:(NSDictionary*) data;

@end
