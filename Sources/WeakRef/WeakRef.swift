/// Represents a weak reference to an object of type `T`.
/// It is useful when you want to reference an object, but don't want that reference to prevent ARC from disposing of the referenced object.
public struct WeakRef<T: AnyObject> {
    /// The weakly held reference to the object.
    public weak var value: T?

    /// A boolean value that indicates whether the weak reference is nil or not.
    public var isEmpty: Bool { value == nil }

    /// A boolean value that indicates whether the weak reference has a value.
    public var hasValue: Bool { value != nil }

    /// Initializes a new weak reference with the provided value.
    /// - Parameter value: The object to be weakly referenced.
    public init(_ value: T?) {
        self.value = value
    }

    /// Transforms the weak reference using a provided function.
    /// - Parameter transform: The function that transforms the referenced object.
    /// - Returns: The transformed value or nil if the weak reference is nil.
    public func map<U>(_ transform: (T) throws -> U) rethrows -> U? {
        try value.map(transform)
    }
}

extension WeakRef: Equatable {
    public static func == (lhs: WeakRef<T>, rhs: WeakRef<T>) -> Bool {
        lhs.value === rhs.value
    }

    public static func == (lhs: WeakRef<T>, rhs: AnyObject) -> Bool {
        lhs.value === rhs
    }
}

extension WeakRef: CustomStringConvertible {
    public var description: String { debugDescription }
}

extension WeakRef: CustomDebugStringConvertible {
    public var debugDescription: String {
        if let value {
            var result = "WeakRef("
            debugPrint(value, terminator: "", to: &result)
            result += ")"
            return result
        } else {
            return "WeakRef(nil)"
        }
    }
}
