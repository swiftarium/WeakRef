# WeakRef

The `WeakRef` in Swift provides a mechanism to hold a weak reference to objects, particularly useful when you want to reference an object without preventing the Automatic Reference Counting (ARC) system from disposing of it.

## Features

- The primary purpose of the WeakRef structure is to allow weak referencing to an object of type T, where T is any class type.
- Easily check if the weak reference holds a valid object or if it has been nilled out with the `isEmpty` and `isValid` computed properties.
- `Equatable` conformance allows weak references to be compared for equality with other weak references or directly with any object. `Hashable` conformance ensures you can store WeakRef in sets or use them as dictionary keys.

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/swiftarium/WeakRef.git", from: "1.0.0"),
]
```

```swift
targets: [
    .target(name: "YourTarget", dependencies: ["WeakRef"]),
]
```

## Usage

### Basic Usage

```swift
class MyClass {}

var object: MyClass? = .init()

let weakRef = WeakRef(object)
print(weakRef) // WeakRef(MyClass)

object = nil // MyClass instance is deinited
print(weakRef) // WeakRef(nil)
```

## License

This library is released under the MIT license. See [LICENSE](/LICENSE) for details.
