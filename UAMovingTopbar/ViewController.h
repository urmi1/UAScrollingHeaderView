

#import <UIKit/UIKit.h>
#import "CustomHeaderView.h"
#import "TableInfo.h"
#import "UAMovingBarViewController.h"
#import "CustomCell.h"


@interface ViewController : UAMovingBarViewController

@property (nonatomic, weak) IBOutlet UITableView *tableViewController;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *arrheaderInfo;
@property (nonatomic, strong) NSMutableArray *arrTableInfo;
@property (nonatomic, strong) NSMutableArray *arrSearchInfo;


@end

