//
//  ChooseAreaView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 04/04/2022.
//

import SwiftUI

struct ChooseArea : View {
    var language = LocalizationService.shared.language
    @ObservedObject var patientCreatedVM = ViewModelCreatePatientProfile()
//    @ObservedObject var cityVM = ViewModelGetCities()
    @StateObject var areaVM = ViewModelGetAreas()

    @State private var buttonSelected : Int?

    @Binding var IsPresented: Bool
    @Binding var SelectedAreaName: String
    @Binding var SelectedAreaId: Int
    @Binding var SelectedCityId: Int

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
                        Text("Clinic_Screen_area".localized(language))
                            .font(.title2)
                            .bold()
                        ScrollView(showsIndicators: false) {
                            ForEach(0..<areaVM.publishedAreaModel.count , id:\.self) { button in
                                HStack {
                                    Spacer().frame(width:20)
                                    Button(action: {
                                        self.buttonSelected = button
                                        print("Selected area ID is \(self.areaVM.publishedAreaModel[button].id ?? 0)")
                                        self.SelectedAreaName = areaVM.publishedAreaModel[button].Name ?? ""
                                        self.SelectedAreaId = areaVM.publishedAreaModel[button].id ?? 0
                                        patientCreatedVM.areaName = SelectedAreaName
                                        patientCreatedVM.AreaId = SelectedAreaId
                                        
                                        IsPresented =  false

                                    }, label: {
                                        HStack{
                                            Image(systemName:  self.buttonSelected == button ? "checkmark.circle.fill" :"circle" )
                                                .font(.system(size: 20))
                                                .foregroundColor(self.buttonSelected == button ? Color("blueColor") : Color("lightGray"))
                                            Text(self.areaVM.publishedAreaModel[button].Name ?? "")  .padding()
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
                                patientCreatedVM.areaName = SelectedAreaName
                                patientCreatedVM.AreaId = SelectedAreaId
                                
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
        .offset(y: (UIScreen.main.bounds.size.height / 2) - 200)
        .onAppear{
//            print(areaVM.cityId ?? 000)

//            areaVM.startFetchAreas()
            areaVM.startFetchAreas(cityId: SelectedCityId)
        }
        .onDisappear{
//            areaVM.startFetchAreas(cityId: self.SelectedCityId ?? 0)
        }
    }
}
