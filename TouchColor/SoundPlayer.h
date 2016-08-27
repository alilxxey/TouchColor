//
//  SoundPlayer.h
//  TouchColor
//
//  Created by Лёша on 19.11.15.
//  Copyright © 2015 iCoder. All rights reserved.
//

#import <AudioToolbox/AudioServices.h>

@interface SoundPlayer : NSObject {
    
}

+ (void)playSound:(NSString*)soundName;

@end