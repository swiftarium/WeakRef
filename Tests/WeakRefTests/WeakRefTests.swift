@testable import WeakRef
import XCTest

final class WeakRefTests: XCTestCase {
    class TestClass {
        var value: String

        init(value: String = "") {
            self.value = value
        }
    }

    func testWeakRefInitialization() {
        let instance = TestClass(value: "Test")
        let ref = WeakRef(instance)

        XCTAssertNotNil(ref.value)
        XCTAssertEqual(ref.value?.value, "Test")
    }

    func testWeakRefNilAfterDeinit() {
        var instance: TestClass? = TestClass()
        let ref = WeakRef(instance)

        XCTAssertFalse(ref.isEmpty)
        instance = nil
        XCTAssertTrue(ref.isEmpty)
    }

    func testWeakRefHasValueProperty() {
        var instance: TestClass? = TestClass()
        let ref = WeakRef(instance)

        XCTAssertTrue(ref.hasValue)
        instance = nil
        XCTAssertFalse(ref.hasValue)
    }

    func testWeakRefSetMethod() {
        var instance1: TestClass? = TestClass(value: "Test")
        var ref = WeakRef(instance1)

        var instance2: TestClass? = TestClass(value: "New Test")
        ref.value = instance2

        instance1 = nil
        XCTAssertEqual(ref.value?.value, "New Test")

        instance2 = nil
        XCTAssertNil(ref.value)
    }

    func testWeakRefMapMethod() {
        let instance = TestClass(value: "Test")
        let ref = WeakRef(instance)

        let mappedValue = ref.map { $0.value }
        XCTAssertEqual(mappedValue, "Test")
    }

    func testWeakRefEquality() {
        let instance1 = TestClass(value: "Test1")
        let instance2 = TestClass(value: "Test2")

        let ref1 = WeakRef(instance1)
        let ref2 = WeakRef(instance2)

        XCTAssertNotEqual(ref1, ref2)
        XCTAssertEqual(ref1, ref1)
    }

    func testWeakRefDescription() {
        var instance: TestClass? = TestClass(value: "Test")
        let ref = WeakRef(instance)

        XCTAssertEqual(ref.description, "WeakRef(\(instance!))")
        
        instance = nil
        XCTAssertEqual(ref.description, "WeakRef(nil)")
    }
}
