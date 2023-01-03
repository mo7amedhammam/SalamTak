//
//  ChooseNationalityView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 04/04/2022.
//

import SwiftUI

struct ChooseBloodType : View {
    var language = LocalizationService.shared.language

    @StateObject var BloodTypeVM = ViewModelBloodType()
    @Binding var IsPresented: Bool
    @Binding var SelectedBloodName: String
    @Binding var SelectedBloodId: Int

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40.0)
                .foregroundColor(.white)
                .shadow(radius: 15)
            
            VStack {
                    Capsule()
                        .frame(width: 50, height: 4)
                        .foregroundColor(.gray)
                        .padding(.top,10)
                    
                    VStack {
                        Text("Blood Group")
                            .font(.title2)
                            .bold()
                        ScrollView {
                            VStack {
                                ForEach(BloodTypeVM.publishedCountryModel,id:\.self) { button in
                                    HStack {
                                        Spacer().frame(width:30)
                                        Button(action: {
                                            self.SelectedBloodName = button.Name ?? ""
                                            self.SelectedBloodId = button.Id ?? 0
                                            IsPresented = false
                                        }, label: {
                                            HStack{
                                                Image(systemName:  SelectedBloodId == button.Id ?? 0 ? "checkmark.circle.fill" :"circle" )
                                                    .font(.system(size: 20))
                                                    .foregroundColor(SelectedBloodId == button.Id ?? 0 ? Color("blueColor") : Color("lightGray"))
                                                Text(button.Name ?? "")  .padding()
                                                    .foregroundColor(SelectedBloodId == button.Id ?? 0 ? Color("blueColor") : Color("lightGray"))
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
                                IsPresented.toggle()
                            }
                        })
                    }
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)

                    Spacer()
                }
                .padding(.top,10)
            }
            .padding(.bottom,hasNotch ? 300 : 230)

        }.onAppear(perform: {
//            BloodTypeVM.startFetchBloodTypes()
        })
            .offset(y: (UIScreen.main.bounds.size.height / 2)  - 80)
    }
}

struct ChooseBloodType_Previews: PreviewProvider {
    static var previews: some View {
        ChooseBloodType(IsPresented: .constant(true), SelectedBloodName: .constant(""), SelectedBloodId: .constant(0))
    }
}
