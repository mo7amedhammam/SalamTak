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
    var language = LocalizationService.shared.language
    @State var gotocity = false
    
    @Binding var selectedTypeId : Int
    @State var selectedSpecialityId  = 0
    
    var body: some View {
            ZStack{
                ScrollView( showsIndicators: false){
                    Spacer().frame(height:120)
                    HStack {
                        Text("SpecialitiesـSubTitle".localized(language))
                            .font(Font.SalamtechFonts.Bold18)
                        Spacer()
                    }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    ForEach(0..<(specialityvm.publishedSpecialistModel?.count ?? 0)  , id:\.self){ speciality in
                        Button(action: {
                            selectedSpecialityId = specialityvm.publishedSpecialistModel?[speciality].id ?? 1212113115
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
                    .edgesIgnoringSafeArea(.vertical)
                    .background(Color("CLVBG"))
                
                VStack{
                    AppBarView(Title: "Choose_Speciality".localized(language))
                    
                        .navigationBarItems(leading: BackButtonView())
                        .navigationBarBackButtonHidden(true)
                    Spacer()
                }
                .edgesIgnoringSafeArea(.vertical)
                
                // showing loading indicator
                ActivityIndicatorView(isPresented: $specialityvm.isLoading)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear(perform: {
                specialityvm.startFetchSpecialist()
        })

        //  go to clinic info
        NavigationLink(destination:CityView(CountryId:1, SelectedSpeciality:$selectedSpecialityId, extypeid: $selectedTypeId),isActive: $gotocity) {
        }
        .alert(isPresented: $specialityvm.isAlert, content: {
            Alert(title: Text(specialityvm.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                specialityvm.isAlert = false
            }))
        })
    }
}

struct SpecialityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SpecialityView (selectedTypeId: .constant(54545454), selectedSpecialityId: 1212115)
        }.navigationBarHidden(true)
    }
}


