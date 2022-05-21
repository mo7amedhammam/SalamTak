//
//  BookingView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//


import SwiftUI


struct BookingView: View {
    @StateObject var medicalType = ViewModelExaminationTypeId()
    @StateObject var specialityvm = ViewModelSpecialist()
    
    @State private var image = UIImage()
    @State private var radius: CGFloat = .zero
    @State var loginAgain = false
    var language = LocalizationService.shared.language
    var vGridLayout = [ GridItem(.adaptive(minimum: 90), spacing: 30) ]
    @State var counter = 0
    @State var gotoSpec = false

    
    var body: some View {
        ZStack{
        VStack{
            AppBarLogoView(imageName: "barlogo")
            Spacer().frame(height:30)
            
            ScrollView( showsIndicators: false){
                HStack {
                    Text("Our Services")
                        .font(Font.SalamtechFonts.Bold18)
                    Spacer()
                }
                
                LazyVGrid(columns: vGridLayout){
                    ForEach(medicalType.publishedModelExaminationTypeId) { exType in
                        
                        ZStack {
                            Button(action: {
                                gotoSpec=true
                                
                            }, label: {
                                VStack{
                                    AsyncImage(url: URL(string:   URLs.BaseUrl + "\(exType.image ?? "")" )) { image in

                                        image.resizable()

                                    } placeholder: {
                                        Image("logo")
                                            .resizable()
                                           
                                    } .foregroundColor(.black)
                                        .background(.blue)
                                    

                                    
                                    Text(exType.Name ?? "")
                                        .padding(.vertical,10)
                                        .foregroundColor(.black)
                                }
                            })
                                .frame(width: (UIScreen.main.bounds.width/3)-20, height: 120)
                                .background(Color.white)
                                .cornerRadius(8)
                                .shadow(color: .black.opacity(0.099), radius: 5)
                        }
                    }
                                        
                }
                .padding(.horizontal,13)

                Spacer()
            }.background(Color.clear)
                .padding([.horizontal])
            
            
            
        }
        .frame(width: UIScreen.main.bounds.width)
        .edgesIgnoringSafeArea(.top)
        .background(Color("CLVBG"))
        .onAppear(perform: {
            medicalType.isLoading = true
        })
        
            // showing loading indicator
            ActivityIndicatorView(isPresented: $medicalType.isLoading)
        }
        // go to clinic info
//        NavigationLink(destination:SpecialityView(),isActive: $gotoSpec) {
//             }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)

    }
    

    
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        BookingView()
        }.navigationBarHidden(true)
    }
}
