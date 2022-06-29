//
//  ChooseNationalityView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 04/04/2022.
//

import SwiftUI

struct ChooseNationality : View {
    var language = LocalizationService.shared.language
    @ObservedObject var patientCreatedVM = ViewModelCreatePatientProfile()
    @EnvironmentObject var NationalityVM : ViewModelCountries

    @Binding var IsPresented: Bool
    @State public var buttonSelected: Int?
    
    @Binding var SelectedNationalityName: String
    @Binding var SelectedNationalityId: Int
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
                            Text("CompeleteProfile_Screen_Nationality".localized(language))
                                .font(.title2)
                                .bold()
                            ScrollView {
                                ForEach(NationalityVM.publishedCountryModel,id:\.self) { button in
                                    HStack {
                                        Spacer().frame(width:30)
                                        Button(action: {
                                            self.SelectedNationalityName = button.Name ?? ""
                                            self.SelectedNationalityId = button.Id ?? 0
                                            patientCreatedVM.NationalityName = SelectedNationalityName
                                            patientCreatedVM.NationalityId = SelectedNationalityId
                                            IsPresented =  false
                                        }, label: {
                                            HStack{
                                                Image(systemName:  self.SelectedNationalityId == button.Id ?? 0 ? "checkmark.circle.fill" :"circle" )
                                                    .font(.system(size: 20))
                                                    .foregroundColor(self.SelectedNationalityId == button.Id ?? 0 ? Color("blueColor") : Color("lightGray"))
                                                Text(button.Name ?? "")  .padding()
                                                    .foregroundColor(SelectedNationalityId == button.Id ? Color("blueColor") : Color("lightGray"))
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
                                patientCreatedVM.NationalityName = SelectedNationalityName
                                patientCreatedVM.NationalityId = SelectedNationalityId
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
            NationalityVM.startFetchCountries()
        })
        .offset(y: (UIScreen.main.bounds.size.height / 2)  - 120)
    }
}

struct ChooseNationality_Previews: PreviewProvider {
    static var previews: some View {
        ChooseNationality( IsPresented: .constant(true), SelectedNationalityName: .constant(""), SelectedNationalityId: .constant(0), width: CGFloat(150) ).environmentObject(ViewModelCountries())
    }
}
