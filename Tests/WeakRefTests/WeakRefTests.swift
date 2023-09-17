@testable import WeakRef
import XCTest

final class WeakRefTests: XCTestCase {
    class TestClass {
        var value: String

        init(value: String = "") {
            self.value = value
        }
    }

    func testInitialization() {
        let instance = TestClass(value: "Test")
        let ref = WeakRef(instance)

        XCTAssertNotNil(ref.value)
        XCTAssertEqual(ref.value?.value, "Test")
    }

    func testNilAfterDeinit() {
        var instance: TestClass? = TestClass()
        let ref = WeakRef(instance)

        XCTAssertFalse(ref.isEmpty)
        instance = nil
        XCTAssertTrue(ref.isEmpty)
    }

    func testHasValueProperty() {
        var instance: TestClass? = TestClass()
        let ref = WeakRef(instance)

        XCTAssertTrue(ref.isValid)
        instance = nil
        XCTAssertFalse(ref.isValid)
    }

    func testSetMethod() {
        var instance1: TestClass? = TestClass(value: "Test")
        var ref = WeakRef(instance1)

        var instance2: TestClass? = TestClass(value: "New Test")
        ref.value = instance2

        instance1 = nil
        XCTAssertEqual(ref.value?.value, "New Test")

        instance2 = nil
        XCTAssertNil(ref.value)
    }

    func testMapMethod() {
        let instance = TestClass(value: "Test")
        let ref = WeakRef(instance)

        let mappedValue = ref.map { $0.value }
        XCTAssertEqual(mappedValue, "Test")
    }

    func testEquality() {
        let instance1 = TestClass()
        let instance2 = TestClass()

        let weakRef1 = WeakRef(instance1)
        let weakRef2 = WeakRef(instance1)
        let weakRef3 = WeakRef(instance2)

        XCTAssertEqual(weakRef1, weakRef2)
        XCTAssertNotEqual(weakRef1, weakRef3)
    }

    func testDescription() {
        var instance: TestClass? = TestClass(value: "Test")
        let ref = WeakRef(instance)

        XCTAssertEqual(ref.description, "WeakRef(\(instance!))")

        instance = nil
        XCTAssertEqual(ref.description, "WeakRef(nil)")
    }

    func testHashable() {
        var instance1:TestClass?  = TestClass()

        let weakRef1 = WeakRef(instance1)
        let weakRef2 = WeakRef(instance1)

        let initialHash = weakRef1.hashValue
        instance1 = nil
        XCTAssertNotEqual(initialHash, weakRef1.hashValue)
        XCTAssertEqual(weakRef1.hashValue, weakRef2.hashValue)
    }
    
    func testHashableWithSet() {
        var instance1: TestClass? = TestClass()
        var instance2: TestClass? = TestClass()

        let weakRef1 = WeakRef(instance1)
        var weakRef2 = WeakRef(instance1)
        let weakRef3 = WeakRef(instance2)
        let weakRef4 = WeakRef(instance2)

        var set = Set<WeakRef<TestClass>>()
        set.insert(weakRef1)
        XCTAssertTrue(set.contains(weakRef2))
        weakRef2.value = nil
        XCTAssertFalse(set.contains(weakRef2))

        set.insert(weakRef3)
        XCTAssertTrue(set.contains(weakRef4))
        instance2 = nil
        XCTAssertFalse(set.contains(weakRef4))
        instance1 = nil

        XCTAssertTrue(set.allSatisfy({ $0.isEmpty }))
    }
}
