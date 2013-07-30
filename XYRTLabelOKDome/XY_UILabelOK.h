//
//  XY_UILabelOK.h
//  XYRTLabelOKDome
//
//  Created by Heaven on 12-12-6.
//  Copyright (c) 2012年 Heaven. All rights reserved.
//

#define kTASK_RUNNING 1
#define kTASK_PAUSE 2
#define kTASK_NOTSET 0
#define kTASK_START 3

#import "RTLabel.h"

@interface XYUILabelOK : RTLabel{
    NSMutableArray *timerPoint; // 时间点
    int currentTimePoint; //当前时间点
    NSMutableArray *words;
    NSMutableString *contentText;      // 卡拉ok文本
    
    int task;
    
    NSString *labFont;      // 字体
    int labFontSize;        // 字体大小
    NSString *labFontAddition;   // font附加参数
    NSString *topColor;   // 前色
    NSString *bottomColor;  // 底色

    float maxTime; // 播放最大时间
    float originTime; // 播放时间起点
    float currentTime;  // 当前时间
}

-(void)setTextwithFile:(NSString *)filePath originTime:(float)aOriginTime maxTime:(float)aMaxTime;
-(void)setTask:(int)i;
-(void)setTopColor:(NSString *)color1 bottomColor:(NSString *)color2;
-(void)setLabFont:(NSString *)aFont labFontSize:(int)aSize labFontAddition:(NSString *)aAddition;

//-(void)updataTextWithTime:(float)fTime;
-(void)updataTextWithInterval:(float)fInterval;

@end
