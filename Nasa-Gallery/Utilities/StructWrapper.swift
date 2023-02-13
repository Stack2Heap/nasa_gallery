
import Foundation

class StructWrapper<T>: NSObject {
    let value: T
    init(_ _struct: T) {
        self.value = _struct
    }
}

