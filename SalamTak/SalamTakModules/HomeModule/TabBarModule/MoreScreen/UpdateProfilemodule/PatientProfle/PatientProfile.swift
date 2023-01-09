//
//  PatientProfile.swift
//  SalamTech-DR
//
//  Created by wecancity agency on 3/21/22.
//

import SwiftUI

struct PatientProfile: View {
    var language = LocalizationService.shared.language
    @State var index = 0 // 0:profile 1:medical
//    @EnvironmentObject  var infoProfileVM : PatientInfoViewModel
//    @EnvironmentObject  var medicalProfileVM : PatientMedicalInfoViewModel
    @EnvironmentObject  var environments : EnvironmentsVM

    var body: some View {
        ZStack{
            VStack(spacing:0){
                AppBarView(Title:"Doctor_Profile".localized(language))
                    .frame(height:55)
                        HStack( spacing: 20){
                            Button(action: {
                                withAnimation{
                                    self.index = 0
                                    print(index)
                                }
                            }, label: {
                                HStack(alignment: .center){
                                    Text("Profile")
                                        .font(.system(size: 15))
                                        .foregroundColor(self.index == 0 ? Color("blueColor") : Color("lightGray"))
                                }
                                .frame(minWidth: 120)
                                .frame( height: 40)
                                .background( Color(self.index == 0 ? "tabText" : "lightGray").opacity(self.index == 0  ? 1 : 0.3)
                                                .cornerRadius(8))
                                .clipShape(Rectangle())
                            })
                            Button(action: {
                                withAnimation{
                                    self.index = 1
                                    print(index)
                                }
                            }, label: {
                                HStack(alignment: .center){
                                    Text("Medical State")
                                        .font(.system(size: 15))
                                        .foregroundColor(self.index == 1 ? Color("blueColor") : Color("lightGray"))
                                }
                                .frame(minWidth: 120)
                                .frame( height: 40)
                                .background( Color(self.index == 1 ? "tabText" : "lightGray").opacity(self.index == 1  ? 1 : 0.3)
                                                .cornerRadius(8))
                                .clipShape(Rectangle())
                            })
                        }
                TabView (selection: self.$index){
                    ZStack{
                        PatientInfoView(taskOP: .update,index: $index)
//                            .environmentObject(infoProfileVM)
                            .environmentObject(environments)
                    }
                    .tag(0)
                    ZStack{
                        PatientMedicalInfoView(taskOP: .update, index: $index)
//                        .environmentObject(medicalProfileVM)
                        .environmentObject(environments)

                    }
                    .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)

    }
}

struct PatientProfile_Previews: PreviewProvider {
    static var previews: some View {
        PatientProfile()
            .environmentObject(PatientInfoViewModel())
            .environmentObject(PatientMedicalInfoViewModel())
    }
}
