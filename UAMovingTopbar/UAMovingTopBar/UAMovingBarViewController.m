

#import "UAMovingBarViewController.h"

@interface UAMovingBarViewController ()

@end

@implementation UAMovingBarViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    if(self.scrollForHideNavigation){
        self.scrollForHideNavigation.bounces = NO;
        float topInset = _topBarView.frame.size.height;
        self.scrollForHideNavigation.contentInset = UIEdgeInsetsMake(topInset, 0, 0, 0);
    }
}

#pragma mark
#pragma Navigation hide Scroll

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    _isDecelerating = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _isDecelerating = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if(scrollView.contentOffset.y <= -_topBarView.frame.size.height){
        scrollView.bounces = NO;
        float topInset = _topBarView.frame.size.height ;
        self.scrollForHideNavigation.contentInset = UIEdgeInsetsMake(topInset, 0, 0, 0);
    }else{
        scrollView.bounces = YES;
    }
    
    if(self.scrollForHideNavigation != scrollView)
        return;
    if(scrollView.frame.size.height >= scrollView.contentSize.height){
        return;
    }
    
    if(scrollView.contentOffset.y > -_topBarView.frame.size.height && scrollView.contentOffset.y < 0){
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if(scrollView.contentOffset.y >= 0){
        scrollView.bounces = YES;
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    
    if(_lastOffsetY < scrollView.contentOffset.y && scrollView.contentOffset.y >= -_topBarView.frame.size.height){//moving up
        if(_topBarView.frame.size.height + _topBarView.frame.origin.y  > 0){//not yet hidden
            float newY = _topBarView.frame.origin.y - (scrollView.contentOffset.y - _lastOffsetY);
            if(newY < -_topBarView.frame.size.height)
                newY = -_topBarView.frame.size.height;
            _topBarView.frame = CGRectMake(_topBarView.frame.origin.x,newY,_topBarView.frame.size.width,_topBarView.frame.size.height);
        }
    }else
        if(_topBarView.frame.origin.y < [UIApplication sharedApplication].statusBarFrame.size.height  &&
           (self.scrollForHideNavigation.contentSize.height > self.scrollForHideNavigation.contentOffset.y + self.scrollForHideNavigation.frame.size.height)){//not yet shown
            
            float newY = _topBarView.frame.origin.y + (_lastOffsetY - scrollView.contentOffset.y);
            if(newY > [UIApplication sharedApplication].statusBarFrame.size.height)
                newY = [UIApplication sharedApplication].statusBarFrame.size.height;
            _topBarView.frame = CGRectMake(_topBarView.frame.origin.x,newY,_topBarView.frame.size.width,_topBarView.frame.size.height);
        }else{
            
        }
    
    _lastOffsetY = scrollView.contentOffset.y;
}


@end
