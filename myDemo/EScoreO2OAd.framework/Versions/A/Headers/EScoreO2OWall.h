//
//  EScoreO2OWall.h
//  EScoreO2OAds
//
//  Created by Emar on 2/2/15.
//  Copyright (c) 2015 Yijifen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EScoreO2OWall : NSObject

/*!
 * @method initWithAppId:adlId:
 *
 * @param appId
 * 应用ID
 *
 * @param adlId
 * 应用的广告位标识
 *
 * @param coopInfo
 * 用户ID，如果没有用户体系，请默认使用@"coopinfo"，如果不需做服务器端回调则可以不配置此参数
 */
- (id)initWithAppId:(NSString *)appId adlId:(NSString *)adlId coopInfo:(NSString *)coopInfo;

/*!
 * @method presentFromViewController:completion
 *
 * @discussion
 * 展示商品墙
 *
 */
- (void)presentFromViewController:(UIViewController *)viewController completion:(void (^)(void))completion;

/*!
 * @method addDismissCompletion:
 *
 * @discussion
 * 添加关闭商品墙Block
 *
 */
- (void)addDismissCompletion:(void (^)(void))completion;

@end
