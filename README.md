# WeakRef

`WeakRef` is a Swift utility that wraps a weak reference to an object.

It is designed to be used when you want to reference an object without preventing ARC (Automatic Reference Counting) from disposing of it when there are no strong references left to the object.

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/swiftarium/WeakRef.git", from: "1.0.0"),
]
```

## Usage

### Basic Usage

```swift
class MyClass {}

var inst: MyClass? = .init()

let weakRef = WeakRef(inst)
print(weakRef) // WeakRef(MyClass)

inst = nil // MyClass instance is deinited
print(weakRef) // WeakRef(nil)
```

## License

This library is released under the MIT license. See [LICENSE](/LICENSE) for details.
