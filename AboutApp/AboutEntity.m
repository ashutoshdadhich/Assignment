//
//  AboutEntity.m
//  AboutApp
//
//  Created by khushboo on 18/07/16.
//  Copyright © 2016 Self. All rights reserved.
//

#import "AboutEntity.h"

@implementation AboutEntity

-(id)initWithData:(NSDictionary*) data{
    self = [super init];
    if (self) {
        self.strTitle = [data objectForKey:@"title"];
        self.strDescription = [data objectForKey:@"description"];
        self.strImageURL = [data objectForKey:@"imageHref"];
        
        if ([self.strTitle isKindOfClass:[NSNull class]]) self.strTitle = @"";
        if ([self.strDescription isKindOfClass:[NSNull class]]) self.strDescription = @"";
        if ([self.strImageURL isKindOfClass:[NSNull class]]) self.strImageURL = @"";
        
    }
    return self;
}

@end
