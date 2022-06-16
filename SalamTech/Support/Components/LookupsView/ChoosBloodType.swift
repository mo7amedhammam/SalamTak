//
//  ChooseNationalityView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 04/04/2022.
//

import SwiftUI

struct ChooseBloodType : View {
    var language = LocalizationService.shared.language
    
    @ObservedObject private var medicalCreatedVM = ViewModelCreateMedicalProfile()
    @EnvironmentObject var BloodTypeVM : ViewModelBloodType
    
    @Binding var IsPresented: Bool
    @State var buttonSelected: Int?
    
    @Binding var SelectedBloodName: String
    @Binding var SelectedBloodId: Int
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
                        Text("Blood Group")
                            .font(.title2)
                            .bold()
                        ScrollView {
                            ForEach(0..<BloodTypeVM.publishedCountryModel.count) { button in
                                HStack {
                                    Spacer().frame(width:30)
                                    Button(action: {
                                        self.buttonSelected = button
                                        print("SelectedID is \(self.BloodTypeVM.publishedCountryModel[button].Id ?? 0)")
                                        self.SelectedBloodName = BloodTypeVM.publishedCountryModel[button].Name ?? ""
                                        self.SelectedBloodId = BloodTypeVM.publishedCountryModel[button].Id ?? 0
                                        medicalCreatedVM.BloodTypeName = SelectedBloodName
                                        medicalCreatedVM.BloodTypeId = SelectedBloodId
                                        IsPresented = false
                                    }, label: {
                                        HStack{
                                            Image(systemName:  self.buttonSelected == button ? "checkmark.circle.fill" :"circle" )
                                                .font(.system(size: 20))
                                                .foregroundColor(self.buttonSelected == button ? Color("blueColor") : Color("lightGray"))
                                            Text(self.BloodTypeVM.publishedCountryModel[button].Name ?? "")  .padding()
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
                                medicalCreatedVM.BloodTypeName = SelectedBloodName
                                medicalCreatedVM.BloodTypeId = SelectedBloodId
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
            BloodTypeVM.startFetchBloodTypes()
        })
            .offset(y: (UIScreen.main.bounds.size.height / 2)  - 200)
    }
}
