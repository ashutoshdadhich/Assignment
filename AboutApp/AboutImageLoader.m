//
//  AboutImageLoader.m
//  AboutApp
//
//  Created by khushboo on 18/07/16.
//  Copyright © 2016 Self. All rights reserved.
//

#import "AboutImageLoader.h"
#import "AboutEntity.h"

@interface AboutImageLoader()

//task property
@property (nonatomic, strong) NSURLSessionTask* downloadingTask;

@end

@implementation AboutImageLoader

-(void)startImageDownloading{
    
    // Create request object for the entity image URL
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.entity.strImageURL]];
    
    // Get task from shared session
    self.downloadingTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        
        if (error != nil)
        {
            
            // invock completion block if any
            if (self.failureHandler != nil)
            {
                self.failureHandler();
            }
        }
        
        else{
            // get main thread to update image property of Entity
            dispatch_sync(dispatch_get_main_queue(),^{
                
                UIImage *image = [[UIImage alloc] initWithData:data];
                
                if([image isKindOfClass:[UIImage class]]){
                    self.entity.image = image;
                    
                    // invock completion block if any
                    if (self.completionHandler != nil)
                    {
                        self.completionHandler();
                    }
                }
                
            });
        }
        
    }];
    
    [self.downloadingTask resume];
    
}


-(void)cancelImageDownloading{
    [self.downloadingTask cancel];
    self.downloadingTask = nil;
}

@end
