//
//  ViewController.m
//  myDemo
//
//  Created by 于君 on 15/3/16.
//  Copyright (c) 2015年 yj. All rights reserved.
//

#import "ViewController.h"
#import "BViewController.h"
#import "ScrollViewController.h"
#import "EScoreO2ODemoView.h"

#import <EScoreO2OAd/EScoreO2OWall.h>
#import <EScoreO2OAd/EScoreO2OData.h>

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *displayValueLB;
@property (strong, nonatomic) IBOutlet CustomView *myCustomView;
@property (strong, nonatomic) EScoreO2OData *o2oData;
@property (strong, nonatomic) EScoreO2ODemoView *o2oDemoView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ViewController __block *weakSelf =  self;
    self.myCustomView.myBlock = ^(UIButton *sender)
    {
        weakSelf.displayValueLB.text = [NSString stringWithFormat:@"%ld",(long)sender.tag];
        
    };
    [self.o2oData fetchO2OData:^(id o2oData, NSError *error) {
        
        
        if (!error) {
            if ([o2oData isKindOfClass:[NSDictionary class]]) {
                NSDictionary *xinxiliu = [o2oData objectForKey:@"xinxiliu"];
                NSArray *dealList = [xinxiliu objectForKey:@"dealList"];
                if (dealList.count) {
                    
                    NSString *dealImg = [[dealList lastObject] objectForKey:@"dealImg"];
                    self.o2oDemoView.titleLabel.text = [[dealList lastObject] objectForKey:@"dealName"];
                    self.o2oDemoView.detailLabel.text = [[dealList lastObject] objectForKey:@"details"];
                    
                    //处理dis为空的情况
                    NSString *distance = nil;
                    id dis = [[dealList lastObject] objectForKey:@"dis"];
                    if (dis != nil && ![dis isKindOfClass:[NSNull class]]) {
                        distance = [NSString stringWithFormat:@"%.2fm", [[[dealList lastObject] objectForKey:@"dis"] floatValue]];
                    }
                    self.o2oDemoView.distanceLabel.text = distance;
                    
                    self.o2oDemoView.priceLabel.text = [NSString stringWithFormat:@"¥%@", [[dealList lastObject] objectForKey:@"price"]];
                    self.o2oDemoView.boughtLabel.text = [NSString stringWithFormat:@"已售%@", [[dealList lastObject] objectForKey:@"bought"]];
                    
                    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@", [[dealList lastObject] objectForKey:@"value"]]];
                    [attString addAttribute:NSStrikethroughStyleAttributeName value:@(2) range:NSMakeRange(0,[attString length])];
                    self.o2oDemoView.valueLabel.attributedText = attString;
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:dealImg]];
                        UIImage *image = [[UIImage alloc] initWithData:data];
                        dispatch_async( dispatch_get_main_queue(), ^(void){
                            if( image != nil ) {
                                self.o2oDemoView.imageView.image = image;
                            } else {
                                self.o2oDemoView.imageView.image = nil;
                            }
                        });
                    });
                    
                    [UIView animateWithDuration:.3f animations:^{
                        self.o2oDemoView.alpha = 1;
                    } completion:^(BOOL finished) {
                        [self.o2oData o2oDataDisplayed];
                    }];
                    
                }
                
            }
        } else {
            
        }
    }];

    // Do any additional setup after loading the view, typically from a nib.
}

- (EScoreO2ODemoView *)o2oDemoView {
    if (_o2oDemoView == nil) {
        CGFloat height = 200;
        CGRect frame = CGRectMake(0, CGRectGetHeight(self.view.bounds)-height, CGRectGetWidth(self.view.bounds), height-50);
        _o2oDemoView = [[EScoreO2ODemoView alloc] initWithFrame:frame];
        _o2oDemoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [self.view addSubview:_o2oDemoView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taped:)];
        [_o2oDemoView addGestureRecognizer:tap];
    }
    return _o2oDemoView;
}

- (EScoreO2OData *)o2oData {
    if (_o2oData == nil) {
        _o2oData = [[EScoreO2OData alloc] initWithAppId:@"1106" adlId:@"011649ad-9f54-46" coopInfo:@"coopinfo"];
    }
    return _o2oData;
}
- (IBAction)pushBViewController:(id)sender {
    ScrollViewController *vc = [ScrollViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    return;
    BViewController *bVC = [[BViewController alloc]init];
    ViewController __block *weakSelf =  self;
    bVC.myBlock =^(NSString *str)
    {
        weakSelf.displayValueLB.text = [NSString stringWithFormat:@"%@",str];
    };
    
    [self.navigationController pushViewController:bVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
