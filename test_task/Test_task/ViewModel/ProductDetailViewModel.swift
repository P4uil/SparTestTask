import Foundation

class ProductDetailViewModel: ObservableObject {
    @Published var product: Product
    @Published var count: Int = 1
    @Published var kgCount = 0.1
    init(product: Product){
        self.product = product
    }
    
}
