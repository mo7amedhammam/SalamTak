//
//  CountryView.swift
//  SalamTech
//
//  Created by wecancity on 04/04/2022.
//

import Foundation

import SwiftUI


struct CountryView: View {
    @StateObject var NationalityVM = ViewModelCountries()

    @State private var image = UIImage()
    @State var loginAgain = false
    var language = LocalizationService.shared.language
    @State var gotocity = false
    @State var selectedCountryId = 0

    @State var gotoSearchdoctor = false

    var body: some View {
        ZStack{
        VStack{
            ScrollView( showsIndicators: false){
                Spacer().frame(height:120)
                HStack {
                    Text("Choose your Governorate")
                        .font(Font.SalamtechFonts.Bold18)
                    Spacer()
                }

                Button(action: {
                    selectedCountryId = 0
                    gotoSearchdoctor=true
                }, label: {
                    
                    ZStack {

                        HStack{
                            Spacer().frame(width:30)
                                Text("All Governorates")
                                    .frame(height:35)
                                    .font(Font.SalamtechFonts.Reg18)
                                    .foregroundColor(.black)
                            Spacer()
                            }
                            
                            .frame(width: (UIScreen.main.bounds.width)-33, height: 50)
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(color: .black.opacity(0.099), radius: 5)
                    }
                }) .frame(width: (UIScreen.main.bounds.width)-10)
                    .background(Color.clear)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.099), radius: 5)
            

                ForEach(NationalityVM.publishedCountryModel , id:\.self){ Country in
                            Button(action: {
                                selectedCountryId = Country.Id ?? 45454545454545454
                                gotocity=true
                            }, label: {
                                
                                ZStack {

                                    HStack{
                                        Spacer().frame(width:30)
                                            Text(Country.Name ?? "")
                                                .frame(height:35)
                                                .font(Font.SalamtechFonts.Reg18)
                                                .foregroundColor(.black)
                                        Spacer()
                                        }
                                        
                                        .frame(width: (UIScreen.main.bounds.width)-33, height: 50)
                                        .background(Color.white)
                                        .cornerRadius(25)
                                        .shadow(color: .black.opacity(0.099), radius: 5)

                                    
//                                    HStack {
//                                        AsyncImage(url: URL(string:   URLs.BaseUrl + "\(specialityvm.publishedSpecialistModel?[speciality].image ?? "")" )) { image in
//
//                                            image.resizable()
//
//                                        } placeholder: {
//                                            Image("heart")
//                                                .resizable()
//                                        }
//                                        .clipShape(Circle())
//                                        .frame(width: 60, height: 60)
//                                        Spacer()
//                                    }.padding(.leading,5)


                                    
                                }
                            }) .frame(width: (UIScreen.main.bounds.width)-10)
                                .background(Color.clear)
                                .cornerRadius(8)
                                .shadow(color: .black.opacity(0.099), radius: 5)
 
                    }


            }.background(Color.clear)
                .padding([.horizontal])
            
            
            Spacer()
        }
            
        .frame(width: UIScreen.main.bounds.width)
        .edgesIgnoringSafeArea(.vertical)
        .background(Color("CLVBG"))
        .onAppear(perform: {
            NationalityVM.startFetchCountries()
        })
        
            VStack{
                AppBarView(Title: "Choose Governorate")
                    .navigationBarItems(leading: BackButtonView())
                    .navigationBarBackButtonHidden(true)
                    Spacer()
            }
            .edgesIgnoringSafeArea(.vertical)

        }

        
        
        //  go to clinic info
        NavigationLink(destination:CityView( CountryId: selectedCountryId),isActive: $gotocity) {
              }
        //  go to clinic info
         NavigationLink(destination:ViewSearchDoc(),isActive: $gotoSearchdoctor) {
              }

    }
    

    
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CountryView( selectedCountryId: 1212121212121212)
        }.navigationBarHidden(true)
    }
}
