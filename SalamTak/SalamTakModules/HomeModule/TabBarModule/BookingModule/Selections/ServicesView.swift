//
//  ServicesView.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 04/04/2022.
//

import SwiftUI
import Alamofire


struct ServicesView: View {
    @StateObject var medicalType = ViewModelExaminationTypeId()
    @EnvironmentObject var environments : EnvironmentsVM
    var language = LocalizationService.shared.language
    var vGridLayout = [ GridItem(.adaptive(minimum: 90), spacing: 20) ]
    @State var gotoSpec = false
    @State var selectedTypeId = 0

    var body: some View {
//        NavigationView {
            ZStack{
                    VStack{
                        Spacer().frame(height:30)
                                AsyncImage(url: URL(string:  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR05Cf6YGBs9SAvvEwW22wHVjeLTm9HmVJEWd0KjyiSySHuLDQCH5VVc0wvxtHCJvVOKSY&usqp=CAU" )) { image in
                                    image.resizable()
                                } placeholder: {
                                    Image("logo")
                                        .resizable()
                                }
                                .foregroundColor(.black)
                                .frame( height: 115)
                                .cornerRadius(8)
                                .scaledToFit()
                        Spacer().frame(height:20)
                        ScrollView( showsIndicators: false){
                            HStack {
                                Text("Our_Services".localized(language))
                                    .foregroundColor(.salamtackBlue)
                                    .font(.salamtakBold(of: 18))
                                    .frame(alignment: .bottom)
                                Spacer()
                            }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                            
                            LazyVGrid(columns: vGridLayout){
                                ForEach(medicalType.publishedModelExaminationTypeId, id:\.self) { exType in
                                    ZStack {
                                        Button(action: {
                                            selectedTypeId = exType.id ?? 11212121212121
                                            gotoSpec=true
                                        }, label: {
                                            VStack{
                                                AsyncImage(url: URL(string:   URLs.BaseUrl + "\(exType.image ?? "")" )) { image in
                                                    image.resizable()
                                                } placeholder: {
                                                    Image("logo")
                                                        .resizable()
                                                }
                                                .frame(width: 60, height: 60)
                                                .foregroundColor(.black)

                                                Text(exType.Name?.firstWord ?? "")
//                                                    .padding(.vertical,10)
                                                    .foregroundColor(.salamtackBlue)
                                                    .font(.salamtakBold(of: 18))
                                            }
                                        })
                                            .frame(width: (UIScreen.main.bounds.width/3)-20, height: 120)
                                            .background(Color.white)
                                            .cornerRadius(8)
                                            .shadow(color: .black.opacity(0.099), radius: 5)
                                            .disabled(exType.Inactive ?? false)
                                    }.overlay(content: {
                                        if  (exType.Inactive ?? false){
                                        Color.white.opacity(0.2)
                                        }
                                    })
                                }
                            }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                            .padding(.horizontal)
                        }.background(Color.clear)
                            .padding(.bottom,20)
                    }
                    .padding(.horizontal)
                    .padding(.top,100)
                
    //MARK: ----- Top View Title -----
                VStack{
                AppBarLogoView(imageName: "barlogo")
                Spacer()
            }
                // showing loading indicator
                ActivityIndicatorView(isPresented: $medicalType.isLoading)
                
                //  go to clinic info
                NavigationLink(destination:SpecialityView( selectedTypeId: $selectedTypeId).environmentObject(environments)
                                .navigationBarHidden(true),isActive: $gotoSpec) {
                      }
            }
            .frame(width: UIScreen.main.bounds.width)
            .edgesIgnoringSafeArea(.top)
            .background(Color("CLVBG"))
            .onAppear(perform: {
                medicalType.GetExaminationTypeId()
        })
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        
        .alert(isPresented: $medicalType.isAlert, content: {
            Alert(title: Text(medicalType.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                medicalType.isAlert = false
            }))
        })
    }
}

struct ServicesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ServicesView()
        }.navigationBarHidden(true)
    }
}
