//
//  ChooseNationalityView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 04/04/2022.
//

import SwiftUI

struct ChooseOccupation : View {
    var language = LocalizationService.shared.language
    //@ObservedObject var dataModel: DataModel
    //    @StateObject var checkModel = CheckBoxViewModel()
    @ObservedObject private var patientCreatedVM = ViewModelCreatePatientProfile()

//    @StateObject var OccupationVM = ViewModelOccupation()
    @EnvironmentObject var OccupationVM : ViewModelOccupation

    
    @Binding var IsPresented: Bool
    @State public var buttonSelected: Int?
    
    @Binding var SelectedOccupationName: String
    @Binding var SelectedOccupationId: Int
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
                .padding(.top,10)
                VStack {
                    
                        VStack {
                            Text("Occupation")
                                .font(.title2)
                                .bold()
                            ScrollView {
                                ForEach(0..<OccupationVM.publishedCountryModel.count) { button in
                                    HStack {
                                        Spacer().frame(width:30)
                                        Button(action: {
                                            self.buttonSelected = button
                                            print("SelectedID is \(self.OccupationVM.publishedCountryModel[button].Id ?? 0)")
                                            self.SelectedOccupationName = OccupationVM.publishedCountryModel[button].Name ?? ""
                                            self.SelectedOccupationId = OccupationVM.publishedCountryModel[button].Id ?? 0
                                            patientCreatedVM.occupationName = SelectedOccupationName
                                            patientCreatedVM.OccupationId = SelectedOccupationId
                                        }, label: {
                                            HStack{
                                                Image(systemName:  self.buttonSelected == button ? "checkmark.circle.fill" :"circle" )
                                                    .font(.system(size: 20))
                                                    .foregroundColor(self.buttonSelected == button ? Color("blueColor") : Color("lightGray"))
                                                Text(self.OccupationVM.publishedCountryModel[button].Name ?? "")  .padding()
                                                    .foregroundColor(self.buttonSelected == button ? Color("blueColor") : Color("lightGray"))
                                                Spacer()
                                                
                                                
                                            }
                                        })
                                        
                                    }
                                }
                            }
                        }
                    
                    
                    
                    HStack {
                        ButtonView(text: "CompeleteProfile_Screen_ConfirmButton".localized(language), action: {
                            withAnimation(.easeIn(duration: 0.3)) {
                                patientCreatedVM.occupationName = SelectedOccupationName
                                patientCreatedVM.OccupationId = SelectedOccupationId
                                IsPresented.toggle()
                            }
                        })
                        
                        
                    }
                    .padding(.bottom, 20)
                }
                .frame(height: (UIScreen.main.bounds.size.height / 2)  + 40)
                
                
                Spacer()
            }
            
        }.onAppear(perform: {
            OccupationVM.startFetchOccupation()
        })
        .offset(y: (UIScreen.main.bounds.size.height / 2)  - 200)
    }
}
