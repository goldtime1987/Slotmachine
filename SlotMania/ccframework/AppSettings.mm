//
//  AppSetting.m
//  fruitGame
//
//  Created by KCU on 5/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppSettings.h"


@implementation AppSettings

+ (void) defineUserDefaults
{
	NSString* userDefaultsValuesPath;
	NSDictionary* userDefaultsValuesDict;
	
	// load the default values for the user defaults
	userDefaultsValuesPath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
	userDefaultsValuesDict = [NSDictionary dictionaryWithContentsOfFile: userDefaultsValuesPath];
	[[NSUserDefaults standardUserDefaults] registerDefaults: userDefaultsValuesDict];
}

+ (void) setBackgroundVolume: (float) fVolume
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber* aVolume  =	[[NSNumber alloc] initWithFloat: fVolume];	
	[defaults setObject:aVolume forKey:@"music"];	
	[NSUserDefaults resetStandardUserDefaults];	
}

+ (void) setBGM: (BOOL) bFlag
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber* aVolume  =	[[NSNumber alloc] initWithBool: bFlag];	
	[defaults setObject:aVolume forKey:@"BGM"];	
	[NSUserDefaults resetStandardUserDefaults];	    
}

+ (void) setEffect: (BOOL) bFlag
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber* aVolume  =	[[NSNumber alloc] initWithBool: bFlag];	
	[defaults setObject:aVolume forKey:@"Effect"];	
	[NSUserDefaults resetStandardUserDefaults];	        
}

+ (BOOL)  getBGM
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults  boolForKey :@"BGM"];
}

+ (BOOL)  getEffect
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults boolForKey :@"Effect"];
}


+ (float) backgroundVolume
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults floatForKey:@"music"];
}

+ (void) setEffectVolume: (float) fVolume
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber* aVolume  =	[[NSNumber alloc] initWithFloat: fVolume];	
	[defaults setObject:aVolume forKey:@"effect"];	
	[NSUserDefaults resetStandardUserDefaults];	
}

+ (float) effectVolume
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults floatForKey:@"effect"];
}

+ (void) setStartFlag
{
    [self setIntValueWithName:1 name:@"startFlag"];
}

+ (int) getStartFlag
{
    return [self getIntValue:@"startFlag"];
}

+ (void) setCoin: (int) nCoin
{
    [self setIntValueWithName: nCoin name: @"coin"];
}

+ (int) getCoin
{
    return [self getIntValue: @"coin"];
}

+ (void) setLineCount:(int)nCount
{
    [self setIntValueWithName:nCount name:@"lineCount"];
}

+ (int) getLineCount
{
    return [self getIntValue:@"lineCount"];
}

+ (void) setMaxLineCount:(int)nCount
{
    [self setIntValueWithName:nCount name:@"maxLineCount"];
}

+ (int) getMaxLineCount
{
    return [self getIntValue:@"maxLineCount"];
}

+ (void) setBetCount:(int)nCount
{
    [self setIntValueWithName:nCount name:@"betCount"];
}

+ (int) getBetCount
{
    return [self getIntValue:@"betCount"];
}

+ (void) setPayTableFlag:(BOOL)bFlag
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber* aFlag  =	[[NSNumber alloc] initWithBool: bFlag];	
	[defaults setObject:aFlag forKey:@"payTableFlag"];	
	[NSUserDefaults resetStandardUserDefaults];	    
    
}

+ (BOOL) getPayTableFlag
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults  boolForKey :@"payTableFlag"];
}


+ (void) setCurrentStage:(int)nStage
{
    [self setIntValueWithName:nStage name:@"curStage"];
}

+ (int) getCurrentStage
{
    return [self getIntValue: @"curStage"];
}

+ (void) setGameResultCount:(int)nCount
{
    [self setIntValueWithName:nCount name:@"gameResultCount"];
}

+ (int) getGameResultCount
{
    return [self getIntValue:@"gameResultCount"];
}

+ (void) setSlot:(NSString *)strVal
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    //[defaults removeObjectForKey:@"slot"];
    [defaults setObject:strVal forKey:@"slot"];
    [NSUserDefaults resetStandardUserDefaults];
}

+ (NSString*) getSlot
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"slot"];
}

+ (void) setTempSlot:(NSString *)strVal
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:strVal forKey:@"tempSlot"];
    [NSUserDefaults resetStandardUserDefaults];
}

+ (NSString*) getTempSlot
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"tempSlot"];
}

+ (void) setRowIndex:(NSString *)strVal 
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:strVal forKey:@"rowIndex"];
    [NSUserDefaults resetStandardUserDefaults];
}

+ (NSString*) getRowIndex
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"rowIndex"];
}

+ (void) setGameResult:(NSString *)strVal
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:strVal forKey:@"gameResult"];
    [NSUserDefaults resetStandardUserDefaults];
}

+ (NSString*) getGameResult
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"gameResult"];
}

+ (void) setIntValueWithName: (int) nValue name: (NSString*) strName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSNumber* aFlag  =	[NSNumber numberWithFloat: nValue];	
	[defaults setObject:aFlag forKey: strName];	
	[NSUserDefaults resetStandardUserDefaults];
}

+ (int) getIntValue: (NSString*) strName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	int score = (int)[defaults integerForKey: strName];
	return score;
}

@end
