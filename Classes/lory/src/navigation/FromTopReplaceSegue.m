#import "FromTopReplaceSegue.h"
@implementation FromTopReplaceSegue
-(void)perform{
    UIViewController *dst = [self destinationViewController];
    UIViewController *src = [self sourceViewController];
    [dst viewWillAppear:NO];
    [dst viewDidAppear:NO];
        
    [src.view addSubview:dst.view];
    
    CGRect original = dst.view.frame;
    
    dst.view.frame = CGRectMake(dst.view.frame.origin.x, 0-dst.view.frame.size.height, dst.view.frame.size.width, dst.view.frame.size.height);
    
    [UIView beginAnimations:nil context:nil];
    dst.view.frame = CGRectMake(original.origin.x, original.origin.y, original.size.height, original.size.width);
    [UIView commitAnimations];
    
    [self performSelector:@selector(animationDone:) withObject:dst afterDelay:0.2f];
}
- (void)animationDone:(id)vc{
    UIViewController *dst = (UIViewController*)vc;
    UINavigationController *nav = [[self sourceViewController] navigationController];
    [nav popViewControllerAnimated:NO];
    [nav pushViewController:dst animated:NO];
}
@end