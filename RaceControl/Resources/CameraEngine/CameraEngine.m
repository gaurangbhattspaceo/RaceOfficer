//
//  CameraEngine.m
//  Encoder Demo
//
//  Created by Geraint Davies on 19/02/2013.
//  Copyright (c) 2013 GDCL http://www.gdcl.co.uk/license.htm
//

#import "CameraEngine.h"
#import "VideoEncoder.h"
#import "AssetsLibrary/ALAssetsLibrary.h"

static CameraEngine* theEngine;

@interface CameraEngine  () <AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate>
{
    AVCaptureSession* _session;
    AVCaptureVideoPreviewLayer* _preview;
    dispatch_queue_t _captureQueue;
    AVCaptureConnection* _audioConnection;
    AVCaptureConnection* _videoConnection;
    
    VideoEncoder* _encoder;
    BOOL _isCapturing;
    BOOL _isPaused;
    BOOL _discont;
    int _currentFile;
    CMTime _timeOffset;
    CMTime _lastVideo;
    CMTime _lastAudio;
    
    int _cx;
    int _cy;
    int _channels;
    Float64 _samplerate;
    NSString *videoPathfile;
    
    
    
}

@end


@implementation CameraEngine
@synthesize _session;
@synthesize isCapturing = _isCapturing;
@synthesize isPaused = _isPaused;

+ (void) initialize
{
    // test recommended to avoid duplicate init via subclass
    if (self == [CameraEngine class])
    {
        theEngine = [[CameraEngine alloc] init];
    }
}

+ (CameraEngine*) engine
{
    return theEngine;
}

- (void) startup
{
    if (_session == nil)
    {
        NSLog(@"Starting up server");

        self.isCapturing = NO;
        self.isPaused = NO;
        _currentFile = 0;
        _discont = NO;
        
        // create capture device with video input
        _session = [[AVCaptureSession alloc] init];
      // _videoConnection=[[AVCaptureConnection alloc] init];
      
        // start  ================----- reduce camera quality -----===========
        
        [_session beginConfiguration];
        _session.sessionPreset = AVCaptureSessionPresetMedium;
        [_session commitConfiguration];
        
        
        //  end ================----- reduce camera quality -----=============
        
        AVCaptureDevice* backCamera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        AVCaptureDeviceInput* input = [AVCaptureDeviceInput deviceInputWithDevice:backCamera error:nil];
        
        if ([_session canAddInput: input])
        {
            [_session addInput: input];
        }
        
        
       // [_session addInput:input];
        
        // audio input from default mic
        AVCaptureDevice* mic = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
        AVCaptureDeviceInput* micinput = [AVCaptureDeviceInput deviceInputWithDevice:mic error:nil];
        [_session addInput:micinput];
        
        // create an output for YUV output with self as delegate
        _captureQueue = dispatch_queue_create("uk.co.gdcl.cameraengine.capture", DISPATCH_QUEUE_SERIAL);
        AVCaptureVideoDataOutput* videoout = [[AVCaptureVideoDataOutput alloc] init];
        [videoout setSampleBufferDelegate:self queue:_captureQueue];
       // kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange
        NSDictionary* setcapSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange], kCVPixelBufferPixelFormatTypeKey,
                                        nil];
        videoout.videoSettings = setcapSettings;
        [_session addOutput:videoout];
        _videoConnection = [videoout connectionWithMediaType:AVMediaTypeVideo];
      
        if([_videoConnection isVideoOrientationSupported]) // **Here it is, its always false**
        {
            NSLog(@"is supoorted");
            [_videoConnection setVideoOrientation:UIInterfaceOrientationPortrait];
        }
        
        if([_preview.connection isVideoOrientationSupported]) // **Here it is, its always false**
        {
            NSLog(@"is supoorted");
            [_preview.connection setVideoOrientation:UIInterfaceOrientationIsPortrait(UIInterfaceOrientationPortrait)];
        }
        // find the actual dimensions used so we can set up the encoder to the same.
        NSDictionary* actual = videoout.videoSettings;
        _cy = [[actual objectForKey:@"Width"] integerValue];
        _cx = [[actual objectForKey:@"Height"] integerValue];
        
       
        AVCaptureAudioDataOutput* audioout = [[AVCaptureAudioDataOutput alloc] init];
        [audioout setSampleBufferDelegate:self queue:_captureQueue];
        [_session addOutput:audioout];
        _audioConnection = [audioout connectionWithMediaType:AVMediaTypeAudio];
        // for audio, we want the channels and sample rate, but we can't get those from audioout.audiosettings on ios, so
        // we need to wait for the first sample
        
        // start capture and a preview layer
        [_session startRunning];

        _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
        _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
}

