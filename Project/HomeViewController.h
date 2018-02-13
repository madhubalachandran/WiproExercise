

#import <UIKit/UIKit.h>
#import "URLConnection.h"
@interface HomeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UIRefreshControl *refreshControl;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

