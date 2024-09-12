import SwiftUI

struct CartView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = CartViewModel.shared
    var body: some View {
        Image(systemName: "cart.circle")
            .resizable()
            .foregroundStyle(Color("mainGreen"))
            .frame(width: 50, height: 50)
            .padding()
            .padding(.bottom, 20)
        HStack(alignment: .center) {
            Button { //Кнопка назад
                dismiss()
            } label: {
                Text("Back")
                    .padding(6)
                    .padding(.horizontal, 10)
                    .foregroundStyle(Color.white)
                    .background(Color("mainGreen"))
                    .cornerRadius(10)
                    
            }
            Spacer()
            Button{ //Очистить корзину
                viewModel.clearCart()
            } label: {
                Text("Очистить")
                    .padding(6)
                    .padding(.horizontal, 10)
                    .foregroundStyle(Color.white)
                    .background(Color("mainGreen"))
                    .cornerRadius(10)
            }
        }.padding(.horizontal, 16)
        
        List { //Список позиций
            ForEach(viewModel.positions, id: \.id){ position in
                CartListObjectView(position: position)
                    .contextMenu{ //Контекстное меню для удаления позиции из корзины
                        Button{
                            if let index = viewModel.findPosition(position.product.name){
                                viewModel.removeThatMf(index)
                            }
                        } label: {
                            Text("Delete")
                                .foregroundStyle(Color.red)
                        }
                    }
            }
        }.listStyle(.plain)
        
        HStack{
            Text("Итого:")
                .font(.title)
                .foregroundStyle(Color.white)
            Spacer()
            Text(String(describing: viewModel.cost.formatted()) + "₽")
                .font(.title2)
                .foregroundStyle(Color.white)
        }.padding()
            .clipShape(.rect(topLeadingRadius: 12, topTrailingRadius: 12))
            .background(Color("mainGreen"))
            
            
            
    }
}

#Preview {
    CartView()
}
