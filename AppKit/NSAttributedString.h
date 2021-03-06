/* Copyright (c) 2006-2007 Christopher J. W. Lloyd

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. */

#import <Foundation/Foundation.h>
#import <AppKit/AppKitExport.h>
#import <AppKit/NSStringDrawing.h>

@class NSFont,NSColor,NSParagraphStyle,NSTextAttachment,NSFileWrapper,NSTextList,NSTextBlock,NSTextTable;

APPKIT_EXPORT NSString *NSFontAttributeName; 
APPKIT_EXPORT NSString *NSParagraphStyleAttributeName;
APPKIT_EXPORT NSString *NSForegroundColorAttributeName;
APPKIT_EXPORT NSString *NSBackgroundColorAttributeName;
APPKIT_EXPORT NSString *NSUnderlineStyleAttributeName;
APPKIT_EXPORT NSString *NSUnderlineColorAttributeName;
APPKIT_EXPORT NSString *NSAttachmentAttributeName;
APPKIT_EXPORT NSString *NSKernAttributeName;
APPKIT_EXPORT NSString *NSLigatureAttributeName;
APPKIT_EXPORT NSString *NSStrikethroughStyleAttributeName;
APPKIT_EXPORT NSString *NSStrikethroughColorAttributeName;
APPKIT_EXPORT NSString *NSObliquenessAttributeName;
APPKIT_EXPORT NSString *NSStrokeWidthAttributeName;
APPKIT_EXPORT NSString *NSStrokeColorAttributeName;
APPKIT_EXPORT NSString *NSBaselineOffsetAttributeName;
APPKIT_EXPORT NSString *NSSuperscriptAttributeName;
APPKIT_EXPORT NSString *NSLinkAttributeName;
APPKIT_EXPORT NSString *NSShadowAttributeName;
APPKIT_EXPORT NSString *NSExpansionAttributeName;
APPKIT_EXPORT NSString *NSCursorAttributeName;
APPKIT_EXPORT NSString *NSToolTipAttributeName;
APPKIT_EXPORT NSString *NSBackgroundColorDocumentAttribute;

enum {
   NSUnderlineStyleNone,
   NSUnderlineStyleSingle,
   NSUnderlineStyleThick,
   NSUnderlineStyleDouble,
};

enum {
   NSUnderlinePatternSolid=0x000,
   NSUnderlinePatternDot=0x100,
   NSUnderlinePatternDash=0x200,
   NSUnderlinePatternDashDot=0x300,
   NSUnderlinePatternDashDotDot=0x400,
};

@interface NSAttributedString(NSAttributedString_AppKit)

+(NSArray *)textFileTypes;
+(NSArray *)textPasteboardTypes;

+(NSArray *)textUnfilteredFileTypes;
+(NSArray *)textUnfilteredPasteboardTypes;

+(NSAttributedString *)attributedStringWithAttachment:(NSTextAttachment *)attachment;

-initWithData:(NSData *)data options:(NSDictionary *)options documentAttributes:(NSDictionary **)attributes error:(NSError **)error;
-initWithDocFormat:(NSData *)werd documentAttributes:(NSDictionary **)attributes;

-initWithHTML:(NSData *)html baseURL:(NSURL *)url documentAttributes:(NSDictionary **)attributes;
-initWithHTML:(NSData *)html documentAttributes:(NSDictionary **)attributes;
-initWithHTML:(NSData *)html options:(NSDictionary *)options documentAttributes:(NSDictionary **)attributes;
-initWithPath:(NSString *)path documentAttributes:(NSDictionary **)attributes;

-initWithRTF:(NSData *)rtf documentAttributes:(NSDictionary **)attributes;

-initWithRTFD:(NSData *)rtfd documentAttributes:(NSDictionary **)attributes;
-initWithRTFDFileWrapper:(NSFileWrapper *)wrapper documentAttributes:(NSDictionary **)attributes;

-initWithURL:(NSURL *)url documentAttributes:(NSDictionary **)attributes;
-initWithURL:(NSURL *)url options:(NSDictionary *)options documentAttributes:(NSDictionary **)attributes error:(NSError **)error;

-(int)itemNumberInTextList:(NSTextList *)list atIndex:(unsigned)index;
-(unsigned)lineBreakBeforeIndex:(unsigned)index withinRange:(NSRange)range;
-(unsigned)lineBreakByHyphenatingBeforeIndex:(unsigned)index withinRange:(NSRange)range;
-(NSRange)rangeOfTextBlock:(NSTextBlock *)block atIndex:(unsigned)index;

-(NSRange)rangeOfTextList:(NSTextList *)list atIndex:(unsigned)index;
-(NSRange)rangeOfTextTable:(NSTextTable *)table atIndex:(unsigned)index;

-(NSFileWrapper *)RTFDFileWrapperFromRange:(NSRange)range documentAttributes:(NSDictionary *)attributes;

-(NSData *)RTFDFromRange:(NSRange)range documentAttributes:(NSDictionary *)attributes;

-(NSData *)RTFFromRange:(NSRange)range documentAttributes:(NSDictionary *)attributes;

-(NSDictionary *)rulerAttributesInRange:(NSRange)range;

-(NSRange)doubleClickAtIndex:(unsigned)index;
-(unsigned)nextWordFromIndex:(unsigned)index forward:(BOOL)forward;

-(NSRect)boundingRectWithSize:(NSSize)size options:(NSStringDrawingOptions)options;

-(BOOL)containsAttachments;

-(NSData *)dataFromRange:(NSRange)range documentAttributes:(NSDictionary *)attributes error:(NSError **)error;

-(NSData *)docFormatFromRange:(NSRange)range documentAttributes:(NSDictionary *)attributes;
-(NSFileWrapper *)fileWrapperFromRange:(NSRange)range documentAttributes:(NSDictionary *)attributes error:(NSError **)error;
-(NSDictionary *)fontAttributesInRange:(NSRange)range;

@end

// private
NSFont *NSFontAttributeInDictionary(NSDictionary *dictionary);
NSColor *NSForegroundColorAttributeInDictionary(NSDictionary *dictionary);
NSColor *NSBackgroundColorAttributeInDictionary(NSDictionary *dictionary);
NSParagraphStyle *NSParagraphStyleAttributeInDictionary(NSDictionary *dictionary);

#import <AppKit/NSMutableAttributedString.h>
