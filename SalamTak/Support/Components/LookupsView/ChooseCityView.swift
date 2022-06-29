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

//    @State private var buttonSelected : Int?

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
                            ForEach(cityVM.publishedCityModel , id:\.self) { button in
                                HStack {
                                    Spacer().frame(width:20)
                                    Button(action: {
                                        self.SelectedCityName = button.Name ?? ""
                                        self.SelectedCityId = button.Id ?? 0
                                        patientCreatedVM.cityName = SelectedCityName
                                        patientCreatedVM.CityId = SelectedCityId
                                        cityVM.CityId = SelectedCityId
                                        IsPresented =  false

                                    }, label: {
                                        HStack{
                                            Image(systemName:  SelectedCityId == button.Id ?? 0 ? "checkmark.circle.fill" :"circle" )
                                                .font(.system(size: 20))
                                                .foregroundColor(self.SelectedCityId == button.Id ? Color("blueColor") : Color("lightGray"))
                                            Text(button.Name ?? "")  .padding()
                                                .foregroundColor(self.SelectedCityId == button.Id ?? 0 ? Color("blueColor") : Color("lightGray"))
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
                Spacer()
            }
            
        }
        .offset(y: (UIScreen.main.bounds.size.height / 2) - 120)
        .onAppear{
            cityVM.CountryId = SelectedCountryId
            cityVM.startFetchCities() // 1

        }

    }
}

struct ChooseCity_Previews: PreviewProvider {
    static var previews: some View {
        ChooseCity( IsPresented: .constant(true), SelectedCityName: .constant(""), SelectedCityId: .constant(0),SelectedCountryId:.constant(1), width: CGFloat(150) ).environmentObject(ViewModelGetCities())
    }
}
