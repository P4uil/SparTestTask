import SwiftUI

struct ProductHorizontalView: View {
    @State private var isHeartPushed = false
    @State private var isCartButtonClicked = false
    @State private var selectedSegment = 0
    @State var isChangePickerView = false
    @StateObject var viewModel: ProductDetailViewModel
    var body: some View {
        VStack(spacing: 0){
            //Идентичная логика с ProductVerticalView
            HStack{
                ZStack(alignment:.topLeading){
                    Image(uiImage: viewModel.product.img)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 144, height: 144)
                    if viewModel.product.offer != nil{
                        Text(String.init(describing: viewModel.product.offer!.offerName))
                            .font(.system(size: 10))
                            .padding(.horizontal,10)
                            .padding(.vertical, 3)
                            .foregroundColor(.white)
                            .background(Color(viewModel.product.offer!.color))
                            .clipShape(.rect(topLeadingRadius: 6, bottomTrailingRadius: 6, topTrailingRadius: 6))
                    }
                    if viewModel.product.discount != nil{
                        VStack {
                            Spacer()
                            HStack{
                                Spacer()
                                Text("\(viewModel.product.discount!)" + "%")
                                    .font(.system(size: 16))
                                    .bold()
                                    .foregroundColor(Color("saleRed"))
                            }
                            
                        }
                    }

                }.frame(width: 144, height: 144)
                .padding(.leading, 16)
                
                
                VStack(alignment: .leading){
                    HStack{
                        VStack(alignment: .leading){
                            HStack(spacing: 4){
                                Image(uiImage: UIImage(named: "Star")!)
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                Text(String.init(describing: viewModel.product.rating))
                                    .font(.system(size: 12))
                                Image(uiImage: UIImage(named: "dividerVer")!)
                                    .resizable()
                                
                                    .frame(width: 1, height: 16)
                                
                                Text((viewModel.product.feedbackCount != nil ? String.init(describing: viewModel.product.feedbackCount!) : String.init(describing:0)) + " отзывов")
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color("country"))
                            }.frame(height: 20)
                            
                            Text(String.init(describing: viewModel.product.name))
                                .font(.system(size: 12))
                                .foregroundStyle(Color("grayName"))
                                .frame(height: 14)
                            if viewModel.product.country != nil{
                                Text(viewModel.product.country != nil ? String.init(describing: viewModel.product.country!) : "")
                                    .font(.system(size: 12))
                                    .multilineTextAlignment(.leading)
                                    .foregroundStyle(Color("country"))
                                    .frame(height: 14)
                            }

                        }
                        Spacer()
                        VStack {
                            Button {
                                print("cheque")
                            } label: {
                                Image(uiImage: UIImage(named:  "cheque")!)
                                    .resizable()
                                    .frame(width: 14, height: 13.7)
                                    
                            }.buttonStyle(BorderlessButtonStyle())
                                .frame(width: 32, height: 32)
                            Button {
                                withAnimation {
                                    isHeartPushed.toggle()
                                }
                                
                            } label: {
                                Image(uiImage: UIImage(named: isHeartPushed == false ? "heartMy" : "heartMyFill")!)
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                    
                            }.buttonStyle(BorderlessButtonStyle())
                                .frame(width: 32, height: 32)
                                

                        }
                            .frame(width: 32, height: 64)
                            .background(Color("fiftyWhite"))
                            .cornerRadius(8)
                        
                    }
                    if !isCartButtonClicked{
                        Spacer()
                        HStack{
                            VStack(alignment: .leading, spacing:0) {
                                HStack(spacing: 0) {
                                    Text(String.init(describing: floor(viewModel.product.actualPrice).formatted()))
                                        .font(.system(size: 20))
                                        .bold()
                                    
                                    Text(String.init(describing: ((viewModel.product.actualPrice - Double(Int(viewModel.product.actualPrice)))*100).formatted()))
                                        .font(.system(size: 15))
                                        .bold()
                                        .frame(width: 20, height: 22, alignment: .topTrailing)
                                    
                                    
                                    Image(uiImage: UIImage(named: "rubKg")!)
                                        .frame(width: 20, height: 20)
                                }.frame(height: 22)
                                if viewModel.product.oldPrice != nil{
                                    Text(String.init(describing: viewModel.product.oldPrice!))
                                        .font(.system(size: 12))
                                        .foregroundStyle(Color("grayName"))
                                        .strikethrough()
                                        .frame(height: 14)
                                }
                            }.frame(height: 36)
                            Spacer()
                            Button{
                                if let index = CartViewModel.shared.findPosition(viewModel.product.name){
                                    if CartViewModel.shared.positions[index].count.truncatingRemainder(dividingBy: 1) == 0{
                                        viewModel.count = Int(CartViewModel.shared.positions[index].count)
                                    } else {
                                        viewModel.kgCount = CartViewModel.shared.positions[index].count
                                        isChangePickerView.toggle()
                                    }

                                    
                                } else {
                                    CartViewModel.shared.addPosition(Position(id: viewModel.product.id, product: viewModel.product, count: 1))
                                }
                                
                                withAnimation {
                                    isCartButtonClicked.toggle()
                                }
                                
                            } label: {
                                Image(uiImage: UIImage(named: "cart")!)
                                    .resizable()
                                    .frame(width: 13.51, height: 13)
                            }.buttonStyle(BorderlessButtonStyle())
                                .frame(width: 48, height: 36)
                                .background(Color("mainGreen"))
                                .clipShape(.rect(cornerRadius: 16))
                        }
                    } else {

                        
                        if viewModel.product.isByKg == false {
                            Spacer()
                            HStack(spacing: 20){
                                Button {
                                    if viewModel.count > 1 {
                                        viewModel.count -= 1
                                        if let index = CartViewModel.shared.findPosition(viewModel.product.name){
                                            CartViewModel.shared.positions[index].count = Double(viewModel.count)
                                        }
                                    } else {
                                        if let index = CartViewModel.shared.findPosition(viewModel.product.name){
                                            CartViewModel.shared.removeThatMf(index)
                                        }
                                        isCartButtonClicked.toggle()
                                        
                                    }
                                } label: {
                                    Image(uiImage: UIImage(named: "minus")!)
                                        .frame(width: 36, height: 36)
                                }.buttonStyle(BorderlessButtonStyle())

                                VStack{
                                    Text("\(viewModel.count)" + "шт")
                                        .foregroundStyle(Color.white)
                                        .font(.system(size: 12))
                                        .bold()
                                    Text("\((viewModel.product.actualPrice * Double(viewModel.count)).formatted())" + " ₽")
                                        .foregroundStyle(Color.white)
                                        .font(.system(size: 8))
                                }.frame(width: 41, height: 32)
                                Button {
                                    viewModel.count += 1
                                    if let index = CartViewModel.shared.findPosition(viewModel.product.name){
                                        CartViewModel.shared.positions[index].count = Double(viewModel.count)
                                    }
                                } label: {
                                    Image(uiImage: UIImage(named: "plus")!)
                                        .frame(width: 36, height: 36)
                                }.buttonStyle(BorderlessButtonStyle())

                            }.frame(width: 175, height: 36)
                                .background(Color("mainGreen"))
                                .cornerRadius(16)
                        } else {
                            Picker("Способ покупки", selection: $selectedSegment) {
                                if !isChangePickerView{
                                    Text("Шт.").tag(0)
                                    //.font(.system(size: 4))
                                    Text("Кг").tag(1)
                                    //.font(.system(size: 4))
                                } else {
                                    Text("Шт.").tag(1)
                                    //.font(.system(size: 4))
                                    Text("Кг").tag(0)
                                    //.font(.system(size: 4))
                                }
                            }.pickerStyle(.segmented)
                                .frame(width: 175, height: 28)
                            VStack{
                                if (selectedSegment == 0 && isChangePickerView == false) || (selectedSegment == 1 && isChangePickerView == true){
                                    HStack(spacing: 20){
                                        Button {
                                            if viewModel.count > 1 {
                                                viewModel.count -= 1
                                                if let index = CartViewModel.shared.findPosition(viewModel.product.name){
                                                    CartViewModel.shared.positions[index].count = Double(viewModel.count)
                                                }
                                            } else {
                                                if let index = CartViewModel.shared.findPosition(viewModel.product.name){
                                                    CartViewModel.shared.removeThatMf(index)
                                                }
                                                isCartButtonClicked.toggle()
                                            }
                                        } label: {
                                            Image(uiImage: UIImage(named: "minus")!)
                                                .frame(width: 36, height: 36)
                                        }.buttonStyle(BorderlessButtonStyle())

                                        VStack{
                                            Text(String.init(describing: viewModel.count) + " шт.")
                                                .foregroundStyle(Color.white)
                                                .font(.system(size: 12))
                                                .bold()
                                            Text("\((viewModel.product.actualPrice * Double(viewModel.count)).formatted())" + " ₽")
                                                .foregroundStyle(Color.white)
                                                .font(.system(size: 8))
                                        }.frame(width: 41, height: 32)
                                        Button {
                                            viewModel.count += 1
                                            if let index = CartViewModel.shared.findPosition(viewModel.product.name){
                                                CartViewModel.shared.positions[index].count = Double(viewModel.count)
                                            }
                                        } label: {
                                            Image(uiImage: UIImage(named: "plus")!)
                                                .frame(width: 36, height: 36)
                                        }.buttonStyle(BorderlessButtonStyle())

                                    }.frame(width: 175, height: 36)
                                        .background(Color("mainGreen"))
                                        .cornerRadius(16)
                                } else {
                                    HStack(spacing: 20){
                                        Button {
                                            if viewModel.kgCount > 0.1 {
                                                viewModel.kgCount -= 0.1
                                                if let index = CartViewModel.shared.findPosition(viewModel.product.name){
                                                    CartViewModel.shared.positions[index].count = Double(viewModel.kgCount)
                                                }
                                            } else {
                                                if let index = CartViewModel.shared.findPosition(viewModel.product.name){
                                                    CartViewModel.shared.removeThatMf(index)
                                                }
                                                isCartButtonClicked.toggle()
                                            }
                                        } label: {
                                            Image(uiImage: UIImage(named: "minus")!)
                                                //.resizable()
                                                .frame(width: 36, height: 36)
                                        }.buttonStyle(BorderlessButtonStyle())

                                        VStack{
                                            Text(String(describing: viewModel.kgCount.formatted()) + "кг")
                                                .foregroundStyle(Color.white)
                                                .font(.system(size: 12))
                                                .bold()
                                            Text("\((viewModel.product.actualPrice*viewModel.kgCount).formatted())" + " ₽")
                                                .foregroundStyle(Color.white)
                                                .font(.system(size: 8))
                                        }.frame(width: 41, height: 32)
                                        Button {
                                            viewModel.kgCount += 0.1
                                            if let index = CartViewModel.shared.findPosition(viewModel.product.name){
                                                CartViewModel.shared.positions[index].count = Double(viewModel.kgCount)
                                            }

                                        } label: {
                                            Image(uiImage: UIImage(named: "plus")!)
                                                .frame(width: 36, height: 36)
                                        }.buttonStyle(BorderlessButtonStyle())

                                    }.frame(width: 175, height: 36)
                                        .background(Color("mainGreen"))
                                        .cornerRadius(16)
                                   
                                }
                            }
                        }
                        
                    }

                }.frame(width:175,height: 144)
                
                Spacer()
            }.frame(width: screen.width, height: 176)
                .onChange(of: selectedSegment) {
                    if selectedSegment == 0 {
                        viewModel.count = 1
                        if let index = CartViewModel.shared.findPosition(viewModel.product.name){
                            CartViewModel.shared.positions[index].count = Double(viewModel.count)
                        }
                    } else {
                        viewModel.kgCount = 0.1
                        if let index = CartViewModel.shared.findPosition(viewModel.product.name){
                            CartViewModel.shared.positions[index].count = Double(viewModel.kgCount)
                        }
                    }

                    
                }
        }

    }
}

#Preview {
    ProductHorizontalView(viewModel: ProductDetailViewModel(product: Product(id: "1", name: "Сыр ламбер 500/0 230г", oldPrice: 199.0, actualPrice: 905.90, rating: 4.1,img: UIImage(named: "1Item")!, offer: Product.Offer(offerName: "Удар по ценам", color: UIColor(named: "punchPrices")!), isByKg: false)))
}
