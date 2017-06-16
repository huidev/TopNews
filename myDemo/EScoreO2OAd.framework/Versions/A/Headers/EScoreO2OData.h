//
//  EScoreO2OData.h
//  EScoreO2OAd
//
//  Created by Emar on 3/4/15.
//  Copyright (c) 2015 Yijifen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EScoreO2OData : NSObject

/*!
 * @method initWithAppId:adlId:coopInfo:
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
- (instancetype)initWithAppId:(NSString *)appId adlId:(NSString *)adlId coopInfo:(NSString *)coopInfo;

/*!
 * @method fetchO2OData:
 *
 * @param completionHandler
 * 数据获取完毕后会执行该block
 * o2oData为获取成功后的源数据
 * 如果数据获取失败，将会有error返回
 *
 * @discussion
 * 获取数据
 *
 */
- (void)fetchO2OData:(void (^)(id o2oData, NSError *error))completionHandler;

/*!
 * @method presentDetailInViewController:
 *
 * @discussion
 * 成功获取o2o源数据后，如需获取信息流详情，需要调用该方法进行详情展示
 *
 */
- (void)presentDetailInViewController:(UIViewController *)viewController;


/*!
 * @method o2oDataDisplayed
 *
 * @discussion
 * 成功获取o2o源数据并且展示成功后，调用该方法（详见Demo），如不调用，将无法统计展示数据
 *
 */
- (void)o2oDataDisplayed;

@end
