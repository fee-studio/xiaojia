//
//  YIBillItemsCv.m
//  XiaoJia
//
//  Created by efeng on 16/9/11.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import "YIBillItemsCv.h"
#import "YIIncomeTag.h"
#import "YIExpensesTag.h"


#pragma mark - 自定义FlowLayout

@interface YICollectionViewHorizontalFlowLayout : UICollectionViewFlowLayout {

}

@property(nonatomic) NSUInteger rowCount; // 一页显示多少行
@property(nonatomic) NSUInteger itemCountPerRow;
@property(strong, nonatomic) NSMutableArray *allAttributes;

@end

@implementation YICollectionViewHorizontalFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
		self.minimumLineSpacing = 0.f;
		self.minimumInteritemSpacing = 0.f;
        self.itemSize = CGSizeMake((mScreenWidth)/5, (mScreenWidth)/5);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }

    return self;
}

/*
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)offset
								 withScrollingVelocity:(CGPoint)velocity {
	
	CGRect cvBounds = self.collectionView.bounds;
	CGFloat halfWidth = cvBounds.size.width * 0.5f;
	CGFloat proposedContentOffsetCenterX = offset.x + halfWidth;
	
	NSArray* attributesArray = [self layoutAttributesForElementsInRect:cvBounds];
	
	UICollectionViewLayoutAttributes* candidateAttributes;
	for (UICollectionViewLayoutAttributes* attributes in attributesArray) {
		
		// == Skip comparison with non-cell items (headers and footers) == //
		if (attributes.representedElementCategory !=
			UICollectionElementCategoryCell) {
			continue;
		}
		
		// == First time in the loop == //
		if(!candidateAttributes) {
			candidateAttributes = attributes;
			continue;
		}
		
		if (fabsf(attributes.center.x - proposedContentOffsetCenterX) <
			fabsf(candidateAttributes.center.x - proposedContentOffsetCenterX)) {
			candidateAttributes = attributes;
		}
	}
	
	return CGPointMake(candidateAttributes.center.x - halfWidth, offset.y);
	
}
 */

/*
- (void)prepareLayout {
    [super prepareLayout];

    self.rowCount = 2;
    self.itemCountPerRow = 4;
    self.allAttributes = [NSMutableArray array];

    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSUInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.allAttributes addObject:attributes];
    }
}

- (CGSize)collectionViewContentSize {
    return [super collectionViewContentSize];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger item = indexPath.item;
    NSUInteger x;
    NSUInteger y;
    [self targetPositionWithItem:item resultX:&x resultY:&y];
    NSUInteger item2 = [self originItemAtX:x y:y];
    NSIndexPath *theNewIndexPath = [NSIndexPath indexPathForItem:item2 inSection:indexPath.section];

    UICollectionViewLayoutAttributes *theNewAttr = [super layoutAttributesForItemAtIndexPath:theNewIndexPath];
    theNewAttr.indexPath = indexPath;
    return theNewAttr;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];

    NSMutableArray *tmp = [NSMutableArray array];

    for (UICollectionViewLayoutAttributes *attr in attributes) {
        for (UICollectionViewLayoutAttributes *attr2 in self.allAttributes) {
            if (attr.indexPath.item == attr2.indexPath.item) {
                [tmp addObject:attr2];
                break;
            }
        }
    }
    return tmp;
}

// 根据 item 计算目标item的位置
// x 横向偏移  y 竖向偏移
- (void)targetPositionWithItem:(NSUInteger)item
                       resultX:(NSUInteger *)x
                       resultY:(NSUInteger *)y {
    NSUInteger page = item / (self.itemCountPerRow * self.rowCount);

    NSUInteger theX = item % self.itemCountPerRow + page * self.itemCountPerRow;
    NSUInteger theY = item / self.itemCountPerRow - page * self.rowCount;
    if (x != NULL) {
        *x = theX;
    }
    if (y != NULL) {
        *y = theY;
    }
}

// 根据偏移量计算item
- (NSUInteger)originItemAtX:(NSUInteger)x
                          y:(NSUInteger)y {
    NSUInteger item = x * self.rowCount + y;
    return item;
}
*/

@end

#pragma mark - 自定义CollectionView

@interface YIBillItemsCollectionCell : UICollectionViewCell
{
	UILabel *lblTitle;
	UIImageView *ivIcon;
}


//@property(nonatomic, strong) UIImage *icon;
//@property(nonatomic, strong) NSString *title;

//@property(nonatomic, weak) UIImageView *ivIcon;
//@property(nonatomic, weak) UILabel *lblTitle;

- (void)setupCell:(NSString *)title;

@end

@implementation YIBillItemsCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		[self loadUI];
    }

    return self;
}

- (void)loadUI {
    ivIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:ivIcon];
    [ivIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ivIcon.superview).offset(11);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        make.centerX.equalTo(ivIcon.superview);
    }];
