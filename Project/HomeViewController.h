

#import <UIKit/UIKit.h>
#import "URLConnection.h"
@interface HomeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{

    UITableView *tableView;
    UIRefreshControl *refreshControl;
}
-(UITableView *)makeTableView;
-(void)completionWithHandler:(void(^)(NSString *responseString))response;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

