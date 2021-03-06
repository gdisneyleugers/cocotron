/* Copyright (c) 2008 Johannes Fortmann
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. */

#import <AppKit/CairoCacheImage.h>
#import <Foundation/NSString.h>

@implementation CairoCacheImage
-(id)initWithSurface:(cairo_surface_t*)surf
{
   if(self=[super init])
   {
      _surface=surf;
      cairo_surface_reference(_surface);
   }
   return self;
}

-(void)dealloc {
   cairo_surface_destroy(_surface);
   [super dealloc];  
}

-(float)width
{
   return _size.width;
}

-(float)height
{
   return _size.height;
}

-(cairo_surface_t*)_cairoSurface
{
   return _surface;  
}

-(id)description
{
   return [NSString stringWithFormat:@"%@: %p, (%fx%f)", [super description], _surface, _size.width, _size.height];
}

@synthesize size=_size;
@end
