/* Copyright (c) 2006-2007 Christopher J. W. Lloyd

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. */

#import <AppKit/NSImageCell.h>
#import <AppKit/NSImage.h>
#import <AppKit/NSGraphics.h>
#import <ApplicationServices/ApplicationServices.h>
#import <AppKit/NSGraphicsContext.h>
#import <Foundation/NSKeyedArchiver.h> 

@implementation NSImageCell

-(void)encodeWithCoder:(NSCoder *)coder 
{ 
   [super encodeWithCoder:coder]; 
   [coder encodeBool:_animates forKey:@"NSAnimates"]; 
   [coder encodeInt:_imageAlignment forKey:@"NSAlign"]; 
   [coder encodeInt:_imageScaling forKey:@"NSScale"]; 
   [coder encodeInt:_frameStyle forKey:@"NSStyle"]; 

} 

-(id)initWithCoder:(NSCoder *)coder 
{ 
   [super initWithCoder:coder]; 
   if([coder allowsKeyedCoding]) 
   { 
      NSKeyedUnarchiver *keyed=(NSKeyedUnarchiver *)coder; 
      _animates       = [keyed decodeBoolForKey:@"NSAnimates"]; 
      _imageAlignment = [keyed decodeIntForKey:@"NSAlign"]; 
      _imageScaling   = [keyed decodeIntForKey:@"NSScale"]; 
      _frameStyle     = [keyed decodeIntForKey:@"NSStyle"]; 
   } 
   else 
      [NSException raise:NSInvalidArgumentException format:@"%@ can not initWithCoder:%@",isa,[coder class]]; 
   return self; 

} 

-(NSImage *)_imageValue {
   id result=[self image];
   
   if(result!=nil)
    return result;

   result=[self objectValue];
   if(![result isKindOfClass:[NSImage class]])
    result=nil;
    
   return result;
}

-(NSImageAlignment)imageAlignment {
    return _imageAlignment;
}

-(NSImageFrameStyle)imageFrameStyle {
    return _frameStyle;
}

-(NSImageScaling)imageScaling {
    return _imageScaling;
}

-(void)setImageAlignment:(NSImageAlignment)alignment {
    _imageAlignment = alignment;
}

-(void)setImageFrameStyle:(NSImageFrameStyle)frameStyle {
    _frameStyle = frameStyle;
}

-(void)setImageScaling:(NSImageScaling)imageScaling {
    _imageScaling = imageScaling;
}

-(NSSize)_scaledImageSizeInFrame:(NSRect)frame {
   NSSize imageSize=[[self _imageValue] size];
      
   switch(_imageScaling){
    case NSScaleProportionally:{
      float xscale=frame.size.width/imageSize.width;
      float yscale=frame.size.height/imageSize.height;
      float scale=MIN(xscale,yscale);
      
      imageSize.width*=scale;
      imageSize.height*=scale;
      
      return imageSize;
     }
     
    case NSScaleToFit:
     return frame.size;
    
    default:
    case NSScaleNone:
     return imageSize;
   }
   
}

-(NSRect)_scaledAndAlignedImageFrame:(NSRect)frame {
    NSSize imageSize = [self _scaledImageSizeInFrame:frame];
        
    switch (_imageAlignment) {
        default:
        case NSImageAlignCenter:
            frame.origin.x += (frame.size.width/2)-(imageSize.width/2);
            frame.origin.y += (frame.size.height/2)-(imageSize.height/2);
            break;
            
        case NSImageAlignTop:
            frame.origin.x += (frame.size.width/2)-(imageSize.width/2);
            frame.origin.y += frame.size.height-imageSize.height;
            break;

        case NSImageAlignTopLeft:
            frame.origin.y += frame.size.height-imageSize.height;
            break;

        case NSImageAlignTopRight:
            frame.origin.x += frame.size.width-imageSize.width;
            frame.origin.y += frame.size.height-imageSize.height;
            break;

        case NSImageAlignLeft:
            frame.origin.y += (frame.size.height/2)-(imageSize.height/2);
            break;

        case NSImageAlignBottom:
            frame.origin.x += (frame.size.width/2)-(imageSize.width/2);
            break;
            
        case NSImageAlignBottomLeft:
            break;

        case NSImageAlignBottomRight:
            frame.origin.x += frame.size.width-imageSize.width;
            break;

        case NSImageAlignRight:
            frame.origin.x += frame.size.width-imageSize.width;
            frame.origin.y += (frame.size.height/2)-(imageSize.height/2);
            break;
    }
      
   frame.size=imageSize;
   return frame;
}

-(void)drawInteriorWithFrame:(NSRect)frame inView:(NSView *)control {
    if([self _imageValue]!=nil) {
		
		CGContextRef ctx=[[NSGraphicsContext currentContext] graphicsPort];
		CGContextSaveGState(ctx);
		CGContextClipToRect(ctx,frame);

        frame=[self _scaledAndAlignedImageFrame:frame];
        [[self _imageValue] drawInRect:frame fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
        
		CGContextRestoreGState(ctx);
    }
}

-(void)drawWithFrame:(NSRect)frame inView:(NSView *)control {
   if([self isBordered]){
    NSDrawButton(frame,frame);
    frame=NSInsetRect(frame,2,2);
   }

   [self drawInteriorWithFrame:frame inView:control];
}

@end
