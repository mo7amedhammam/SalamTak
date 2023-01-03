//
//  ChooseNationalityView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 04/04/2022.
//

import SwiftUI

struct ChooseNationality : View {
    var language = LocalizationService.shared.language
    @StateObject var NationalityVM = ViewModelCountries()
    @Binding var IsPresented: Bool
    @State public var buttonSelected: Int?
    @Binding var SelectedNationalityName: String
    @Binding var SelectedNationalityId: Int

    var body: some View {
    
        ZStack {
            RoundedRectangle(cornerRadius: 40.0)
                .foregroundColor(.white)
                .shadow(radius: 15)
            
            VStack(spacing:0) {
                    Capsule()
                        .frame(width: 50, height: 4)
                        .foregroundColor(.gray)
                        .padding(.top,10)
                            VStack {
                                Text("CompeleteProfile_Screen_Nationality".localized(language))
                                    .font(.title2)
                                    .bold()
                                ScrollView {
                                    
                                    VStack {
                                        ForEach(NationalityVM.publishedCountryModel,id:\.self) { button in
                                            HStack {
                                                Spacer().frame(width:30)
                                                Button(action: {
                                                    self.SelectedNationalityName = button.Name ?? ""
                                                    self.SelectedNationalityId = button.Id ?? 0
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
                            .frame(width: UIScreen.main.bounds.width)

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

        }
        .onAppear(perform: {
            NationalityVM.startFetchCountries()
        })
        .offset(y: (UIScreen.main.bounds.size.height / 2)  - 80)

    }
}

struct ChooseNationality_Previews: PreviewProvider {
    static var previews: some View {
        ChooseNationality( IsPresented: .constant(true), SelectedNationalityName: .constant(""), SelectedNationalityId: .constant(0) )
    }
}
