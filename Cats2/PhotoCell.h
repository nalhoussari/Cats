//
//  PhotoCell.h
//  Cats2
//
//  Created by Noor Alhoussari on 2017-06-19.
//  Copyright © 2017 Noor Alhoussari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *catImage;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
