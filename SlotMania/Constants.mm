#import "Constants.h"

NSString* strIconName[CHARACTER_COUNT] = { @"character1", @"character2", @"character3", @"character4", @"character5",
                                      @"a", @"k", @"q", @"j", @"10", @"9"};
//NSString* strNumName[RULE_LINE_COUNT] = {@"l8", @"l2", @"l4", @"l7", @"l1", @"l6", @"l5", @"l3", @"l9"};
int cY = SCREEN_HEIGHT / 2 + iDevPixelY(3);
int lineY[RULE_LINE_COUNT] = {cY, cY + iDevPixelY(66), cY - iDevPixelY(66), cY - iDevPixelY(24), cY +iDevPixelY(26), cY + iDevPixelY(14), cY - iDevPixelY(10), cY + iDevPixelY(54), cY - iDevPixelY(53)};