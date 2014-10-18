
#import <UIKit/UIKit.h>

@interface UAMovingBarViewController : UIViewController

@property (nonatomic) CGFloat lastOffsetY;
@property (nonatomic, assign) BOOL isDecelerating;
@property (nonatomic, assign) BOOL isDragging;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollForHideNavigation;
@property (nonatomic, strong) IBOutlet UIView *topBarView;

@end



