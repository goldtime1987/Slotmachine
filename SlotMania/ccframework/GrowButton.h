//
//  GrowButton.h
//  Game
//
//  Created by hrh on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ScaleMenu.h"

#define Tag_Item	1

@interface GrowButton : ScaleMenu 
{    
    
}

+ (GrowButton*)buttonWithSprite:(NSString*)normalImage
					selectImage: (NSString*) selectImage
					  target:(id)target
					selector:(SEL)sel;

+ (GrowButton*)buttonWithSpriteFrame:(NSString*)frameName 
						 selectframeName: (NSString*) selectframeName
                                 tag:(int)tag
                              target:(id)target
					   selector:(SEL)sel;
+ (GrowButton*)buttonWithSpriteFileName:(NSString*) normalName 
                        selectframeName:(NSString *)selectName
                                    tag:(int)tag
                                 target:(id)target
                               selector:(SEL)sel;
@end
