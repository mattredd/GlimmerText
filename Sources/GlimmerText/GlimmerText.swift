import SwiftUI

@available(macOS 12, iOS 15, *)
private
struct GlimmerView: View {
    @Environment(\.layoutDirection) var layoutDirection
    @State private var startTime = Date()
    let textView: Text
    let glimmerSize: Double
    let duration: Double
    let colour: Color
    

    init(textView: Text, colour: Color, glimmerSize: Double, duration: Double) {
        self.textView = textView
        self.colour = colour
        self.glimmerSize = glimmerSize
        self.duration = duration
    }
    
    var body: some View {
        TimelineView(.animation) { context in
            Canvas { graphicsContext, size in
                let progress = context.date.timeIntervalSince(startTime).truncatingRemainder(dividingBy: duration) / duration
                let leadingProgress = (progress * (1 + glimmerSize)) - glimmerSize
                let glimmerProgress = leadingProgress + glimmerSize / 2
                let trailingProgress = leadingProgress + glimmerSize
                var resolvedText = graphicsContext.resolve(textView)
                let colours = [Gradient.Stop(color: .clear, location: leadingProgress), Gradient.Stop(color: colour, location: glimmerProgress), Gradient.Stop(color: .clear, location: trailingProgress)]
                resolvedText.shading = .linearGradient(Gradient(stops: colours), startPoint: layoutDirection == .leftToRight ? .zero : CGPoint(x: size.width, y: 0), endPoint: layoutDirection == .leftToRight ? CGPoint(x: size.width, y: 0) : .zero)
                graphicsContext.draw(resolvedText, in: CGRect(x: 1, y: 1, width: size.width, height: size.height).insetBy(dx: -1, dy: -1))
            }
        }
    }
}

@available(macOS 12, iOS 15, *)
public extension Text {
    
    /// Adds an animated glimmer to *self* which repeats continuously from the leading edge to the trailing edge
    /// - Parameters:
    ///   - glimmerColour: The colour of the glimmer.
    ///   - glimmerSize: The width of the glimmer as a fraction of the width of self (clamped between 0.1 and 0.6).
    ///   - duration: The duration of the animation.
    ///   - Returns: A view that animates a glimmer over the text.
    func glimmerText(glimmerColour: Color, @ClampedValue(clampedRange: 0.1...0.6) glimmerSize: Double = 0.4, duration: Double = 2) -> some View {
        self.overlay(GlimmerView(textView: self, colour: glimmerColour, glimmerSize: glimmerSize, duration: duration))
    }
}
