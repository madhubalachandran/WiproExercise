

#import "HomeViewController.h"
#import "TableViewCell.h"
#import "URLConnection.h"
@interface HomeViewController ()

@end

@implementation HomeViewController
NSArray *responseArray;
+(void)initialize{
    responseArray= [NSArray array];
}
- (void)viewDidLoad {
    [self getAPIResponse];
  
    refreshControl = [[UIRefreshControl alloc] init];
   refreshControl.backgroundColor = [UIColor purpleColor];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self
                            action:@selector(getAPIResponse)
                  forControlEvents:UIControlEventValueChanged];
     [self.tableView addSubview:refreshControl];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)getAPIResponse{
    [[URLConnection alloc] initRequestWithURL:@"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json" method:GET onResponseReceived:^(NSString *respose) {
        NSError *err = nil;
        NSData *jsonData = [respose dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: &err];
        [self.navigationController setTitle: [responseDictionary valueForKey:@"title"]];
        responseArray = [responseDictionary valueForKey:@"rows"];
        [_tableView reloadData];
        if(refreshControl.isRefreshing){
        [refreshControl endRefreshing];
        }
    }];
   
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *tableViewCell = (TableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    NSDictionary *rowDictionary = [responseArray objectAtIndex:indexPath.row];
    tableViewCell.titleLabel.text=[rowDictionary valueForKey:@"title"]!=[NSNull null]?[rowDictionary valueForKey:@"title"]:@"No Title";
   tableViewCell.descLabel.text=[rowDictionary valueForKey:@"description"]!=[NSNull null]?[rowDictionary valueForKey:@"description"]:@"No Description";
    if([rowDictionary valueForKey:@"imageHref"] != [NSNull null]){
        [tableViewCell.img setImage:[UIImage imageNamed:@"placeholder_loading.png"]];
        [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:[rowDictionary valueForKey:@"imageHref"]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        TableViewCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
                        if (cell)
                            [cell.img setImage:image];
                    });
                }
            }
        }] resume] ;
    }else{
        [tableViewCell.img setImage:[UIImage imageNamed:@"placeholder.png"]];
    }
   
    tableViewCell.backgroundView.backgroundColor=[UIColor colorWithRed:231.0/255 green:42.0/255 blue:42.0/255 alpha:1.0];
    return tableViewCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *rowDictionary = [responseArray objectAtIndex:indexPath.row];
    NSString *descriptionString = [rowDictionary valueForKey:@"description"]!=[NSNull null]?[rowDictionary valueForKey:@"description"]:@"No Description";
    return 100+descriptionString.length/10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return responseArray.count;
}

@end