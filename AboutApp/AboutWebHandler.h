//
//  AboutWebHandler.h
//  AboutApp
//
//  Created by khushboo on 18/07/16.
//  Copyright © 2016 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AboutWebHandlerDelegate <NSObject>

@required
-(void)didReciveEntityList:(NSArray*)entityList withTitle:(NSString*)title;

@end

@interface AboutWebHandler : NSObject

@property (nonatomic, assign) id <AboutWebHandlerDelegate>delegate;

-(void)getWebData;

@end
