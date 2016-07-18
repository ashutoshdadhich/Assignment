//
//  AboutWebHandler.m
//  AboutApp
//
//  Created by khushboo on 18/07/16.
//  Copyright © 2016 Self. All rights reserved.
//

#import "AboutWebHandler.h"
#import "AboutEntity.h"

static NSString* const strWebURL = @"https://dl.dropboxusercontent.com/u/746330/facts.json";


@implementation AboutWebHandler

-(void)getWebData{
    
    // Create request object for the entity image URL
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:strWebURL]];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // Get task from shared session
    NSURLSessionTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (error != nil)
        {
            abort();
        }
        
        NSError *theError = nil;
        
        NSString *iso = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
        NSData *dutf8 = [iso dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonData = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:dutf8 options:0 error:&theError];
        
        if ([jsonData isKindOfClass:[NSDictionary class]]) {
            
            
            NSMutableArray* entityList = [[NSMutableArray alloc] init];
            
            NSArray* rows = [jsonData objectForKey:@"rows"];
            NSString* strTile = [jsonData objectForKey:@"title"];
            
            if (rows) {
                
                for (NSDictionary* dict in rows) {
                    
                    if (dict) {
                        
                        AboutEntity* entity = [[AboutEntity alloc] initWithData:dict];
                        [entityList addObject:entity];
                    }
                }
            }
            
            // get main thread to update image
            dispatch_sync(dispatch_get_main_queue(),^{
                
                if (self.delegate != nil) {
                    
                    [self.delegate didReciveEntityList:[NSArray arrayWithArray:entityList] withTitle:strTile];
                }
                
            });
        }
        
        
    }];
    
    [task resume];
}


@end