//	self.ivIcon = ivIcon;

    lblTitle = [[UILabel alloc] init];
	lblTitle.font = kAppSmlFont;
    lblTitle.textColor = kAppColorGray;
    lblTitle.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:lblTitle];
    [lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lblTitle.superview);
        make.right.equalTo(lblTitle.superview);
		make.top.equalTo(ivIcon.mas_bottom);
        make.bottom.equalTo(lblTitle.superview).offset(-5);
        make.centerX.equalTo(ivIcon.superview);
    }];
//	self.lblTitle = lblTitle;
}

- (void)setupCell:(RLMObject *)object {
	if ([object isKindOfClass:[YIIncomeTag class]]) {
		YIIncomeTag *incomeTag = (YIIncomeTag *)object;
		lblTitle.text = incomeTag.name;
		ivIcon.image = [UIImage imageNamed:incomeTag.iconName];
	} else if ([object isKindOfClass:[YIExpensesTag class]]) {
		YIExpensesTag *expensesTag = (YIExpensesTag *)object;
		lblTitle.text = expensesTag.name;
		ivIcon.image = [UIImage imageNamed:expensesTag.iconName];
	}
	
//	lblTitle.text = object.name;
//	self.backgroundColor = [UIColor randomColor];
}

@end


#pragma mark -

@interface YIBillItemsCv () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
	NSIndexPath *preSelectedIndexPath;
}
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, weak) UIPageControl *pageControl;

@end

@implementation YIBillItemsCv

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadUI];
    }

    return self;
}


- (void)setItems:(RLMResults *)items {
	_items = items;
	[self.collectionView reloadData];
	
	[self setNeedsLayout];
}

- (void)loadUI {
    UICollectionViewFlowLayout *layout = [[YICollectionViewHorizontalFlowLayout alloc] init];
    UICollectionView *cv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
	cv.backgroundColor = kAppColorWhite;
    cv.dataSource = self;
    cv.delegate = self;
    cv.pagingEnabled = YES;
    cv.directionalLockEnabled = YES;
    cv.showsHorizontalScrollIndicator = NO;
    [cv registerClass:[YIBillItemsCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([YIBillItemsCollectionCell class])];
    [self addSubview:cv];
    [cv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cv.superview);
		make.bottom.equalTo(cv.superview).offset(-10);
    }];
	self.collectionView = cv;

    UIView *pcContainer = [[UIView alloc] init];
	pcContainer.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
	pcContainer.layer.cornerRadius = 5;
	pcContainer.layer.masksToBounds = YES;
    [self addSubview:pcContainer];
    [pcContainer mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.equalTo(pcContainer.superview);
        make.centerX.equalTo(pcContainer.superview);
        make.height.equalTo(@10);
    }];
	
	UIPageControl *pc = [[UIPageControl alloc] init];
    pc.pageIndicatorTintColor = kAppColorWhite;
    pc.currentPageIndicatorTintColor = kAppColorMain;
    pc.currentPage = 0;
//	pc.transform = CGAffineTransformMakeScale(0.7, 0.7);
    pc.numberOfPages = (int)floor(cv.contentSize.width / cv.frame.size.width) + 1;
    [pcContainer addSubview:pc];
    [pc mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(pc.superview).insets(UIEdgeInsetsMake(0,10,0,10));
    }];
    self.pageControl = pc;
}

- (void)layoutSubviews {
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    NSInteger pages = (NSInteger) ceil(itemCount / 10.0);
    self.pageControl.numberOfPages = pages;
	
	[super layoutSubviews];
}

// http://stackoverflow.com/questions/29507675/detect-page-change-in-uicollectionview
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    float currentPage = scrollView.contentOffset.x / pageWidth;

    if (0.0f != fmodf(currentPage, 1.0f)) {
        self.pageControl.currentPage = currentPage + 1;
    } else {
        self.pageControl.currentPage = currentPage;
    }
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return _items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YIBillItemsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YIBillItemsCollectionCell class])
                                              forIndexPath:indexPath];
	if (preSelectedIndexPath && indexPath.item == preSelectedIndexPath.item) {
		cell.selected = YES;
	} else {
		cell.selected = NO;
	}
	[cell setupCell:self.items[indexPath.item]];
	cell.selectedBackgroundView = [[UIImageView alloc] initWithImage: [UIImage imageWithColor:kAppColorLightGray]];
	cell.backgroundView = [[UIImageView alloc] initWithImage: [UIImage imageWithColor:[UIColor clearColor]]];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath; {
	// 选中的效果处理
	UICollectionViewCell *preCell = [collectionView cellForItemAtIndexPath:preSelectedIndexPath];
	preCell.selected = NO;
	UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
	cell.selected = YES;
	preSelectedIndexPath = indexPath;
	
	if ([_delegate respondsToSelector:@selector(didSelectBillItem:)]) {
		[_delegate didSelectBillItem:self.items[indexPath.item]];
	}
}

//- (void)dealloc {
//	self.collectionView.delegate = nil;
//	self.collectionView.dataSource = nil;
//	self.collectionView = nil;
//
//	NSLog(@"items collection view dealloc");
//}

@end
