//
//  VSFilterSwitcherView.h
//  VideoStudio
//
// 
//
//

#import <UIKit/UIKit.h>
#import "VSPlayer.h"
#import "VSFilterImageView.h"

@class VSSwipeableFilterView;
@protocol VSSwipeableFilterViewDelegate <NSObject>

- (void)swipeableFilterView:(VSSwipeableFilterView *__nonnull)swipeableFilterView didScrollToFilter:(VSFilter *__nullable)filter;

@end

/**
 A filter selector view that works like the Snapchat presentation of the available filters.
 Filters are swipeable from horizontally.
 */
@interface VSSwipeableFilterView : VSImageView<UIScrollViewDelegate>

/**
 The available filterGroups that this VSFilterSwitcherView shows
 If you want to show an empty filter (no processing), just add a [NSNull null]
 entry instead of an instance of VSFilterGroup
 */
@property (strong, nonatomic) NSArray *__nullable filters;

/**
 The currently selected filter group.
 This changes when scrolling in the underlying UIScrollView.
 This value is Key-Value observable.
 */
@property (strong, nonatomic) VSFilter *__nullable selectedFilter;

/**
 A filter that is applied before applying the selected filter
 */
@property (strong, nonatomic) VSFilter *__nullable preprocessingFilter;

/**
 The delegate that will receive messages
 */
@property (weak, nonatomic) id<VSSwipeableFilterViewDelegate> __nullable delegate;

/**
 The underlying scrollView used for scrolling between filterGroups.
 You can freely add your views inside.
 */
@property (readonly, nonatomic) UIScrollView *__nonnull selectFilterScrollView;

/**
 Whether the current image should be redraw with the new contentOffset
 when the UIScrollView is scrolled. If disabled, scrolling will never
 show up the other filters, until it receives a new CIImage.
 On some device it seems better to disable it when the VSSwipeableFilterView
 is set inside a VSPlayer.
 Default is YES
 */
@property (assign, nonatomic) BOOL refreshAutomaticallyWhenScrolling;

/**
 Scrolls to a specific filter
 */
- (void)scrollToFilter:(VSFilter *__nonnull)filter animated:(BOOL)animated;


- (void)setFilterIndex:(NSInteger)selectedIndex;
@end
