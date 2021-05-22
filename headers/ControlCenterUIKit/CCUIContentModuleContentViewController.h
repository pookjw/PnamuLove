#import <UIKit/UIKit.h>

@protocol CCUIContentModuleContentViewController <NSObject>
@optional
@property (nonatomic,readonly) double preferredExpandedContentWidth; 
@property (nonatomic,readonly) double preferredExpandedContinuousCornerRadius; 
@property (nonatomic,readonly) BOOL providesOwnPlatter; 
@property (nonatomic,readonly) UIViewPropertyAnimator * customAnimator; 
@property (nonatomic,readonly) BOOL shouldPerformHoverInteraction; 
@property (nonatomic,readonly) BOOL shouldPerformClickInteraction; 
-(void)willBecomeActive;
-(void)dismissPresentedContentAnimated:(BOOL)arg1 completion:(id)arg2;
-(BOOL)shouldExpandModuleOnTouch:(id)arg1;
-(void)didTransitionToExpandedContentMode:(BOOL)arg1;
-(double)preferredExpandedContinuousCornerRadius;
-(BOOL)canDismissPresentedContent;
-(double)preferredExpandedContentWidth;
-(void)controlCenterWillPresent;
-(void)controlCenterDidDismiss;
-(UIViewPropertyAnimator *)customAnimator;
-(void)displayWillTurnOff;
-(void)willTransitionToExpandedContentMode:(BOOL)arg1;
-(BOOL)shouldPerformHoverInteraction;
-(BOOL)shouldFinishTransitionToExpandedContentModule;
-(BOOL)shouldBeginTransitionToExpandedContentModule;
-(void)willResignActive;
-(BOOL)providesOwnPlatter;
-(BOOL)shouldPerformClickInteraction;

@required
@property (nonatomic,readonly) double preferredExpandedContentHeight; 
-(double)preferredExpandedContentHeight;

@end
