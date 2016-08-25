//
//  VSAudioConfiguration.h
//  VideoStudio
//
// 
//  Copyright © 2015年 Taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSMediaTypeConfiguration.h"

#define kVSAudioConfigurationDefaultBitrate 128000
#define kVSAudioConfigurationDefaultNumberOfChannels 2
#define kVSAudioConfigurationDefaultSampleRate 44100
#define kVSAudioConfigurationDefaultAudioFormat kAudioFormatMPEG4AAC

@interface VSAudioConfiguration : VSMediaTypeConfiguration

/**
 Set the sample rate of the audio
 If set to 0, the original sample rate will be used.
 If options has been changed, this property will be ignored
 */
@property (assign, nonatomic) int sampleRate;

/**
 Set the number of channels
 If set to 0, the original channels number will be used.
 If options is not nil, this property will be ignored
 */
@property (assign, nonatomic) int channelsCount;

/**
 Must be like kAudioFormat* (example kAudioFormatMPEGLayer3)
 If options is not nil, this property will be ignored
 */
@property (assign, nonatomic) int format;

/**
 The audioMix to apply.
 
 Only used in VSAssetExportSession.
 */
@property (strong, nonatomic) AVAudioMix *__nullable audioMix;

@end
