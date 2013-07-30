//
//  XY_UILabelOK.m
//  XYRTLabelOKDome
//
//  Created by Heaven on 12-12-6.
//  Copyright (c) 2012年 Heaven. All rights reserved.
//

#import "XY_UILabelOK.h"

@implementation XYUILabelOK


- (id)initWithFrame:(CGRect)_frame
{
    self = [super initWithFrame:_frame];
    if (self) {
        // Initialization code
        timerPoint = [[NSMutableArray alloc] init];
        words = [[NSMutableArray alloc] init];
        currentTimePoint = 0;
        
        labFont = @"AmericanTypewriter";
        labFontSize = 16;
        labFontAddition = @"";
        
        topColor = @"ff0000";
        bottomColor = @"000000";
        
        task = kTASK_NOTSET;
        
        maxTime = 999;
        originTime = 0;
        currentTime = 0;
    }
    return self;
}
- (void)dealloc
{
    [timerPoint removeAllObjects];
    [timerPoint release];
    [words removeAllObjects];
    [words release];
    [super dealloc];
}

-(void)updataTextWithTime:(float)fTime{
    switch (task) {
        case kTASK_RUNNING:
        {
            int term = 1;
            int didWhile = 0;
            while (term && ([[timerPoint objectAtIndex:currentTimePoint] floatValue] < fTime)){
                currentTimePoint++;
                didWhile++;
                if (currentTimePoint >= timerPoint.count) term = 0;
            }
            if (currentTimePoint > 0) currentTimePoint--;
            
            if (didWhile == 0) {
                [self updataTextWithZero];
                return;
            }
            
            static int iPre = -1;
            if (currentTimePoint == iPre) return;

            iPre = currentTimePoint;
            
            NSMutableString *str1 = [self produceStringInitialization:0 condition:currentTimePoint + 1];
            
            if (currentTimePoint < timerPoint.count - 1)
            {
                NSMutableString *str2 = [self produceStringInitialization2:currentTimePoint + 1 condition:timerPoint.count];
                
                [str1 appendString:str2];
            }
            
            [self setText:str1];

        }
            break;
            
        default:
            break;
    }
    
   }
-(void)updataTextWithInterval:(float)fInterval{
    switch (task) {
        case kTASK_RUNNING:
        {
            currentTime += fInterval;
            if ((currentTime < maxTime) && (currentTime> originTime)) [self updataTextWithTime:currentTime];
            break;
        }
        case kTASK_START:{
            task = kTASK_RUNNING;
            [self updataTextWithInterval:fInterval];
        }
        default:
            break;
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)setTask:(int)i{
    task = i;
}
-(void)setTopColor:(NSString *)color1 bottomColor:(NSString *)color2{
    if (color1) topColor = color1;
    if (color2) bottomColor = color2;
}
-(void)setLabFont:(NSString *)aFont labFontSize:(int)aSize labFontAddition:(NSString *)aAddition{
    if (aFont) labFont = aFont;
    if (aSize) labFontSize = aSize;
    if (aAddition) labFontAddition = aAddition;
}

-(void)setTextwithFile:(NSString *)filePath originTime:(float)aOriginTime maxTime:(float)aMaxTime;{
    // 处理文本
    if (filePath)
    {
        originTime = aOriginTime;
        maxTime = aMaxTime;
        
        NSError *error = noErr;
        NSMutableString *str = [NSMutableString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        //   NSLog(@"%s,%@\n", __func__, str);
        // 解析字符串
        [self analyzingStr:str];
        
        [self updataTextWithZero];
    }
}
#pragma mark-user
-(void)analyzingStr:(NSMutableString *)str{
    NSRange range = NSMakeRange(0, [str length]);
    [str replaceOccurrencesOfString:@"]" withString:@"[" options:NSCaseInsensitiveSearch range:range];
   // [str replaceOccurrencesOfString:@"\r" withString:@"@" options:NSCaseInsensitiveSearch range:range];
   // [str replaceOccurrencesOfString:@"\n" withString:@"@" options:NSCaseInsensitiveSearch range:range];
     NSArray *array = [str componentsSeparatedByString:@"["];
  //  NSLog(@"%s,%@", __func__, array);
    int i = 1;
    while (i < array.count) {
        float f = [[array objectAtIndex:i] floatValue];
        if((f>originTime) &&(f< maxTime))
        {
            [timerPoint addObject:[array objectAtIndex:i]];
            [words addObject:[array objectAtIndex:i + 1]];
        }
        i = i + 2;
    }
    if (timerPoint.count != words.count) {
        [timerPoint removeAllObjects];
        [words removeAllObjects];
        return;
    }
}

-(void)updataTextWithZero{
    NSMutableString *str = [self produceStringInitialization2:0 condition:timerPoint.count];
    [self setText:str];
}
#pragma mark-此处待修改,合并
-(NSMutableString *)produceStringInitialization:(int)iStart condition:(int)iEnd{
    NSMutableString *str = [[[NSMutableString alloc] init] autorelease];
    for (int i = iStart; i< iEnd; i++) {
        [str appendString:[words objectAtIndex:i]];
    }
    str = [NSMutableString stringWithFormat:@"<font face='%@' size=%d color='#%@' %@>%@</font>", labFont, labFontSize, topColor, labFontAddition, str];
    return str;
}
-(NSMutableString *)produceStringInitialization2:(int)iStart condition:(int)iEnd{
    NSMutableString *str = [[[NSMutableString alloc] init] autorelease];
    for (int i = iStart; i< iEnd; i++) {
        [str appendString:[words objectAtIndex:i]];
    }
    str = [NSMutableString stringWithFormat:@"<font face='%@' size=%d color='#%@' %@>%@</font>", labFont, labFontSize, bottomColor, labFontAddition, str];
    return str;
}
@end
