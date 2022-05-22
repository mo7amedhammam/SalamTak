//
//  CityView.swift
//  SalamTech
//
//  Created by wecancity on 04/04/2022.

import SwiftUI


struct CityView: View {
    @StateObject var CitiesVM = ViewModelGetCities()
    @StateObject var searchDoc = VMSearchDoc()

    @State private var image = UIImage()
    @State var loginAgain = false
    var language = LocalizationService.shared.language
    var CountryId : Int?

    @State var gotoArea = false
    @State var selectedCityId = 0
    @State var gotoSearchdoctor = false
    @Binding var SelectedSpeciality : Int
    @Binding var extype : Int

    
    
    var body: some View {
        ZStack{
        VStack{
            ScrollView( showsIndicators: false){
                Spacer().frame(height:120)
                HStack {
                    Text("Choose_your_City".localized(language))
                        .font(Font.SalamtechFonts.Bold18)
                    Spacer()
                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)


                Button(action: {
                    selectedCityId = 0
                    gotoSearchdoctor=true
                }, label: {
                    
                    ZStack {

                        HStack{
                            Spacer().frame(width:30)
                            Text("All_Cities".localized(language))
                                    .frame(height:35)
                                    .font(Font.SalamtechFonts.Reg18)
                                    .foregroundColor(.black)
                            Spacer()
                            }
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                            .frame(width: (UIScreen.main.bounds.width)-33, height: 50)
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(color: .black.opacity(0.099), radius: 5)
                    }
                }) .frame(width: (UIScreen.main.bounds.width)-10)
                    .background(Color.clear)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.099), radius: 5)
            
                ForEach(CitiesVM.publishedCityModel , id:\.self){ city in
                            Button(action: {
//                                searchDoc.CityId = city.Id ?? 5455454545
                                selectedCityId = city.Id ?? 8787878
                                gotoArea = true
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
                AppBarView(Title: "Choose_City".localized(language))
                    .navigationBarItems(leading: BackButtonView())
                    .navigationBarBackButtonHidden(true)
                    Spacer()
            }
            .edgesIgnoringSafeArea(.vertical)

            // showing loading indicator
            ActivityIndicatorView(isPresented: $CitiesVM.isLoading)
        }.onAppear(perform: {
            CitiesVM.isLoading = true
            CitiesVM.startFetchCities(countryid: CountryId)
        })

        
        //  go to clinic info
        NavigationLink(destination:AreaView(CityId: $selectedCityId, SelectedSpeciality: $SelectedSpeciality, extype: $extype)
                        ,isActive: $gotoArea) {
              }
        //  go to clinic info
        NavigationLink(destination:ViewSearchDoc(ExTpe: $extype, SpecialistId: $SelectedSpeciality, CityId: .constant(0), AreaId: .constant(0)),isActive: $gotoSearchdoctor) {
              }
    }
    

    
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CityView(SelectedSpeciality: .constant(45454545454), extype: .constant(454545454))
        }.navigationBarHidden(true)
    }
}
