import SwiftUI
import Foundation
struct Product: Identifiable {
    var id: String
    var name: String
    var oldPrice: Double?
    var actualPrice: Double
    var rating: Double
    var feedbackCount: Int?
    var country: String?
    var img: UIImage
    var offer: Offer?
    struct Offer {
        var offerName: String
        var color: UIColor
    }
    var discount: Int?
    var isByKg: Bool
}
