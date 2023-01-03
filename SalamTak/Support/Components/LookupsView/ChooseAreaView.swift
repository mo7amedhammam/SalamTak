//
//  ChooseAreaView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 04/04/2022.
//

import SwiftUI

struct ChooseArea : View {
    var language = LocalizationService.shared.language
    @StateObject var areaVM = ViewModelGetAreas()
    @Binding var IsPresented: Bool
    @Binding var SelectedAreaName: String
    @Binding var SelectedAreaId: Int
    @Binding var SelectedCityId: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40.0)
                .foregroundColor(.white)
                .shadow(radius: 15)
            
            VStack {
                    Capsule()
                        .frame(width: 50, height: 4)
                        .foregroundColor(.gray)
                        .padding(.top ,10)
              
                    VStack {
                        Text("Clinic_Screen_area".localized(language))
                            .font(.title2)
                            .bold()
                        ScrollView(showsIndicators: false) {
                            VStack {
                                ForEach(areaVM.publishedAreaModel , id:\.self) { button in
                                    HStack {
                                        Spacer().frame(width:20)
                                        Button(action: {
                                            self.SelectedAreaName = button.Name ?? ""
                                            self.SelectedAreaId = button.id ?? 0
                                            IsPresented =  false

                                        }, label: {
                                            HStack{
                                                Image(systemName:  SelectedAreaId == button.id ?? 0 ? "checkmark.circle.fill" :"circle" )
                                                    .font(.system(size: 20))
                                                    .foregroundColor(SelectedAreaId == button.id ?? 0 ? Color("blueColor") : Color("lightGray"))
                                                Text(button.Name ?? "")  .padding()
                                                    .foregroundColor(SelectedAreaId == button.id ?? 0 ? Color("blueColor") : Color("lightGray"))
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
                                IsPresented =  false
                            }
                        })
                    }
                    .padding(.bottom, 20)
                    .padding(.horizontal,20)
                }
//                .frame(height: (UIScreen.main.bounds.size.height / 2) )

                Spacer()
            }
            .padding(.bottom,hasNotch ? 300 : 230)

            
        }
        .offset(y: (UIScreen.main.bounds.size.height / 2) - 80)
        .onAppear{
            areaVM.cityId = SelectedCityId
            areaVM.startFetchAreas()
        }

    }
}

struct MChooseArea_Previews: PreviewProvider {
    static var previews: some View {

        ChooseArea(IsPresented: .constant(true), SelectedAreaName: .constant(""), SelectedAreaId: .constant(0), SelectedCityId: .constant(0))
    }
}
