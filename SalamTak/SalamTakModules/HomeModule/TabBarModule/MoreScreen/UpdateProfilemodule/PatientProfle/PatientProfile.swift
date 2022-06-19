//
//  PatientProfile.swift
//  SalamTech-DR
//
//  Created by wecancity agency on 3/21/22.
//

import SwiftUI

struct PatientProfile: View {
    var language = LocalizationService.shared.language
    @State var index = 0
    var body: some View {
        ZStack{
            VStack{
                ZStack {
                    ZStack {
                        Image("underappbar")
                            .resizable()
                            .frame(height: 150)
                            .padding(.bottom, -40)
                        
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
                        }.frame( height: 80, alignment: .center)
                            .padding()
                            .offset(y: 25)
                        
                    }.offset(y: 80)
                    AppBarView(Title:"Doctor_Profile".localized(language))
                        .offset(y:-10)
                }
                Spacer().frame(height: 90)
                TabView (selection: self.$index){
                    ZStack{
                        UpdatePersonalDataView()
                    }
                    .padding(15)
                    .tag(0)
                    ZStack{
                        UpdateMedicalStateView()
                    }
                    .padding(15)
                    .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
            }
            .edgesIgnoringSafeArea(.bottom)
            .ignoresSafeArea()
            .background(Color("CLVBG"))
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:  BackButtonView())
        
    }
}

struct PatientProfile_Previews: PreviewProvider {
    static var previews: some View {
        PatientProfile()
    }
}
