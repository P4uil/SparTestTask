import Foundation

struct Position: Identifiable {
    var id: String
    var product: Product
    var count: Double
    var cost: Double {
        return product.actualPrice * self.count
    }
    
    var representation: [String: Any]{
        var repres = [String: Any]()
        repres["id"] = id
        repres["count"] = count
        repres["name"] = product.name
        repres["price"] = product.actualPrice
        repres["cost"] = self.cost
        return repres
    }
    
    internal init(id: String, product: Product, count: Double) {
        self.id = id
        self.product = product
        self.count = count
    }
}
