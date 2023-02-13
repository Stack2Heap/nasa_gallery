import Foundation
import SwiftUI

class AppPrefs: ObservableObject {
    var requestLimit: String = "?"
    var requestRemaining: String = "?"
}

struct AppConstants {
    static let blueUIColor              = UIColor(red: 11 / 255, green: 61 / 255, blue: 145 / 255, alpha: 1)
    static let blueColor                = Color.init(uiColor: blueUIColor)

    static let defaultNASALogo          = "nasa-logo"
    static let defaultAPIKey            = "oXdjczVZNQGp8iVhYFHGZ06E0c122AuyTk6qlKRx"
    static let defaultNASAUrl           = "https://api.nasa.gov/planetary/apod"
}
