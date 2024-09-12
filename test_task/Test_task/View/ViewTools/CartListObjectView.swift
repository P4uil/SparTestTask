import SwiftUI

struct CartListObjectView: View { //no comment
    var position: Position
    var body: some View {
        VStack{
            HStack{
                Text(" \(position.product.name)")
                    .foregroundStyle(Color.white)
                    .lineLimit(1)
                Spacer()
                if position.count.truncatingRemainder(dividingBy: 1) == 0{
                    Text(String(format: "%.0f", position.count) + " шт")
                        .foregroundStyle(Color.white)
                } else {
                    Text("\(position.count.formatted()) кг")
                        .foregroundStyle(Color.white)
                }

            }.padding(.horizontal)
            Text(String(describing: position.cost.formatted()) + "₽ ")
                .foregroundStyle(Color.white)
            
        }
        .background(Color("mainGreen"))
            .cornerRadius(6)
        
    }
}

#Preview {
    CartListObjectView(position: Position(id: "1",
                                          product: Product(id: "1",
                                                                           name: "липаsdksdjnsdj vjksdbgks",
                                                                           oldPrice: nil,
                                                                           actualPrice: 9055.90,
                                                                           rating: 4.1,
                                                                           feedbackCount: nil,
                                                                           country: nil,
                                                                           img: UIImage(named: "item1")!,
                                                                           offer: nil,
                                                                           discount: nil,
                                                                           isByKg: true),
                                          count: 0.2))
}
