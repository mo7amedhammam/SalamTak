//
//  ChooseCityView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 04/04/2022.
//

import SwiftUI


struct ChooseCity : View {
    var language = LocalizationService.shared.language

    @ObservedObject private var patientCreatedVM = ViewModelCreatePatientProfile()
    @StateObject var cityVM = ViewModelGetCities()
//    @ObservedObject var areaVM = ViewModelGetAreas()

    @State private var buttonSelected : Int?

    @Binding var IsPresented: Bool
    @Binding var SelectedCityName: String
    @Binding var SelectedCityId: Int
    @Binding var SelectedCountryId: Int

    var width: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40.0)
                .foregroundColor(.white)
                .ignoresSafeArea()
                .opacity(0.6)
                .shadow(radius: 15)
            
            VStack {
                ZStack{
                    Capsule()
                        .frame(width: 50, height: 4)
                        .foregroundColor(.gray)
                }
                .padding(.top ,10)
                VStack {
                    VStack {
                        Text("Clinic_Screen_city".localized(language))
                            .font(.title2)
                            .bold()
                        ScrollView(showsIndicators: false) {
                            ForEach(0..<cityVM.publishedCityModel.count , id:\.self) { button in
                                HStack {
                                    Spacer().frame(width:20)
                                    Button(action: {
                                        self.buttonSelected = button
                                        print("Selected City ID is \(self.cityVM.publishedCityModel[button].Id ?? 0)")
                                        self.SelectedCityName = cityVM.publishedCityModel[button].Name ?? ""
                                        self.SelectedCityId = cityVM.publishedCityModel[button].Id ?? 0
                                        patientCreatedVM.cityName = SelectedCityName
                                        patientCreatedVM.CityId = SelectedCityId
                                        cityVM.CityId = SelectedCityId
                                        IsPresented =  false

                                    }, label: {
                                        HStack{
                                            Image(systemName:  self.buttonSelected == button ? "checkmark.circle.fill" :"circle" )
                                                .font(.system(size: 20))
                                                .foregroundColor(self.buttonSelected == button ? Color("blueColor") : Color("lightGray"))
                                            Text(self.cityVM.publishedCityModel[button].Name ?? "")  .padding()
                                                .foregroundColor(self.buttonSelected == button ? Color("blueColor") : Color("lightGray"))
                                            Spacer()
                                            
                                            
                                        }
                                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                    })
                                    
                                }.padding([.top,.bottom],-8)
                            }
                        }
                    }
                    
                    
                    HStack {
                        ButtonView(text: "Confirm".localized(language), action: {
                            withAnimation(.easeIn(duration: 0.3)) {
                                patientCreatedVM.cityName = SelectedCityName
                                patientCreatedVM.CityId = SelectedCityId
                                cityVM.CityId = SelectedCityId
                                IsPresented =  false
                            }
                        })
                        
                        
                    }
                    .padding(.bottom, 20)
                }
                .frame(height: (UIScreen.main.bounds.size.height / 2) + 40)
//                .padding(30)
                
                Spacer()
            }
            
        }
        .offset(y: (UIScreen.main.bounds.size.height / 2) - 200)
        .onAppear{
            
            print(SelectedCountryId) // 1
//            print(cityVM.CountryId)  // 0
            cityVM.CountryId = SelectedCountryId
            cityVM.startFetchCities() // 1
//            cityVM.startFetchCities(countryid: updateClinicVM.CountryId) // 0

//            cityVM.startFetchCities(countryid: cityVM.CountryId) // 0
        }

    }
}
