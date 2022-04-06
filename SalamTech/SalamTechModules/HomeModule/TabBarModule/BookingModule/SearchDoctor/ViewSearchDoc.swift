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

    
    init() {
            UITableView.appearance().showsVerticalScrollIndicator = false
        }

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
            
            List( ){

              

//                LazyVStack(spacing:15){
                    ForEach(0..<5){_ in
                    VStack(alignment:.leading){
                        HStack{
                           Image("logo")
                                .resizable()
                                .frame(width:70)
                                .background(Color.gray)
                                .cornerRadius(9)
                                
                                
                            VStack(alignment:.leading){
                                HStack{
                                    Text("Dr/ ").foregroundColor(.black.opacity(0.7))
                                    Text("Mohamed hammam").font(Font.SalamtechFonts.Bold18)

                                }
                                
                                HStack{
                                    Text("Psychiatry")
                                        .foregroundColor(.gray.opacity(0.7))
                                        .font(Font.SalamtechFonts.Reg14)
                                    Text(".")
                                        .foregroundColor(.gray.opacity(0.8))
                                        .font(Font.system(size:30, design: .serif))
                                        .fontWeight(.bold).offset(y:-8)
                                    Text("Fellow of Surgeons R...")
                                        .foregroundColor(.gray.opacity(0.7))
                                        .font(Font.SalamtechFonts.Reg14)
                                }
                                HStack{
                                    ForEach(0..<5){_ in
                                        Image(systemName: "star.fill") // Imagenames: star || star.fill || star.leadinghalf.filled
                                            .foregroundColor(.yellow)
                                    }
                                    
//                                    Image(systemName: "star.fill")
//                                        .foregroundColor(.yellow)
//                                    Image(systemName: "star.fill")
//                                        .foregroundColor(.yellow)
//                                    Image(systemName: "star.fill")
//                                        .foregroundColor(.yellow)
//                                    Image(systemName: "star.leadinghalf.filled")
//                                        .foregroundColor(.yellow)
//                                    Image(systemName:"star")
//                                        .foregroundColor(.yellow)
//
                                    Text("( 224 Patients )")
                                        .foregroundColor(.black.opacity(0.7))
                                        .font(Font.SalamtechFonts.Reg14)
                                }
                            }

                            Spacer()

                        }
                        .padding(10)
                        .frame(height:115)
                        
                        VStack(spacing:0){
                        HStack{
                            Image("doc1")
                            Text("Dentist")
                                .foregroundColor(Color("darkGreen"))
                                .font(Font.SalamtechFonts.Reg14)
                            Text("Specialized in ")
                                .foregroundColor(.secondary)
                                .font(Font.SalamtechFonts.Reg14)
                            Text("Endodontics, Cosmetic...")
                                .foregroundColor(Color("darkGreen"))
                                .font(Font.SalamtechFonts.Reg14)
                            Spacer()
                        }.padding(.leading)
                        VStack (spacing:0){
                            HStack{
                                Image("doc2")
                                Text("Better Life Dental Center:")
                                    .foregroundColor(Color("darkGreen"))
                                    .font(Font.SalamtechFonts.Reg14)
                                Spacer()
                                
                            }
                            Text("6th of October: 4th district, above KFC")
                                .foregroundColor(.secondary)
                                .font(Font.SalamtechFonts.Reg14)
                        }
                        .padding(.leading)
                        

                        HStack{
                            Image("doc3")
                            Text("Fees:")
                                .foregroundColor(Color("darkGreen"))
                                .font(Font.SalamtechFonts.Reg14)
                            Text("200 to 400 EGP (Upon time & date)")
                                .foregroundColor(.secondary)
                                .font(Font.SalamtechFonts.Reg14)
                        
                            Spacer()
                        }.padding(.leading)
                        
                        HStack{
                            Image("doc4")
                            Text("Waiting Time:")
                                .foregroundColor(Color("darkGreen"))
                                .font(Font.SalamtechFonts.Reg14)
                            Text("15 Minutes")
                                .foregroundColor(.secondary)
                                .font(Font.SalamtechFonts.Reg14)
                        
                            Spacer()
                        }.padding(.leading)
                    }
                     
                        
                        Text(" Available Today From 07:00 PM ")
                            .frame(width: UIScreen.main.bounds.width - 40, height: 35, alignment: .center)
                            .background(Color.gray.opacity(0.3))
                            .foregroundColor(.black.opacity(0.7))
                            .font(Font.SalamtechFonts.Reg14)
                        
                        HStack{
                            Spacer()
                            Image("exClinic")
                            Image("exHome")
                            Image("exCall")
                            Spacer()
                            Button(action: {
                            print("Book")
                            }, label: {
                                HStack{

                                    Text("Book")
                                        .foregroundColor(.white)
                                        .font(Font.SalamtechFonts.Bold14)
                                        .padding([.leading,.trailing],40)

                                    
                            }
                            }
                            )

                                .padding(.horizontal,15)
                                .frame( height: 40 )

                                .background(Color("blueColor"))
                                .cornerRadius(8)
                            
                            Spacer()

                            
                        }.padding(.bottom,10)
                        
                    }
                        
                    .background(Color.white)
                    .cornerRadius(9)
                    .shadow(color: .black.opacity(0.1), radius: 9)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    }
                   

            }
            .listStyle(.plain)

            .padding(.top,0)
//            .background(Color.red)


            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
        .edgesIgnoringSafeArea(.vertical)
        .background(Color("CLVBG"))
        
        
            VStack{
                AppBarView(Title: "Search a Doctor")
                    .navigationBarItems(leading: BackButtonView())
                    .navigationBarBackButtonHidden(true)
                    Spacer()
            }
            .edgesIgnoringSafeArea(.vertical)

        }
        .onAppear(perform: {
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
 
