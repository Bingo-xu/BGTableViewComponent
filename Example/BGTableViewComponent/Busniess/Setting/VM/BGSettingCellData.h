//
//  BGSettingCellData.h
//  BGTableViewComponent_Example
//
//  Created by Bingo on 2022/11/10.
//  Copyright © 2022 Bingo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BGTableViewComponent/BGTableViewComponent.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BGSettingCellEventType) {
    /**账号管理*/
    BGSettingCellEventTypeAcountManagement = 0,
    /**安全设置*/
    BGSettingCellEventTypeSafeSetting,
    /**短信通知*/
    BGSettingCellEventTypeSMS,
    /**恢复交易*/
    BGSettingCellEventTypeTradingResumed,
    /**意见建议*/
    BGSettingCellEventTypeAdvice,
    /**账号注销*/
    BGSettingCellEventTypeAccountCancellation,
    /**APP屏幕常亮*/
    BGSettingCellEventTypeNormally,
    /**隐私政策*/
    BGSettingCellEventTypePrivacy,
    /**用户协议*/
    BGSettingCellEventTypeUserAgreement,
    /**第三方sdk列表*/
    BGSettingCellEventTypeSDK,
    /**个人信息收集清单*/
    BGSettingCellEventTypePrivateInfoList,
    /**应用权限*/
    BGSettingCellEventTypeAPPLimit,
};

typedef NS_ENUM(NSUInteger, BGSettingCellStyleType) {
    /** 带箭头的普通样式*/
    BGSettingCellStyleTypeDefult = 0,
    /** 无箭头的样式*/
    BGSettingCellStyleTypeNoneArrow,
    /** 带Switch样式*/
    BGSettingCellStyleTypeSwitch,
};

@interface BGSettingCellData : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,assign) BGSettingCellStyleType style;
@property (nonatomic,assign) BOOL switchOn;
@property (nonatomic,assign) BOOL bottomLineShow;

/**列表数据源*/
+ (NSArray* )creatDataSource;

+ (BGTableViewRowData *)creatCellDataWith:(NSString* )title eventType:(BGSettingCellEventType)eventType bottomLineShow:(BOOL)bottomLineShow;


@end

NS_ASSUME_NONNULL_END
