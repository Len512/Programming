//
//  CustomView.m
//  CustomViews
//

#import "CustomView.h"

@implementation CustomView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Create an object which represents the path we will be drawing
    // Creates a rectangular path and uses the view's bounds to create
    // 1. a rectangle that fills the entire view
//    NSBezierPath *path = [NSBezierPath bezierPathWithRect:self.bounds];
//    [[NSColor greenColor] setFill];
//    [path fill];
    
    // 2. a rounded rect with strokes
//    NSRect pathRect = NSInsetRect(self.bounds, 1, 1);
//    NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:pathRect xRadius:10 yRadius:10];
//    [[NSColor greenColor] setFill];
//    [[NSColor blackColor] setStroke];
//    [path fill];
//    [path stroke];

    // 3. a circle that contains a star-shaped hole in it
//    NSBezierPath *bezierPath = [NSBezierPath bezierPath];
//    // Draw the star
//    [bezierPath moveToPoint:NSMakePoint(42.5, 77.5)];
//    [bezierPath lineToPoint:NSMakePoint(30.51, 60)];
//    [bezierPath lineToPoint: NSMakePoint(10.16, 54.01)];
//    [bezierPath lineToPoint: NSMakePoint(23.1, 37.2)];
//    [bezierPath lineToPoint: NSMakePoint(22.52, 15.99)];
//    [bezierPath lineToPoint: NSMakePoint(42.5, 23.1)];
//    [bezierPath lineToPoint: NSMakePoint(62.48, 15.99)];
//    [bezierPath lineToPoint: NSMakePoint(61.9, 37.2)];
//    [bezierPath lineToPoint: NSMakePoint(74.84, 54.01)];
//    [bezierPath lineToPoint: NSMakePoint(54, 60)];
//    [bezierPath lineToPoint: NSMakePoint(42.5, 77.5)];
//    [bezierPath closePath];
//
//    // Draw the circle outside it
//    [bezierPath moveToPoint:NSMakePoint(70.64, 71.64)];
//    [bezierPath curveToPoint: NSMakePoint(70.64, 14.36)
//               controlPoint1: NSMakePoint(86.45, 55.82)
//               controlPoint2: NSMakePoint(86.45, 30.18)];
//    [bezierPath curveToPoint: NSMakePoint(13.36, 14.36)
//               controlPoint1: NSMakePoint(54.82, -1.45)
//               controlPoint2: NSMakePoint(29.18, -1.45)];
//    [bezierPath curveToPoint: NSMakePoint(13.36, 71.64)
//               controlPoint1: NSMakePoint(-2.45, 30.18)
//               controlPoint2: NSMakePoint(-2.45, 55.82)];
//    [bezierPath curveToPoint: NSMakePoint(70.64, 71.64)
//               controlPoint1: NSMakePoint(29.18, 87.45)
//               controlPoint2: NSMakePoint(54.82, 87.45)];
//    [bezierPath closePath];
//    
//    // Fill the path
//    [[NSColor darkGrayColor] setFill];
//    [bezierPath fill];
    
    // 4. a rectangle with a shadow
//    // Shadow declarations
//    NSShadow *shadow = [[NSShadow alloc] init];
//    [shadow setShadowColor:[NSColor blackColor]];
//    [shadow setShadowOffset:NSMakeSize(3, -3)];
//    [shadow setShadowBlurRadius: 5];
//    // Rectangle drawing
//    NSRect pathRect = NSInsetRect(self.bounds, 20, 20);
//    NSBezierPath *path = [NSBezierPath bezierPathWithRect: pathRect];
//    [NSGraphicsContext saveGraphicsState];
//    [shadow set];
//    [[NSColor darkGrayColor] setFill];
//    [path fill];
//    [NSGraphicsContext restoreGraphicsState];

    // 5. a rounded rectangle with a gradient
//    // Color declarations
//    NSColor *gradientStartColor = [NSColor colorWithCalibratedRed:0.0 green:0.2 blue:0.7 alpha:1];
//    NSColor *gradientEndColor = [NSColor colorWithCalibratedRed:0.3 green:0.4 blue:0.8 alpha:1];
//    // Gradient declarations
//    NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:gradientStartColor endingColor:gradientEndColor];
//    // Rounded rectangle drawing
//    NSRect pathRect = NSInsetRect(self.bounds, 20, 20);
//    NSBezierPath *roundedRectanglePath = [NSBezierPath bezierPathWithRoundedRect:pathRect xRadius:4 yRadius:4];
//    [gradient drawInBezierPath:roundedRectanglePath angle:90];
    
    // 6. a rotated rounded rectangle
    NSRect pathRect = NSInsetRect(self.bounds, 10, 10);
    // Create a transform that rotates the drawing by a small amount around the original point
    CGAffineTransform rotationTransform = CGAffineTransformMakeRotation(M_PI / 8.0);
    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
    NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:pathRect xRadius:10 yRadius:10];
    // Save the context before we start drawing
    [NSGraphicsContext saveGraphicsState];
    // Rotate
    CGContextConcatCTM(context, rotationTransform);
    [[NSColor greenColor] setFill];
    [[NSColor blackColor] setStroke];
    [path fill];
    [path stroke];
    // Restore the context
    [NSGraphicsContext restoreGraphicsState];
}

@end
