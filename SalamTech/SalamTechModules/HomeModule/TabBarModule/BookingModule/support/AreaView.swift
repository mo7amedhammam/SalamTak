//
//  AreaView.swift
//  SalamTech
//
//  Created by wecancity on 09/04/2022.
//
import SwiftUI


struct AreaView: View {
    @StateObject var AreasVM = ViewModelGetAreas()
    @StateObject var searchDoc = VMSearchDoc()

    @State private var image = UIImage()
    @State var loginAgain = false
    var language = LocalizationService.shared.language
    @Binding var CityId : Int
    @Binding var SelectedSpeciality : Int
    @Binding var extype : Int
    
    @State var gotoSearchdoctor = false
    @State var selectedAreaId = 0

    
    
    var body: some View {
        ZStack{
        VStack{
            ScrollView( showsIndicators: false){
                Spacer().frame(height:120)
                HStack {
                    Text("Choose_your_Area".localized(language))
                        .font(Font.SalamtechFonts.Bold18)
                    Spacer()
                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)


                Button(action: {
                    selectedAreaId = 0
                    gotoSearchdoctor=true
                }, label: {
                    
                    ZStack {

                        HStack{
                            Spacer().frame(width:30)
                            Text("All_Areas".localized(language))
                                    .frame(height:35)
                                    .font(Font.SalamtechFonts.Reg18)
                                    .foregroundColor(.black)
                            Spacer()
                            }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                            
                            .frame(width: (UIScreen.main.bounds.width)-33, height: 50)
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(color: .black.opacity(0.099), radius: 5)
                    }
                }) .frame(width: (UIScreen.main.bounds.width)-10)
                    .background(Color.clear)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.099), radius: 5)
            
                ForEach(AreasVM.publishedAreaModel , id:\.self){ city in
                            Button(action: {
//                                searchDoc.CityId = city.id ?? 5455454545
                                selectedAreaId =  city.id ?? 454545454
                                gotoSearchdoctor = true
                            }, label: {
                                
                                ZStack {

                                    HStack{
                                        Spacer().frame(width:30)
                                            Text(city.Name ?? "")
                                                .frame(height:35)
                                                .font(Font.SalamtechFonts.Reg18)
                                                .foregroundColor(.black)
                                        Spacer()
                                        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                                        
                                        .frame(width: (UIScreen.main.bounds.width)-33, height: 50)
                                        .background(Color.white)
                                        .cornerRadius(25)
                                        .shadow(color: .black.opacity(0.099), radius: 5)
  
                                }
                            }) .frame(width: (UIScreen.main.bounds.width)-10)
                                .background(Color.clear)
                                .cornerRadius(8)
                                .shadow(color: .black.opacity(0.099), radius: 5)
                        

            


                    }


            }.background(Color.clear)
                .padding([.horizontal])
            
            
            Spacer()
        }
            
            
            
            
            
            
        .frame(width: UIScreen.main.bounds.width)
        .edgesIgnoringSafeArea(.vertical)
        .background(Color("CLVBG"))
        .onAppear(perform: {

        })
        
            VStack{
                AppBarView(Title: "Choose_Area".localized(language))
                    .navigationBarItems(leading: BackButtonView())
                    .navigationBarBackButtonHidden(true)
                    Spacer()
            }
            .edgesIgnoringSafeArea(.vertical)
            // showing loading indicator
            ActivityIndicatorView(isPresented: $AreasVM.isLoading)

        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: {
            AreasVM.startFetchAreas(cityId: CityId )
        })

        
        //  go to clinic info
        NavigationLink(destination:ViewSearchDoc(ExTpe: $extype, SpecialistId: $SelectedSpeciality, CityId: $CityId, AreaId: $selectedAreaId),isActive: $gotoSearchdoctor) {
              }
        
        // Alert with no internet connection
            .alert(isPresented: $AreasVM.isNetworkError, content: {
                Alert(title: Text("Check_Your_Internet_Connection".localized(language)), message: nil, dismissButton: .cancel())
        })

    }
    

    
}

struct AreaView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AreaView( CityId: .constant(48455151), SelectedSpeciality: .constant(48455151), extype: .constant(48455151),  selectedAreaId: 48455151)
                
                }.navigationBarHidden(true)
    }
}
