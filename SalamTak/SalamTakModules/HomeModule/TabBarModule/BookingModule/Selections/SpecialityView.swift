//
//  SpecialityView.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 04/04/2022.
//

import Foundation
import SwiftUI

struct SpecialityView: View {
    @StateObject var specialityvm = ViewModelSpecialist()
    @EnvironmentObject var environments : EnvironmentsVM
    var language = LocalizationService.shared.language
    @State var gotocity = false
    
    @Binding var selectedTypeId : Int
    @State var selectedSpecialityId  = 0
    @State var selectedSpecialityName  = ""

    var body: some View {
//        NavigationView{
            ZStack{
                VStack{
                    AppBarView(Title: "Choose_Speciality".localized(language),withbackButton: true)
                        .frame(height:70)
                        .padding(.top,-20)
                ScrollView( showsIndicators: false){
//                    Spacer().frame(height:120)
                    HStack {
                        Text("SpecialitiesـSubTitle".localized(language))
                            .foregroundColor(.salamtackBlue)
                            .font(.salamtakBold(of: 18))
                        Spacer()
                    }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    ForEach(0..<(specialityvm.publishedSpecialistModel?.count ?? 0)  , id:\.self){ speciality in
                        Button(action: {
                            selectedSpecialityId = specialityvm.publishedSpecialistModel?[speciality].id ?? 1212113115
                            selectedSpecialityName = specialityvm.publishedSpecialistModel?[speciality].Name ?? ""
                            gotocity=true
                        }, label: {
                            SpecialityBuBody(speciality:specialityvm.publishedSpecialistModel?[speciality] ?? Speciality.init())
                        }) .frame(width: (UIScreen.main.bounds.width)-10)
                            .background(Color.clear)
                            .cornerRadius(8)
                            .shadow(color: .black.opacity(0.099), radius: 5)
                        
                    }
                }.background(Color.clear)
                    .padding([.horizontal])
                    .frame(width: UIScreen.main.bounds.width)
//                    .edgesIgnoringSafeArea(.vertical)
//                    .background(Color("CLVBG"))
                
             
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width)
    //            .edgesIgnoringSafeArea(.vertical)
                .background(Color("CLVBG"))

//                .edgesIgnoringSafeArea(.vertical)
                
                // showing loading indicator
                ActivityIndicatorView(isPresented: $specialityvm.isLoading)


                //        //  go to clinic info
                NavigationLink(destination:CityView(CountryId:1, SelectedSpeciality:$selectedSpecialityId, SelectedSpecialityName: $selectedSpecialityName, extypeid: $selectedTypeId)
                                .environmentObject(environments)
                                .navigationBarHidden(true),isActive: $gotocity) {
                        }
            }
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear(perform: {
                specialityvm.startFetchSpecialist()
        })


        .alert(isPresented: $specialityvm.isAlert, content: {
            Alert(title: Text(specialityvm.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                specialityvm.isAlert = false
            }))
        })
//    }
    }
}

struct SpecialityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SpecialityView (selectedTypeId: .constant(54545454), selectedSpecialityId: 1212115)
        }.navigationBarHidden(true)
    }
}


