//
//  BookingView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//


import SwiftUI

struct BookingView: View {
    @StateObject var medicalType = ViewModelExaminationTypeId()
    @StateObject var specialityvm = ViewModelSpecialist()

    @State private var image = UIImage()
    @State private var radius: CGFloat = .zero
    @State var loginAgain = false
    var language = LocalizationService.shared.language
    var vGridLayout = [ GridItem(.adaptive(minimum: 90), spacing: 30) ]
    
    var body: some View {
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
                                
                            }, label: {
                                VStack{
                                    Image("logo")
                                        .resizable()
                                        .foregroundColor(.black)
                                        .background(.blue)
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
                
                HStack {
                    Text("Specialities")
                        .font(Font.SalamtechFonts.Bold18)
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Text("See All")
                            .font(Font.SalamtechFonts.Reg14)
                    })
                }
                LazyVGrid(columns: vGridLayout){
                    ForEach(0..<specialityvm.publishedSpecialistModel.count,id:\.self){speciality in
                        ZStack {
                            Button(action: {
                                
                            }, label: {
                                ZStack {
                                    VStack{
                                        Spacer()
                                        Text(specialityvm.publishedSpecialistModel[speciality].Name ?? "")
                                            .frame(height:35)
                                            .font(Font.system(size: 13))
//                                            .padding(.bottom,10)
                                            .foregroundColor(.black)
                                    }
                                    .frame(width: (UIScreen.main.bounds.width/3)-20, height: 60)
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .shadow(color: .black.opacity(0.099), radius: 5)
                                    
                                    Image("heart")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .padding(.top,-60)
                                }
                            }) .frame(width: (UIScreen.main.bounds.width/3)-20, height: 120)
                                .background(Color.clear)
                                .cornerRadius(8)
                            .shadow(color: .black.opacity(0.099), radius: 5)
                        }
                        
//                        if speciality == 5{
//                           ZStack {
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
//                                            Image("heart")
//                                                .resizable()
//                                                .frame(width: 60, height: 60)
//                                            Text("+ \(specialityvm.publishedSpecialistModel.count-5)")
//
//                                            
//                                            
//                                        }
//                                            .padding(.top,-60)
//                                        
//                                    }
//                                }) .frame(width: (UIScreen.main.bounds.width/3)-20, height: 120)
//                                    .background(Color.clear)
//                                    .cornerRadius(8)
//                                .shadow(color: .black.opacity(0.099), radius: 5)
//                            }
////                            break
//                        }
                        
                    }
                    
                    
                    
                } .padding(.horizontal,13)

                
                
                
                
                
            }.background(Color.clear)
                .padding([.horizontal])
            
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
        .edgesIgnoringSafeArea(.top)
        .background(Color("CLVBG"))
        .onAppear(perform: {
//            medicalType.GetExaminationTypeId()
            print(medicalType.publishedModelExaminationTypeId)
            print(specialityvm.publishedSpecialistModel)
        })
        
    }
}

struct DashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
        
    }
}
