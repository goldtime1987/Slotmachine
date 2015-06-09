//
//  GrowButton.h
//  Game
//
//  Created by hrh on 9/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GrowIconButton : CCMenu 
{    
}

+ (GrowIconButton*)buttonWithSpriteFrame:(NSString*) frameName 
						 selectframeName: (NSString*) selectframeName
                           iconframeName: (NSString*) iconframeName
                             bShow: (BOOL) bShow
                               position: (CGPoint) position
                                     tag: (int) tag
                                  target:(id)target
                                selector:(SEL)sel;

@end
