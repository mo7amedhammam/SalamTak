//
//  CityView.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 04/04/2022.

import SwiftUI


struct CityView: View {
    @StateObject var CitiesVM = ViewModelGetCities()
    @EnvironmentObject var searchDoc : VMSearchDoc
    @EnvironmentObject var environments : EnvironmentsVM

    var language = LocalizationService.shared.language
    var CountryId : Int?
    
    @State var gotoArea = false
    @State var gotoSearchdoctor = false

    @State var selectedCityId = 0
    @State var selectedCityName = ""
    @Binding var SelectedSpeciality : Int
    @Binding var SelectedSpecialityName : String

    @Binding var extypeid : Int
    
    var body: some View {
        ZStack{
            VStack{
                AppBarView(Title: "Choose_City".localized(language),withbackButton: true)
                    .frame(height:70)
                    .padding(.top,-20)
                ScrollView( showsIndicators: false){
//                    Spacer().frame(height:120)
                    HStack {
                        Text("Choose_your_City".localized(language))
                            .foregroundColor(.salamtackBlue)
                            .font(.salamtakBold(of: 18))
                        Spacer()
                    }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    
                    Button(action: {
                        selectedCityId = 0
                        selectedCityName = "All_Cities".localized(language)
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
                            selectedCityId = city.Id ?? 8787878
                            selectedCityName = city.Name ?? ""
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
                    
                }
                .background(Color.clear)
                    .padding([.horizontal])
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width)
//            .edgesIgnoringSafeArea(.vertical)
//            .background(Color("CLVBG"))
            
//            VStack{
//                AppBarView(Title: "Choose_City".localized(language))
//                    .navigationBarItems(leading: BackButtonView())
//                    .navigationBarBackButtonHidden(true)
//                Spacer()
//            }
//            .edgesIgnoringSafeArea(.vertical)
            
            // showing loading indicator
            ActivityIndicatorView(isPresented: $CitiesVM.isLoading)
            
            //  go to clinic info
            NavigationLink(destination:AreaView(selectedCityId: $selectedCityId,selectedCityName: $selectedCityName, SelectedSpeciality: $SelectedSpeciality,SelectedSpecialityName:$SelectedSpecialityName , examinationTypeId: $extypeid)
                            .environmentObject(searchDoc)
                            .environmentObject(environments)
                            .navigationBarHidden(true)
                           ,isActive: $gotoArea) {
            }
            //  go to clinic info
            NavigationLink(destination:ViewSearchDoc()
                            .environmentObject(searchDoc)
                            .environmentObject(environments)
                            .navigationBarHidden(true),isActive: $gotoSearchdoctor) {
            }
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .onReceive(navController.popToRoot, perform: {newval in
            gotoSearchdoctor = newval
            gotoArea = newval
        })

        .onAppear(perform: {
            CitiesVM.CountryId = CountryId ?? 0
            CitiesVM.startFetchCities()
        })
        
        // Alert with no internet connection
        .alert(isPresented: $CitiesVM.isAlert, content: {
            Alert(title: Text(CitiesVM.message), message: nil, dismissButton: .cancel())
        })
        .background(
            newBackImage(backgroundcolor: .white, imageName:.image2)
        )

        
    }
    
    
    
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CityView(SelectedSpeciality: .constant(45454545454), SelectedSpecialityName: .constant(""), extypeid: .constant(454545454))
                .environmentObject(VMSearchDoc())
                .environmentObject(EnvironmentsVM())
        }.navigationBarHidden(true)
    }
}
