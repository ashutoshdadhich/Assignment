//
//  AboutViewController.m
//  AboutApp
//
//  Created by khushboo on 18/07/16.
//  Copyright © 2016 Self. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutEntity.h"
#import "AboutImageLoader.h"

@interface AboutViewController (){
    AboutWebHandler* webHandler;
    NSMutableDictionary* imageTaskTracker;
}

@property (nonatomic, strong) NSArray* aboutEntityList;
@property (strong, nonatomic) IBOutlet UITableView *tblAboutData;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"";
    
    //incock web handler to get server data
    webHandler = [[AboutWebHandler alloc] init];
    webHandler.delegate = self;
    [webHandler getWebData];
    
    imageTaskTracker = [[NSMutableDictionary alloc] init];
    
    self.tableView.estimatedRowHeight = 92;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.aboutEntityList.count > 0) {
        return self.aboutEntityList.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"AboutListCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
    AboutEntity* entity = [self.aboutEntityList objectAtIndex:indexPath.row];
    
    UIImageView* imageView = (UIImageView*)[ cell viewWithTag:1 ];
    UILabel* lblTitle = (UILabel*)[ cell viewWithTag:2 ];
    UILabel* lblDescription = (UILabel*)[ cell viewWithTag:3 ];
    lblTitle.text = entity.strTitle;
    lblDescription.text = entity.strDescription;
    
    // load cell image in background, if not available
    if (entity.image != nil) {
        
        imageView.image = entity.image;
        
    }else{
        [imageView setImage:[UIImage imageNamed:@"default-placeholder.png"]];
        if (![entity.strImageURL isEqualToString:@""]) {
            
            [self loadCellImageForIndex:indexPath withEntity:entity];
        }
    }
    
    return cell;
}

#pragma mark - About Web Handler Delegate

-(void)didReciveEntityList:(NSArray*)entityList withTitle:(NSString*)title{
    
    self.title = title;
    
    if (entityList) {
        // store and reload table data
        self.aboutEntityList = [NSArray arrayWithArray:entityList];
        [self.tableView reloadData];
    }
}

- (IBAction)actionRefresh:(id)sender {
    //refresh the about list
    
    //clear entity list
    
    //terminate all image downloading tasks
    
    //request webadata
}

-(void)loadCellImageForIndex:(NSIndexPath*)indexPath withEntity:(AboutEntity*)entity{
    
    //Keep track of downloaders
    AboutImageLoader* imageLoader = [imageTaskTracker objectForKey:indexPath];
    
    // start image download only if not already downloading
    if (!imageLoader) {
        
        
        // instantiate the image loader and provide completion block
        imageLoader = [[AboutImageLoader alloc] init];
        imageLoader.entity = entity;
        imageLoader.completionHandler = ^{
            
            // On successful image download get the appropriate cell and set the image
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

            UIImageView* imageView = (UIImageView*)[ cell viewWithTag:1 ];
            
            UIActivityIndicatorView* indicator = (UIActivityIndicatorView*)[ cell viewWithTag:4 ];
            
            imageView.image = entity.image;
            
            indicator.hidden = YES;
            [indicator stopAnimating];
            
            // remove from tracker
            [imageTaskTracker removeObjectForKey:indexPath];
            
        };
        
        imageLoader.failureHandler = ^{
            // Handel Failure
           
        };
        
        [imageLoader startImageDownloading];
        [imageTaskTracker  setObject:imageLoader forKey:indexPath];
    }
    
}

@end
