//
//  ViewController.h
//  Project
//
//  Created by vigneshwaranm on 12/02/18.
//  Copyright © 2018 FSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

