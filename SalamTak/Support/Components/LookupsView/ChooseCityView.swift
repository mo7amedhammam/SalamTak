//
//  ChooseCityView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 04/04/2022.
//

import SwiftUI

struct ChooseCity : View {
    var language = LocalizationService.shared.language
    
    @StateObject var cityVM = ViewModelGetCities()
    @Binding var IsPresented: Bool
    @Binding var SelectedCityName: String
    @Binding var SelectedCityId: Int
    @Binding var SelectedCountryId: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40.0)
                .foregroundColor(.white)
                .shadow(radius: 15)
            
            VStack (spacing:0){
                Capsule()
                    .frame(width: 50, height: 4)
                    .foregroundColor(.gray)
                    .padding(.top ,10)
                VStack {
                    Text("Clinic_Screen_city".localized(language))
                        .font(.title2)
                        .bold()
                    ScrollView(showsIndicators: false) {
                        VStack {
                            ForEach(cityVM.publishedCityModel , id:\.self) { button in
                                HStack {
                                    Spacer().frame(width:20)
                                    Button(action: {
                                        self.SelectedCityName = button.Name ?? ""
                                        self.SelectedCityId = button.Id ?? 0
                                        //                                        cityVM.CityId = SelectedCityId
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
                    
                    .frame(width: UIScreen.main.bounds.width)
                    
                    HStack {
                        ButtonView(text: "Confirm".localized(language), action: {
                            withAnimation(.easeIn(duration: 0.3)) {
                                //                                cityVM.CityId = SelectedCityId
                                IsPresented =  false
                            }
                        })
                    }
                    .padding(.bottom, 20)
                    .padding(.horizontal,20)
                    Spacer()
                }
                .padding(.top,10)
                
                //                .frame(height: (UIScreen.main.bounds.size.height / 2) )
                //                Spacer()
            }
            .padding(.bottom,hasNotch ? 300 : 230)
            
        }
        .offset(y: (UIScreen.main.bounds.size.height / 2) - 80)
        .onAppear{
            cityVM.CountryId = SelectedCountryId
            cityVM.startFetchCities() // 1
        }
    }
}

struct ChooseCity_Previews: PreviewProvider {
    static var previews: some View {
        ChooseCity( IsPresented: .constant(true), SelectedCityName: .constant(""), SelectedCityId: .constant(0),SelectedCountryId:.constant(1))
        //            .environmentObject(ViewModelGetCities())
    }
}
