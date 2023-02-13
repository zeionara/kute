import Foundation
import Swifter


public extension HttpRequest {
    var json: [String: Any] {
        return try! JSONSerialization.jsonObject(with: Data(body), options: []) as! [String: Any]
    }
}