- (void) startCapture
{
    @synchronized(self)
    {
        if (!self.isCapturing)
        {
            NSLog(@"starting capture");
            
            // create the encoder once we have the audio params
            _encoder = nil;
            self.isPaused = NO;
            _discont = NO;
            _timeOffset = CMTimeMake(0, 0);
            self.isCapturing = YES;
        }
    }
}


- (void) turnTorchOn: (bool) on {
    
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (on) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                //torchIsOn = YES;
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                // torchIsOn = NO;
            }
            [device unlockForConfiguration];
        }
    }
}


- (void) stopCapture
{
    @synchronized(self)
    {
        if (self.isCapturing)
        {self.isCapturing = NO;

            dispatch_async(_captureQueue, ^{
//                [_encoder finishWithCompletionHandler:^{
//                    self.isCapturing = NO;
//                    _encoder = nil;
//                    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//                    [library writeVideoAtPathToSavedPhotosAlbum:url completionBlock:^(NSURL *assetURL, NSError *error){
//                        NSLog(@"save completed");
//                        // [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
//                    }];
//                }];
                
                [_encoder finishWithCompletionHandler:^{
                    NSLog(@"Capture completed");
                }];
            });
            
            
            //            NSString* filename = [NSString stringWithFormat:@"capture%d.mp4", _currentFile];
//            NSString* path = [NSTemporaryDirectory() stringByAppendingPathComponent:filename];
//            NSURL* url = [NSURL fileURLWithPath:path];
    /*        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"CapturedMedia"];
            NSString*  videoPath = [NSString stringWithFormat:@"%@/itemVideo.mp4", dataPath];
            //NSURL* url = [NSURL fileURLWithPath:videoPath];
            NSLog(@"videoPath-->%@",videoPath);
            _currentFile++;
            
           
            
            dispatch_async(_captureQueue, ^{
                [_encoder finishWithCompletionHandler:^{
                    self.isCapturing = NO;
                    _encoder = nil;
                    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
                    [library writeVideoAtPathToSavedPhotosAlbum:url completionBlock:^(NSURL *assetURL, NSError *error){
                        NSLog(@"save completed");
                       // [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
                    }];
                }];
            });*/
        }
    }
}

- (void) pauseCapture
{
    @synchronized(self)
    {
        if (self.isCapturing)
        {
            
            self.isPaused = YES;
            _discont = YES;
        }
    }
}

- (void) resumeCapture
{
    @synchronized(self)
    {
        if (self.isPaused)
        {
          
            self.isPaused = NO;
        }
    }
}

- (CMSampleBufferRef) adjustTime:(CMSampleBufferRef) sample by:(CMTime) offset
{
    CMItemCount count;
    CMSampleBufferGetSampleTimingInfoArray(sample, 0, nil, &count);
    CMSampleTimingInfo* pInfo = malloc(sizeof(CMSampleTimingInfo) * count);
    CMSampleBufferGetSampleTimingInfoArray(sample, count, pInfo, &count);
    for (CMItemCount i = 0; i < count; i++)
    {
        pInfo[i].decodeTimeStamp = CMTimeSubtract(pInfo[i].decodeTimeStamp, offset);
        pInfo[i].presentationTimeStamp = CMTimeSubtract(pInfo[i].presentationTimeStamp, offset);
    }
    CMSampleBufferRef sout;
    CMSampleBufferCreateCopyWithNewTiming(nil, sample, count, pInfo, &sout);
    free(pInfo);
    return sout;
}

- (void) setAudioFormat:(CMFormatDescriptionRef) fmt
{
    const AudioStreamBasicDescription *asbd = CMAudioFormatDescriptionGetStreamBasicDescription(fmt);
    _samplerate = asbd->mSampleRate;
    _channels = asbd->mChannelsPerFrame;
    
}

