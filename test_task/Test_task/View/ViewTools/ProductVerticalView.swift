import SwiftUI

struct ProductVerticalView: View {
    @State var isHeartPushed = false
    @State var isCartButtonClicked = false
    @State var selectedSegment = 0
    @State var isChangePickerView = false
    @StateObject var viewModel: ProductDetailViewModel
    var body: some View {
        
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                Image(uiImage: viewModel.product.img)
                    .resizable()
                    .scaledToFit()
 
                VStack {
                    HStack(alignment: .top) {
                        if viewModel.product.offer != nil {
                            Text(String.init(describing: viewModel.product.offer!.offerName))
                                .font(.system(size: 10))
                                .padding(.horizontal,10)
                                .padding(.vertical, 3)
                                .foregroundColor(.white)
                                .background(Color(viewModel.product.offer!.color))
                                .clipShape(.rect(bottomTrailingRadius: 6, topTrailingRadius: 6))
                        }
                        
                        Spacer()
                        
                        VStack {
                        Button { // Кнопка)
                                print("cheque")
                            } label: {
                                Image(uiImage: UIImage(named:  "cheque")!)
                                    .resizable()
                                    .frame(width: 14, height: 13.7)
                                    .padding(.bottom, 6)
                            }
                            
                            Button { //Кнопка лайка
                                withAnimation {
                                    isHeartPushed.toggle()
                                }
                            } label: {
                                Image(uiImage: UIImage(named: isHeartPushed == false ? "heartMy" : "heartMyFill")!)
                                    .resizable()
                                    .frame(width: 13.2, height: 12)
                            }
                            
                        }
                            .frame(width: 32, height: 64)
                            .background(Color("fiftyWhite"))
                            .cornerRadius(8)
                    }
                    
                    Spacer()
                    
                    HStack {
                        HStack{
                            Image(uiImage: UIImage(named: "Star")!)
                                .resizable()
                                .frame(width: 12, height: 12)
                            Text(String.init(describing: viewModel.product.rating))
                                .font(.system(size: 12))
                        }.frame(width:41, height: 20)

                        Spacer()
                        
                        if viewModel.product.discount != nil{
                            Text(String.init(describing: viewModel.product.discount!) + "%")
                                .font(.system(size: 16))
                                .bold()
                                .foregroundColor(Color("saleRed"))
                        }

                            
                    }.frame(alignment: .bottom)
                    
                    .padding(.horizontal, 4)
                }.frame(width: 168, height: 168)


            }
            


            Text(String.init(describing: viewModel.product.name))
                .font(.system(size: 12))
                .foregroundStyle(Color("grayName"))
                .padding(.leading,8)
            if isCartButtonClicked != true && viewModel.product.isByKg != true{
                if viewModel.product.country != nil {
                    HStack{
                        Text(String.init(describing: viewModel.product.country!))
                            .font(.system(size: 12))
                            .fontWeight(.light)
                            .foregroundStyle(Color("country"))
                            .frame(height: 14)
                    }.frame(height: 18)
                        .padding(.leading, 8)
                }
            }

            Spacer()
            
            HStack() {
                if isCartButtonClicked == false { //если кнопка корзины не была нажата, то дефолтные элементы
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            HStack(spacing: 0){
                                Text(String.init(describing: floor(viewModel.product.actualPrice).formatted()))
                                    .font(.system(size: 20))
                                    .bold()
                                    
                                Text(String.init(describing: ((viewModel.product.actualPrice - Double(Int(viewModel.product.actualPrice)))*100).formatted()))
                                    .font(.system(size: 15))
                                    .bold()
                                    .frame(width: 20, height: 22, alignment: .topTrailing)

                                    
                                Image(uiImage: UIImage(named: "rubKg")!)
                                    .frame(width: 20, height: 20)
                            }
                            
                            if viewModel.product.oldPrice != nil {
                                Text(String.init(describing: viewModel.product.oldPrice!))
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color("grayName"))
                                    .strikethrough()
                                    .frame(height: 14)
                            }

                        }.frame(height: 36)
                            
                        Spacer()
                                                
