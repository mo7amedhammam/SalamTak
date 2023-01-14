//
//  ChooseSeniority.swift
//  SalamTak
//
//  Created by wecancity on 12/01/2023.
//
import SwiftUI

struct ChooseSeniority : View {
    var language = LocalizationService.shared.language

    @StateObject var SeniorityVM = ViewModelSeniority()
    @Binding var IsPresented: Bool
    @Binding var SelectedSeniorityName: String
    @Binding var SelectedSeniorityId: Int

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
                        Text("Seniority_".localized(language))
                            .font(.title2)
                            .bold()
                        ScrollView {
                            VStack {
                                ForEach(SeniorityVM.publishedSeniorityLevelModel,id:\.self) { button in
                                    HStack {
                                        Spacer().frame(width:30)
                                        Button(action: {
                                            self.SelectedSeniorityName = button.Name ?? ""
                                            self.SelectedSeniorityId = button.id ?? 0
                                            IsPresented = false
                                        }, label: {
                                            HStack{
                                                Image(systemName:  SelectedSeniorityId == button.id ?? 0 ? "checkmark.circle.fill" :"circle" )
                                                    .font(.system(size: 20))
                                                    .foregroundColor(SelectedSeniorityId == button.id ?? 0 ? Color("blueColor") : Color("lightGray"))
                                                Text(button.Name ?? "")  .padding()
                                                    .foregroundColor(SelectedSeniorityId == button.id ?? 0 ? Color("blueColor") : Color("lightGray"))
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

struct ChooseSeniority_Previews: PreviewProvider {
    static var previews: some View {
        ChooseSeniority(IsPresented: .constant(true), SelectedSeniorityName: .constant(""), SelectedSeniorityId: .constant(0))
    }
}

