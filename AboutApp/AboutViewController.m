//
//  AboutViewController.m
//  AboutApp
//
//  Created by khushboo on 18/07/16.
//  Copyright © 2016 Self. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutEntity.h"

@interface AboutViewController (){
    AboutWebHandler* webHandler;
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
        
        if (![entity.strImageURL isEqualToString:@""]) {
            
            [self loadCellImageForIndex:indexPath withURL:entity.strImageURL];
        }
        else{
            
            [imageView setImage:[UIImage imageNamed:@""]];
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

-(void)loadCellImageForIndex:(NSIndexPath*)indexPath withURL:(NSString*)imageURL{
    
}

@end
