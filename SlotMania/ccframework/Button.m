//
//  Button.m
//  PaperToss
//
//  Created by admin on 1/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Button.h"
#import "ResourceManager.h"

@implementation Button

+(id) itemFromNormalSprite: (NSString*) strNormal
            selectedSprite: (NSString*) strSelected
                    target:(id)target
                  selector:(SEL)selector
{
    ResourceManager* resManager = [ResourceManager sharedResourceManager];
    
    CCSprite* normalSprite   = [resManager getSpriteWithName: strNormal];
    CCSprite* selectedSprite = [resManager getSpriteWithName: strSelected];
    
    return [self itemFromNormalSprite:normalSprite selectedSprite:selectedSprite disabledSprite:nil target:target selector:selector];
}

+(CCMenuItem*) itemFromFrameName:(NSString *)strNormal selectedFrameName:(NSString *)strSelected tartget:(id)target selector:(SEL)sel
{
    NSString* strFileName;
    CCSprite* sprNor;
    CCSprite* sprOn;
    ResourceManager* res = [ResourceManager sharedResourceManager];
    
    strFileName          = [res makeFileName:strNormal ext:@"png"];
    sprNor               = [CCSprite spriteWithSpriteFrameName:strFileName];
    strFileName          = [res makeFileName:strSelected ext:@"png"];
    sprOn                = [CCSprite spriteWithSpriteFrameName:strFileName];
    
    CCMenuItem* menuItem = [CCMenuItemImage itemFromNormalSprite:sprNor 
                                                   selectedSprite:sprOn 
                                                           target:target 
                                                         selector:sel];
    return menuItem;
}

@end
