//
//  CityView.swift
//  SalamTech
//
//  Created by wecancity on 04/04/2022.

import SwiftUI


struct CityView: View {
    @StateObject var CitiesVM = ViewModelGetCities()

    @State private var image = UIImage()
    @State var loginAgain = false
    var language = LocalizationService.shared.language
    var CountryId : Int

    @State var gotoSearchdoctor = false
    @State var selectedCityId = 0

    
    
    var body: some View {
        ZStack{
        VStack{
            ScrollView( showsIndicators: false){
                Spacer().frame(height:120)
                HStack {
                    Text("Choose your City")
                        .font(Font.SalamtechFonts.Bold18)
                    Spacer()
                }

                Button(action: {
                    selectedCityId = 0
                    gotoSearchdoctor=true
                }, label: {
                    
                    ZStack {

                        HStack{
                            Spacer().frame(width:30)
                                Text("All Cities")
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
            
                ForEach(CitiesVM.publishedCityModel , id:\.self){ city in
                            Button(action: {

                            }, label: {
                                
                                ZStack {

                                    HStack{
                                        Spacer().frame(width:30)
                                            Text(city.Name ?? "")
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

        })
        
            VStack{
                AppBarView(Title: "Choose City")
                    .navigationBarItems(leading: BackButtonView())
                    .navigationBarBackButtonHidden(true)
                    Spacer()
            }
            .edgesIgnoringSafeArea(.vertical)

        }.onAppear(perform: {
            CitiesVM.startFetchCities(countryid: CountryId)
        })

    }
    

    
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CityView( CountryId: 565656656)
        }.navigationBarHidden(true)
    }
}
