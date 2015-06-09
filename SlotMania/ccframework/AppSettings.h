//
//  AppSetting.h
//  fruitGame
//
//  Created by KCU on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AppSettings : NSObject 
{

}

+ (void) defineUserDefaults;

+ (void)        setBackgroundVolume: (float) fVolume;
+ (void)        setBGM: (BOOL) bFlag;

+ (void)        setEffect: (BOOL) bFlag;
+ (void)        setEffectVolume: (float) fVolume;

+ (float)       backgroundVolume;
+ (BOOL)        getBGM;

+ (BOOL)        getEffect;
+ (float)       effectVolume;

+ (void)        setStartFlag;
+ (int)         getStartFlag;

+ (void)        setCurrentStage: (int) nStage;
+ (int)         getCurrentStage;

+ (void)        setCoin: (int) nCoin;
+ (int)         getCoin;

+ (void)        setLineCount: (int) nCount;
+ (int)         getLineCount;

+ (void)        setMaxLineCount: (int) nCount;
+ (int)         getMaxLineCount;

+ (void)        setBetCount: (int) nCount;
+ (int)         getBetCount;

+ (void)        setGameResultCount: (int) nCount;
+ (int)         getGameResultCount;

+ (void)        setSlot: (NSString*) strVal;
+ (NSString*)   getSlot;

+ (void)        setTempSlot: (NSString*) strVal;
+ (NSString*)   getTempSlot;

+ (void)        setPayTableFlag: (BOOL) bFlag;
+ (BOOL)        getPayTableFlag;

+ (void)        setRowIndex: (NSString*) strVal;
+ (NSString*)   getRowIndex;

+ (void)        setGameResult: (NSString*) strVal;
+ (NSString*)   getGameResult;

+ (void)        setIntValueWithName: (int) nValue name: (NSString*) strName;
+ (int)         getIntValue: (NSString*) strName;

@end
