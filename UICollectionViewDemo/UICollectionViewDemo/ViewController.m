/////////////////////////////////////////////////////////////////////////////////////////////////////
///	
///  @file       ViewController.m
///  @copyright  Copyright © 2018 小灬豆米. All rights reserved.
///  @brief      ViewController
///  @date       2018/10/24
///  @author     小灬豆米
///
/////////////////////////////////////////////////////////////////////////////////////////////////////

#import "ViewController.h"

static NSString * const kCellIdentifier = @"Cell";

@interface ViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) NSArray<NSNumber *> *widthArray;
@property (nonatomic, strong) NSArray<NSNumber *> *widthArray1;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initUI];
    self.widthArray = @[@(10),@(100),@(20),@(30),@(22),@(14),@(11),@(10),@(130),@(120),@(65),@(33),@(11),@(33),@(55),@(88),@(90),@(44),@(22),@(11)];
    self.widthArray1 = @[@(100),@(100),@(100),@(100),@(100),@(100),@(100),@(100),@(100),@(100),@(100),@(100),@(100),@(100),@(100),@(100),@(100),@(100),@(100),@(100)];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.collectionView.frame = CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 106);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.widthArray1.count;
}

 - (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.backgroundColor = [UIColor yellowColor];
    } else {
        cell.backgroundColor = [UIColor blueColor];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {

        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];

        UILabel *label = [[UILabel alloc] initWithFrame:header.bounds];
        label.text = [NSString stringWithFormat:@"%ld", (unsigned long)indexPath.section];
        label.textColor = [UIColor greenColor];
        label.textAlignment = NSTextAlignmentCenter;
        if (indexPath.section == 0) {
            label.backgroundColor = [UIColor redColor];
        } else {
            label.backgroundColor = [UIColor cyanColor];
        }
        [header addSubview:label];

        return header;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(100, CGRectGetHeight(collectionView.bounds));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    return CGSizeMake(self.widthArray[indexPath.row].integerValue, 106);
    return CGSizeMake(self.widthArray1[indexPath.row].integerValue, 106);
}

#pragma mark - Customized

- (void)initUI
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    flowLayout.minimumInteritemSpacing = 100; // use widthArray it can work.
    flowLayout.minimumLineSpacing = 100; // use widthArray1 it can work.
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [self.view addSubview:self.collectionView];
    self.selectedIndexPath = [NSIndexPath indexPathForRow:-1 inSection:-1];
}


@end
