//
//  EScoreO2ODemoView.m
//  EScoreO2ODevApp
//
//  Created by Emar on 3/4/15.
//  Copyright (c) 2015 Yijifen. All rights reserved.
//

#import "EScoreO2ODemoView.h"

@implementation EScoreO2ODemoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 0.5f;
        
        CGFloat spacing = 10;
        CGFloat imageWidth = 80;
        CGFloat titleLabelHeight = 20;
        CGFloat detailLabelHeight = 30;
        CGFloat distanceLabelWidth = 60, distanceLabelHeight = 20;
        CGFloat priceLabelWidth = 80, priceLabelHeight = 30;
        CGFloat valueLabelWidth = 80, valueLabelHeight = 30;
        CGFloat boughtLabelWidth = 100, boughtLabelHeight = 30;
        
        CGRect rect = CGRectMake(spacing, spacing, imageWidth, imageWidth);
        self.imageView = [[UIImageView alloc] initWithFrame:rect];
        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.clipsToBounds = YES;
        [self addSubview:self.imageView];
        
        rect = CGRectMake(CGRectGetMaxX(rect)+spacing, spacing, CGRectGetWidth(frame)-imageWidth-spacing*3-distanceLabelWidth, titleLabelHeight);
        self.titleLabel = [[UILabel alloc] initWithFrame:rect];
        self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:self.titleLabel];
        
        rect = CGRectMake(CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetWidth(frame)-imageWidth-spacing*3, detailLabelHeight);
        self.detailLabel = [[UILabel alloc] initWithFrame:rect];
        self.detailLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.detailLabel.backgroundColor = [UIColor clearColor];
        self.detailLabel.textColor = [UIColor lightGrayColor];
        self.detailLabel.font = [UIFont systemFontOfSize:12.0f];
        self.detailLabel.numberOfLines = 0;
        [self addSubview:self.detailLabel];
        
        rect = CGRectMake(CGRectGetWidth(frame)-spacing-distanceLabelWidth, spacing, distanceLabelWidth, distanceLabelHeight);
        self.distanceLabel = [[UILabel alloc] initWithFrame:rect];
        self.distanceLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        self.distanceLabel.backgroundColor = [UIColor clearColor];
        self.distanceLabel.textColor = [UIColor lightGrayColor];
        self.distanceLabel.font = [UIFont systemFontOfSize:12.0f];
        self.distanceLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.distanceLabel];
        
        rect = CGRectMake(CGRectGetMinX(self.detailLabel.frame), CGRectGetMaxY(self.detailLabel.frame), priceLabelWidth, priceLabelHeight);
        self.priceLabel = [[UILabel alloc] initWithFrame:rect];
        self.priceLabel.backgroundColor = [UIColor clearColor];
        self.priceLabel.textColor = [UIColor redColor];
        self.priceLabel.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:self.priceLabel];
        
        rect = CGRectMake(CGRectGetMaxX(self.priceLabel.frame), CGRectGetMaxY(self.detailLabel.frame), valueLabelWidth, valueLabelHeight);
        self.valueLabel = [[UILabel alloc] initWithFrame:rect];
        self.valueLabel.backgroundColor = [UIColor clearColor];
        self.valueLabel.textColor = [UIColor lightGrayColor];
        self.valueLabel.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:self.valueLabel];
        
        rect = CGRectMake(CGRectGetWidth(frame)-spacing-boughtLabelWidth, CGRectGetMaxY(self.detailLabel.frame), boughtLabelWidth, boughtLabelHeight);
        self.boughtLabel = [[UILabel alloc] initWithFrame:rect];
        self.boughtLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        self.boughtLabel.backgroundColor = [UIColor clearColor];
        self.boughtLabel.textColor = [UIColor lightGrayColor];
        self.boughtLabel.font = [UIFont systemFontOfSize:12.0f];
        self.boughtLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.boughtLabel];
        
    }
    return self;
}

@end
