import Foundation

public struct APODInstance: Codable, Hashable {
    var copyright: String?
    var date: String
    var explanation: String
    var hdurl: String?
    var media_type: String
    var service_version: String
    var title: String
    var url: String
}

extension APODInstance {

    static var loading: APODInstance {
        .init(date: "N/A",
              explanation: "Connecting to NASA servers\nto load Image Of the Day...",
              hdurl: "nasa-logo.svg",
              media_type: "image",
              service_version: "v1",
              title: "Loading data...",
              url: "nasa-logo.svg")
    }
}
