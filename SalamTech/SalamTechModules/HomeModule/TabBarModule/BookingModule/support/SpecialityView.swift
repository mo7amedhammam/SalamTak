//
//  SpecialityView.swift
//  SalamTech
//
//  Created by wecancity on 04/04/2022.
//

import Foundation
import SwiftUI


struct SpecialityView: View {
    @StateObject var specialityvm = ViewModelSpecialist()
    
    @State private var image = UIImage()
    @State var loginAgain = false
    var language = LocalizationService.shared.language
    @State var gotocountry = false

    
    var body: some View {
        ZStack{
        VStack{
            ScrollView( showsIndicators: false){
                Spacer().frame(height:120)
                HStack {
                    Text("Specialities")
                        .font(Font.SalamtechFonts.Bold18)
                    Spacer()
                }

                ForEach(0..<(specialityvm.publishedSpecialistModel?.count ?? 0)  , id:\.self){ speciality in
                            Button(action: {
                                gotocountry=true

                            }, label: {
                                
                                ZStack {

                                    HStack{
                                        Spacer().frame(width:80)
                                            Text(specialityvm.publishedSpecialistModel?[speciality].Name ?? "")
                                                .frame(height:35)
                                                .font(Font.SalamtechFonts.Reg18)
                                                .foregroundColor(.black)
                                        Spacer()
                                        }
                                        
                                        .frame(width: (UIScreen.main.bounds.width)-33, height: 55)
                                        .background(Color.white)
                                        .cornerRadius(25)
                                        .shadow(color: .black.opacity(0.099), radius: 5)

                                    
                                    HStack {
                                        AsyncImage(url: URL(string:   URLs.BaseUrl + "\(specialityvm.publishedSpecialistModel?[speciality].image ?? "")" )) { image in

                                            image.resizable()

                                        } placeholder: {
                                            Image("heart")
                                                .resizable()
                                        }
                                        .clipShape(Circle())
                                        .frame(width: 60, height: 60)
                                        Spacer()
                                    }.padding(.leading,5)


                                    
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
                AppBarView(Title: "Choose Speciality")
                    .navigationBarItems(leading: BackButtonView())
                    .navigationBarBackButtonHidden(true)
                    Spacer()
            }
            .edgesIgnoringSafeArea(.vertical)

        }

        
        //  go to clinic info
         NavigationLink(destination:CountryView(),isActive: $gotocountry) {
              }
    }
    

    
}

struct SpecialityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SpecialityView()
        }.navigationBarHidden(true)
    }
}
