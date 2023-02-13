
import UIKit

class CachedSpaceModel: NSDiscardableContent {
        
    // Our counter variable
    var accessCounter = true
    var structWrapper: StructWrapper<APODInstance>
    var avatar: UIImage? = nil
    
    init(wrapper: StructWrapper<APODInstance>, image: UIImage) {
        self.structWrapper = wrapper
        self.avatar = image
    }
    
    // MARK: - NSDiscardableContent
    func beginContentAccess() -> Bool {
        if avatar != nil {
            accessCounter = true
        } else {
            accessCounter = false
        }
        return accessCounter
    }
    
    func endContentAccess() {
        accessCounter = false
    }
    
    func discardContentIfPossible() {}
    
    func isContentDiscarded() -> Bool {
        return avatar == nil
    }
}
