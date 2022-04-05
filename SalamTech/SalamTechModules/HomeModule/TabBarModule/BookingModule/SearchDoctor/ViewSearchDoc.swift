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
            
            
            VStack {
                Spacer().frame(height:100)
                ZStack {
                    Image("WhiteCurve")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height: 120)
                        .padding(.top,-20)

                    SearchBar(PlaceHolder:"Search a doctor... ",text: .constant("")).shadow(color: .black.opacity(0.2), radius: 15)
                    
                }
            }

            ScrollView( showsIndicators: false){
//                Spacer().frame(height:60)

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
//                        .padding(.top,5)
                        .padding(.horizontal)
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


            }
            
            .background(Color.clear)
//                .padding([.horizontal])


            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
        .edgesIgnoringSafeArea(.vertical)
        .background(Color("CLVBG"))
//        .background(.red)

        .onAppear(perform: {

        })
        
            VStack{
                AppBarView(Title: "Search a Doctor")
                    .navigationBarItems(leading: BackButtonView())
                    .navigationBarBackButtonHidden(true)
                    Spacer()
            }
            .edgesIgnoringSafeArea(.vertical)

        }
        .onAppear(perform: {
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




struct SearchBar: View {
    var PlaceHolder = ""
    @Binding var text: String
 
    @State private var isEditing = false

    var body: some View {
        HStack {
 
            TextField(PlaceHolder, text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
 
//            if isEditing {
//                Button(action: {
//                    self.isEditing = false
//                    self.text = ""
//
//                }) {
//                    Text("Cancel")
//                }
//                .padding(.trailing, 10)
//                .transition(.move(edge: .trailing))
//                .animation(.default)
//            }
        }
        
        .overlay(
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 15)
         
                if isEditing {
                    Button(action: {
                        self.text = ""
                        self.isEditing = false
                        UIApplication.shared.dismissKeyboard()
                        }) {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 15)
                    }
                }
            }
        )
    }
}

extension UIApplication {
      func dismissKeyboard() {
          sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
      }
  }
 
