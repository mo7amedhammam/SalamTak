//
//  ServicesView.swift
//  SalamTech
//
//  Created by wecancity on 04/04/2022.
//

import SwiftUI


struct ServicesView: View {
    @StateObject var medicalType = ViewModelExaminationTypeId()
//    @StateObject var specialityvm = ViewModelSpecialist()
    @StateObject var searchDoc = VMSearchDoc()

    @State private var image = UIImage()
    @State private var radius: CGFloat = .zero
    @State var loginAgain = false
    var language = LocalizationService.shared.language
    var vGridLayout = [ GridItem(.adaptive(minimum: 90), spacing: 30) ]
    @State var counter = 0
    @State var gotoSpec = false
    @State var selectedTypeId = 0

    
    
    var body: some View {
        NavigationView{
        VStack{
            AppBarLogoView(imageName: "barlogo")
            Spacer().frame(height:30)
            
            ScrollView( showsIndicators: false){
                HStack {
                    Text("Our Services")
                        .font(Font.SalamtechFonts.Bold18)
                    Spacer()
                }
                
                LazyVGrid(columns: vGridLayout){
                    ForEach(medicalType.publishedModelExaminationTypeId) { exType in
                        
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
                                    .clipShape(Circle())
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.black)
//                                        .background(.blue)
                                    

                                    
                                    Text(exType.Name ?? "")
                                        .padding(.vertical,10)
                                        .foregroundColor(.black)
                                }
                            })
                                .frame(width: (UIScreen.main.bounds.width/3)-20, height: 120)
                                .background(Color.white)
                                .cornerRadius(8)
                                .shadow(color: .black.opacity(0.099), radius: 5)
                        }
                    }
                                        
                }
                .padding(.horizontal,13)
                
//                HStack {
//                    Text("Specialities")
//                        .font(Font.SalamtechFonts.Bold18)
//                    Spacer()
//                    Button(action: {
//
//                    }, label: {
//                        Text("See All")
//                            .font(Font.SalamtechFonts.Reg14)
//                    })
//                }
//
//                LazyVGrid(columns: vGridLayout){
//
//
//                    ForEach(0..<5  , id:\.self){ speciality in
//
//                        ZStack {
//                            Button(action: {
//
//                            }, label: {
//                                ZStack {
//                                    VStack{
//                                        Spacer()
//                                        Text(specialityvm.publishedSpecialistModel?[speciality].Name ?? "")
//                                            .frame(height:35)
//                                            .font(Font.system(size: 13))
//                                            .foregroundColor(.black)
//                                    }
//                                    .frame(width: (UIScreen.main.bounds.width/3)-20, height: 60)
//                                    .background(Color.white)
//                                    .cornerRadius(8)
//                                    .shadow(color: .black.opacity(0.099), radius: 5)
//
//                                    AsyncImage(url: URL(string:   URLs.BaseUrl + "\(specialityvm.publishedSpecialistModel?[speciality].image ?? "")" )) { image in
//
//                                        image.resizable()
//
//                                    } placeholder: {
//                                        Image("heart")
//                                            .resizable()
//                                    }
//                                    .frame(width: 60, height: 60)
//                                    .padding(.top,-60)
//
////                                    Image("heart")
////                                        .resizable()
////                                        .frame(width: 60, height: 60)
////                                        .padding(.top,-60)
//
//                                }
//                            }) .frame(width: (UIScreen.main.bounds.width/3)-20, height: 120)
//                                .background(Color.clear)
//                                .cornerRadius(8)
//                                .shadow(color: .black.opacity(0.099), radius: 5)
//                        }
//
//                        if speciality == 4 {
//                            ZStack {
//                                Button(action: {
//
//                                }, label: {
//                                    ZStack {
//                                        VStack{
//                                            Spacer()
//                                            Text("View All")
//                                                .frame(height:35)
//                                                .font(Font.system(size: 13))
//                                                .foregroundColor(.black)
//                                        }
//                                        .frame(width: (UIScreen.main.bounds.width/3)-20, height: 60)
//                                        .background(Color.white)
//                                        .cornerRadius(8)
//                                        .shadow(color: .black.opacity(0.099), radius: 5)
//
//                                        ZStack {
//                                            Image("morecount")
//                                                .resizable()
//                                                .frame(width: 60, height: 60)
//                                            Text("+ \((specialityvm.publishedSpecialistModel?.count ?? 0) - 5)")
//                                        }
//                                        .padding(.top,-60)
//
//                                    }
//                                }) .frame(width: (UIScreen.main.bounds.width/3)-20, height: 120)
//                                    .background(Color.clear)
//                                    .cornerRadius(8)
//                                    .shadow(color: .black.opacity(0.099), radius: 5)
//                            }
//                        }
//
//
//                    }
//
//                } .padding(.horizontal,13)
//
            }.background(Color.clear)
                .padding([.horizontal])
            
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
        .edgesIgnoringSafeArea(.top)
        .background(Color("CLVBG"))
        .onAppear(perform: {

        })
        
           
        }
       //  go to clinic info
        NavigationLink(destination:SpecialityView( selectedTypeId: selectedTypeId),isActive: $gotoSpec) {
             }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)

    }
    

    
}

struct ServicesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ServicesView()
        }.navigationBarHidden(true)
    }
}
