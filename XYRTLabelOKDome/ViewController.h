//
//  ViewController.h
//  XYRTLabelOKDome
//
//  Created by Heaven on 12-12-6.
//  Copyright (c) 2012年 Heaven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
@class XYUILabelOK;

@interface ViewController : UIViewController{
    XYUILabelOK *label1;
    XYUILabelOK *label2;
    XYUILabelOK *label3;
    
    NSTimer *timerLaber;
    AVAudioPlayer           *audioPlayer2;     // 音效
    float timerTnterval;
}

@end