- (void) captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    BOOL bVideo = YES;
    
    @synchronized(self)
    {
        if (!self.isCapturing  || self.isPaused)
        {
            return;
        }
        if (connection != _videoConnection)
        {
            bVideo = NO;
        }
        if ((_encoder == nil) && !bVideo)
        {
            CMFormatDescriptionRef fmt = CMSampleBufferGetFormatDescription(sampleBuffer);
            [self setAudioFormat:fmt];
            
            NSString* filename = [NSString stringWithFormat:@"capture%d.mp4", _currentFile];
            NSString* videoPath = [NSTemporaryDirectory() stringByAppendingPathComponent:filename];
            
            
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
           // NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"CapturedMedia"];
            // NSString*  videoPath = [NSString stringWithFormat:@"%@/itemVideo.mp4", dataPath];
      
            int timestamp=[[NSDate date]timeIntervalSince1970];

            NSString *videoPath1 = [NSString stringWithFormat:@"%@/%d.mov",documentsDirectory,timestamp];
        
            
            DELEGATE.videopath=[NSString stringWithFormat:@"/%d.mov",timestamp];
            
            
            _encoder = [VideoEncoder encoderForPath:videoPath1 Height:_cy width:_cx channels:_channels samples:_samplerate];
            
            

            
            
           // _encoder = [VideoEncoder encoderForPath:videoPathfile Height:_cy width:_cx channels:_channels samples:_samplerate];
            
   
        }
        if (_discont)
        {
            if (bVideo)
            {
                return;
            }
            _discont = NO;
            // calc adjustment
            CMTime pts = CMSampleBufferGetPresentationTimeStamp(sampleBuffer);
            CMTime last = bVideo ? _lastVideo : _lastAudio;
            if (last.flags & kCMTimeFlags_Valid)
            {
                if (_timeOffset.flags & kCMTimeFlags_Valid)
                {
                    pts = CMTimeSubtract(pts, _timeOffset);
                }
                CMTime offset = CMTimeSubtract(pts, last);
                NSLog(@"Setting offset from %s", bVideo?"video": "audio");
                NSLog(@"Adding %f to %f (pts %f)", ((double)offset.value)/offset.timescale, ((double)_timeOffset.value)/_timeOffset.timescale, ((double)pts.value/pts.timescale));
                
                // this stops us having to set a scale for _timeOffset before we see the first video time
                if (_timeOffset.value == 0)
                {
                    _timeOffset = offset;
                }
                else
                {
                    _timeOffset = CMTimeAdd(_timeOffset, offset);
                }
            }
            _lastVideo.flags = 0;
            _lastAudio.flags = 0;
        }
        
        // retain so that we can release either this or modified one
        CFRetain(sampleBuffer);
        
        if (_timeOffset.value > 0)
        {
            CFRelease(sampleBuffer);
            sampleBuffer = [self adjustTime:sampleBuffer by:_timeOffset];
        }
        
        // record most recent time so we know the length of the pause
        CMTime pts = CMSampleBufferGetPresentationTimeStamp(sampleBuffer);
        CMTime dur = CMSampleBufferGetDuration(sampleBuffer);
        if (dur.value > 0)
        {
            pts = CMTimeAdd(pts, dur);
        }
        if (bVideo)
        {
            _lastVideo = pts;
        }
        else
        {
            _lastAudio = pts;
        }
    }

    // pass frame to encoder
    [_encoder encodeFrame:sampleBuffer isVideo:bVideo];
    CFRelease(sampleBuffer);
}

- (void) shutdown
{
    NSLog(@"shutting down server");
    if (_session)
    {
        [_session stopRunning];
        _session = nil;
    }
    [_encoder finishWithCompletionHandler:^{
        NSLog(@"Capture completed");
    }];
}

- (AVCaptureVideoPreviewLayer*)getPreviewLayer
{
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    int timestamp=[[NSDate date]timeIntervalSince1970];
//    videoPathfile = [NSString stringWithFormat:@"%@/%d.mov",documentsDirectory,timestamp];
//    DELEGATE.videopath=[NSString stringWithFormat:@"/%d.mov",timestamp];
    return _preview;
}

@end
