import Foundation
import SwiftUI
class ContentViewModel: ObservableObject {//Входные данные
    static let shared = ContentViewModel(); private init() { }
    var products: [Product] = [Product(id: "1",
                                       name: "Сыр ламбер 500/0 230г",
                                       oldPrice: 199.0,
                                       actualPrice: 90.90,
                                       rating: 4.1,
                                       img: UIImage(named: "1Item")!,
                                       offer: Product.Offer(offerName: "Удар по ценам",
                                                            color: UIColor(named: "punchPrices")!),
                                       isByKg: false),
                               Product(id: "2", name: "Энергетик", oldPrice: nil, actualPrice: 95699.90, rating: 5.0, feedbackCount: 14, country: nil, img: UIImage(named: "2Item")!, offer: nil, discount: 13, isByKg: false),
                               Product(id: "3", name: "Cалат", oldPrice: nil, actualPrice: 250.90, rating: 3.3, feedbackCount: 22, country: nil, img: UIImage(named: "3Item")!, offer: nil, discount: 5, isByKg: true),
                               Product(id: "4", name: "dorado", oldPrice: 300.0, actualPrice: 266.77, rating: 4.5, feedbackCount: 77, country: nil, img: UIImage(named: "4Item")!, offer: nil, discount: 25, isByKg: true),
                               Product(id: "5", name: "Roll", oldPrice: 500.25, actualPrice: 367.65, rating: 5.0, feedbackCount: 1, country: "Япония 🇯🇵", img: UIImage(named: "5Item")!, offer: Product.Offer(offerName: "Новинки", color: UIColor(named: "news")!), discount: nil, isByKg: false),
                               Product(id: "6", name: "sloboda oil", oldPrice: 2000.0, actualPrice: 1299.90, rating: 0.0, feedbackCount: nil, country: "France", img: UIImage(named: "6Item")!, offer: Product.Offer(offerName: "Удар по ценам", color: UIColor(named: "punchPrices")!), discount: 12, isByKg: false)]
    var products4List: [Product] = [Product(id: "1",
                                       name: "Липа",
                                       oldPrice: 20,
                                       actualPrice: 90.90,
                                       rating: 4.1,
                                       img: UIImage(named: "item1")!,
                                       offer: Product.Offer(offerName: "Удар по ценам",
                                                            color: UIColor(named: "punchPrices")!),
                                       isByKg: false),
                                    Product(id: "2", name: "Энергетик", oldPrice: 199.0, actualPrice: 95699.90, rating: 5.0, feedbackCount: 18, country: "Япония 🇯🇵", img: UIImage(named: "item2")!, offer: Product.Offer(offerName: "only today!", color: UIColor(named: "punchPrices")!), discount: 50, isByKg: false),
                               Product(id: "3", name: "Cалат", oldPrice: nil, actualPrice: 250.90, rating: 3.3, feedbackCount: 13, country: nil, img: UIImage(named: "3Item")!, offer: nil, discount: nil, isByKg: true),
                               Product(id: "4", name: "dorado", oldPrice: 300.0, actualPrice: 266.77, rating: 4.5, feedbackCount: 24, country: nil, img: UIImage(named: "4Item")!, offer: nil, discount: 25, isByKg: true),
                               Product(id: "5", name: "Roll", oldPrice: 500.25, actualPrice: 367.65, rating: 5.0, feedbackCount: 300, country: "Япония 🇯🇵", img: UIImage(named: "5Item")!, offer: Product.Offer(offerName: "Новинки", color: UIColor(named: "news")!), discount: nil, isByKg: false),
                               Product(id: "6", name: "sloboda oil", oldPrice: 2000.0, actualPrice: 1299.90, rating: 4.9, feedbackCount: 20, country: nil, img: UIImage(named: "6Item")!, offer: Product.Offer(offerName: "Удар по ценам", color: UIColor(named: "punchPrices")!), discount: 12, isByKg: true)]
}

