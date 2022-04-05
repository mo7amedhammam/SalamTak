//
//  ViewSearchDoc.swift
//  SalamTech
//
//  Created by wecancity on 05/04/2022.
//

import SwiftUI

struct ViewSearchDoc: View {
    @StateObject var medicalType = ViewModelExaminationTypeId()


    @State private var image = UIImage()
    @State var loginAgain = false
    var language = LocalizationService.shared.language
//    var CountryId : Int
    @State var index = 1

    @State var gotodoctorDetails = false
    @State var selectedCityId = 0

    
    
    var body: some View {
        ZStack{
        VStack{
            ScrollView( showsIndicators: false){
                Spacer().frame(height:120)
                HStack {
                    Text("Search Doctor")
                        .font(Font.SalamtechFonts.Bold18)
                    Spacer()
                }

             
            
//                ForEach(CitiesVM.publishedCityModel , id:\.self){ city in
//                            Button(action: {
//
//                            }, label: {
//
//                                ZStack {
//
//                                    HStack{
//                                        Spacer().frame(width:30)
//                                            Text(city.Name ?? "")
//                                                .frame(height:35)
//                                                .font(Font.SalamtechFonts.Reg18)
//                                                .foregroundColor(.black)
//                                        Spacer()
//                                        }
//
//                                        .frame(width: (UIScreen.main.bounds.width)-33, height: 50)
//                                        .background(Color.white)
//                                        .cornerRadius(25)
//                                        .shadow(color: .black.opacity(0.099), radius: 5)
//
//
////                                    HStack {
////                                        AsyncImage(url: URL(string:   URLs.BaseUrl + "\(specialityvm.publishedSpecialistModel?[speciality].image ?? "")" )) { image in
////
////                                            image.resizable()
////
////                                        } placeholder: {
////                                            Image("heart")
////                                                .resizable()
////                                        }
////                                        .clipShape(Circle())
////                                        .frame(width: 60, height: 60)
////                                        Spacer()
////                                    }.padding(.leading,5)
//
//
//
//                                }
//                            }) .frame(width: (UIScreen.main.bounds.width)-10)
//                                .background(Color.clear)
//                                .cornerRadius(8)
//                                .shadow(color: .black.opacity(0.099), radius: 5)
//
//
//
//
//
//                    }


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
                AppBarView(Title: "Search Doctor")
                    .navigationBarItems(leading: BackButtonView())
                    .navigationBarBackButtonHidden(true)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack( spacing: 10) {
                        // Swipe TabView
                        ForEach(medicalType.publishedModelExaminationTypeId){ type in
                          
                            if type.id==0{ }else{
                            
                            Button(action: {
                                withAnimation(.default) {


                                    self.index = type.id ?? 1
//                                    SchedualVM.serviceId = index

                                }
                                
                            }, label: {
                                HStack(alignment: .center){
                                    Text(type.Name ?? "")
                                        .font(Font.SalamtechFonts.Reg14)
                                        .foregroundColor(self.index == type.id ? Color("blueColor") : Color("lightGray"))
                                    
                                }.frame(minWidth: 100, maxWidth: 350)
                                .padding(10)
                                .padding(.bottom,1)
                                .background( Color(self.index == type.id ? "tabText" : "lightGray").opacity(self.index == type.id ? 1 : 0.3)
                                                .cornerRadius(3))
                                .clipShape(Rectangle())
                               
                                
                            })

                            
                            
                            }
                            }
                        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    
                    .padding(.top,35)
                }
                
                
                    Spacer()
            }
            .edgesIgnoringSafeArea(.vertical)

        }.onAppear(perform: {
//            CitiesVM.startFetchCities(countryid: CountryId)
        })

    }
    

    
}

struct ViewSearchDoc_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ViewSearchDoc()
        }.navigationBarHidden(true)
    }
}
