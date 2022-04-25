# GlimmerText

A package for SwiftUI that adds a modifier to the Text view. The modifier adds an animated glimmer that will repeatedly animate across the text.

This package is only compatable with macOS 12, iOS 15, tvOS 5, and watchOS 8.

Usage
-----

```swift
struct TestView: View {

  var body: some View {
      Text("Hello World!")
      .font(.title)
      .glimmerText(colour: .white)
      .foregroundColor(.red)
      .padding()
      .background(Color.indigo.cornerRadius(10))
  }
}
```

Ensure that you apply all the modifier of the Text structure modifiers before the glimmerText modifier

https://user-images.githubusercontent.com/5818573/123664747-89afe280-d82f-11eb-831b-44bc16571d5a.mp4