                        Button(action: { //кнопка корзины
//проверка на то, есть ли уже этот элемент в корзине, если нет, то добавляем его в корзину
                            if let index = CartViewModel.shared.findPosition(viewModel.product.name){
                                if CartViewModel.shared.positions[index].count.truncatingRemainder(dividingBy: 1) == 0{
                                    viewModel.count = Int(CartViewModel.shared.positions[index].count)
                                } else {
                                    viewModel.kgCount = CartViewModel.shared.positions[index].count
                                    isChangePickerView.toggle()
                                }

                            } else {
                                CartViewModel.shared.addPosition(Position(id: viewModel.product.id, product: viewModel.product, count: 1))//Добавление элемента по дефолту
                            }
                            withAnimation {
                                isCartButtonClicked.toggle()
                            }
                        }) {
                            Image(uiImage: UIImage(named: "cart")!)
                                .resizable()
                                
                                .frame(width: 13.51, height: 13)
                                

                                
                                
                        }.frame(width: 48, height: 36)
                            .background(Color("mainGreen"))
                            .clipShape(.rect(cornerRadius: 16))
                    }.frame(width: 160, height: 36)
                } else {
                    if viewModel.product.isByKg == false { //если у продукта не предусмотрена покупка за вес
                        HStack(spacing: 20){
                            Button { //кнопка удаления из корзины поштучно
                                if viewModel.count > 1 {
                                    viewModel.count -= 1
                                    if let index = CartViewModel.shared.findPosition(viewModel.product.name){
                                        CartViewModel.shared.positions[index].count = Double(viewModel.count)
                                    }
                                } else {
                                    if let index = CartViewModel.shared.findPosition(viewModel.product.name){
                                        CartViewModel.shared.removeThatMf(index)
                                    }//удаление из корзины, если при 1 был нажат минус
                                    isCartButtonClicked.toggle()
                                    
                                }
                            } label: {
                                Image(uiImage: UIImage(named: "minus")!)
                                    .frame(width: 36, height: 36)
                            }

                            VStack{
                                Text("\(viewModel.count)" + "шт")
                                    .foregroundStyle(Color.white)
                                    .font(.system(size: 12))
                                    .bold()
                                Text("\((viewModel.product.actualPrice * Double(viewModel.count)).formatted())" + " ₽")
                                    .foregroundStyle(Color.white)
                                    .font(.system(size: 8))
                            }.frame(height: 32)
                            Button { //кнопка добавления в корзину поштучно
                                viewModel.count += 1
                                if let index = CartViewModel.shared.findPosition(viewModel.product.name){
                                    CartViewModel.shared.positions[index].count = Double(viewModel.count)
                                }
                                
                            } label: {
                                Image(uiImage: UIImage(named: "plus")!)
                                    .frame(width: 36, height: 36)
                            }

                        }.frame(width: 160, height: 36)
                            .background(Color("mainGreen"))
                            .cornerRadius(16)
                    } else { //если есть возможность взять по весу
                        VStack(spacing: 6){
                            Picker("Способ покупки", selection: $selectedSegment) {
                                if !isChangePickerView{
                                    Text("Шт.").tag(0)
                                    
                                    Text("Кг").tag(1)
                                    
                                } else {
                                    Text("Шт.").tag(1)
                                    
                                    Text("Кг").tag(0)
                                    
                                }
                            }.pickerStyle(.segmented)
                                .frame(width: 158, height: 28)

                            if (selectedSegment == 0 && isChangePickerView == false) || (selectedSegment == 1 && isChangePickerView == true){
                                //если выбрано поштучно
                                HStack(spacing: 20){
                                    Button {
                                        if viewModel.count > 1 {//кнопка удаления из корзины поштучно
                                            viewModel.count -= 1
                                            if let index = CartViewModel.shared.findPosition(viewModel.product.name){
                                                CartViewModel.shared.positions[index].count = Double(viewModel.count)
                                            }
                                        } else {
                                            if let index = CartViewModel.shared.findPosition(viewModel.product.name){
                                                CartViewModel.shared.removeThatMf(index)
                                            } //удаление из корзины, если при 1 был нажат минус
                                            isCartButtonClicked.toggle()
                                        }
                                    } label: {
                                        Image(uiImage: UIImage(named: "minus")!)
                                            .frame(width: 36, height: 36)
                                    }

                                    VStack{
                                        Text(String.init(describing: viewModel.count) + " шт.")
                                            .foregroundStyle(Color.white)
                                            .font(.system(size: 12))
                                            .bold()
                                        Text("\((viewModel.product.actualPrice * Double(viewModel.count)).formatted())" + " ₽")
                                            .foregroundStyle(Color.white)
                                            .font(.system(size: 8))
                                    }.frame(width: 60,height: 32)
                                    Button { //кнопка добавления в корзину поштучно
                                        viewModel.count += 1
                                        if let index = CartViewModel.shared.findPosition(viewModel.product.name){
                                            CartViewModel.shared.positions[index].count = Double(viewModel.count)
                                        }
                                    } label: {
                                        Image(uiImage: UIImage(named: "plus")!)
                                            .frame(width: 36, height: 36)
                                    }

                                }.frame(width: 160, height: 36)
                                    .background(Color("mainGreen"))
                                    .cornerRadius(16)
                            } else {
                                //выбрана покупка за вес
                                HStack(spacing: 20){
                                    Button {
                                        if viewModel.kgCount > 0.1 { //кнопка удаления
                                            
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
                                    }

                                    VStack{
                                        Text(String(describing: viewModel.kgCount.formatted()) + "кг")
                                            .foregroundStyle(Color.white)
                                            .font(.system(size: 12))
                                            .bold()
                                        Text("\((viewModel.product.actualPrice*viewModel.kgCount).formatted())" + " ₽")
                                            .foregroundStyle(Color.white)
                                            .font(.system(size: 8))
                                    }.frame(width: 60,height: 32)
                                    Button { //кнопка добавления
                                        viewModel.kgCount += 0.1
                                        if let index = CartViewModel.shared.findPosition(viewModel.product.name){
                                            CartViewModel.shared.positions[index].count = Double(viewModel.kgCount)
                                        }
                                    } label: {
                                        Image(uiImage: UIImage(named: "plus")!)
                                            .frame(width: 36, height: 36)
                                    }

                                }.frame(width: 160, height: 36)
                                    .background(Color("mainGreen"))
                                    .cornerRadius(16)
                               
                            }
                        }
                       
                        
                    }
                        
                    
                }
                

                
    
                
            }.frame(width: 168, height: isCartButtonClicked == true && viewModel.product.isByKg == true ? 80 : 44)
                
            
           
        }
        .frame(width: 168, height: 278)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 2)
        .onChange(of: selectedSegment) { //если был переход с поштучного режима на режим покупки за вес, то количество добавленных 'штук' обнулится и наоборот
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

#Preview {
    ProductVerticalView(viewModel: ProductDetailViewModel(product: Product(id: "1", name: "Сыр ламбер 500/0 230г", oldPrice: 199.0, actualPrice: 905.90, rating: 4.1,img: UIImage(named: "1Item")!, offer: Product.Offer(offerName: "Удар по ценам", color: UIColor(named: "punchPrices")!), isByKg: false)))
}
