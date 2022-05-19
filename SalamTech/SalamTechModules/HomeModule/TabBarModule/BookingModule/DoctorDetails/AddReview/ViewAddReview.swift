//
//  ViewAddReview.swift
//  SalamTech
//
//  Created by wecancity on 18/05/2022.
//

import SwiftUI

struct ViewAddReview: View {
    @StateObject var addRate = VMAddReview()
     var  Doctor:Doc
    var body: some View {
        ZStack{
            VStack{
            
                ZStack{
//                            ZStack {
//
//                            } //Z
//                            .frame(width:(UIScreen.main.bounds.width/1)-40)
//                            .frame( minHeight: 66)
//                            .background(.white)
//
//                            .cornerRadius(9)
//                            .offset( y: 30)
                            
                            VStack( spacing:0){
                                
                                VStack( ) {
                                    Spacer().frame(height:0)
                                    HStack(){
                                        
                                        AsyncImage(url: URL(string:   URLs.BaseUrl + "\(Doctor.Image ?? "")" )) { image in

                                            image.resizable()

                                        } placeholder: {
                                            Image("logo")
                                                .resizable()
                                        }
                                            .scaledToFill()
                                            .frame(width:60, height: 60)
                                            .background(Color.gray)
                                            .cornerRadius(9)
                                    
                                        VStack(alignment:.leading   ,spacing:0){
                                            Text("Dr/\( Doctor.DoctorName ?? "Ali Ahmed")" )
                                                .padding(.bottom,8)
//                                            .font(Font.SalamtechFonts.Bold18)
                                            .font(.system(size: 20))
                                        
                                            Text( Doctor.SeniortyLevelName ?? "Psychiatry" )
                                                .padding(.bottom,8)
                                                .foregroundColor(.gray)
//                                            .font(Font.SalamtechFonts.Bold18)
                                            .font(.system(size: 13))

                                        }
                                        .padding(.top, 10)

                                        Spacer()
                                    }
                                }
                                .padding()
                                //                                    .padding(.top,-10)
                                
                                VStack(alignment:.leading, spacing:0){
                                    
//                                    Text("Thank you very much! Great clinic! The dog was limping, X-rayed, prescribed quality treatment. Dog of fights! Excellent specialists! more" )
                                    Text("Rate.Comment" )

                                    .foregroundColor(.gray)
                                        .font(Font.SalamtechFonts.Reg14)
//
                                    HStack{
                                        Spacer()
                                        Text("26.02.2019" )
                                            .foregroundColor(.gray.opacity(0.3))
                                            .font(Font.SalamtechFonts.Reg14)
                                    }.padding(.trailing)
                                    
//                                    Spacer()
                                    
                                }.padding(.leading)
                                    .frame(height: 100)
                                
                            }//V

//                            .background(Color.clear)
                                                .background(.white)
                    
                                                .cornerRadius(9)

                        }//Z
                      
  
                    .padding(.bottom,0)
                    .padding(.top,110)
                    .background(Color("CLVBG"))

                                Spacer()
            }
            
            .frame(width: UIScreen.main.bounds.width)
            .edgesIgnoringSafeArea(.vertical)
            .background(Color("CLVBG"))
            
            VStack{
                AppBarView(Title: "Rate Doctor")
                //                    .navigationBarItems(leading: BackButtonView())
                    .navigationBarBackButtonHidden(true)
                Spacer()
            }
            .edgesIgnoringSafeArea(.vertical)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                        BackButtonView()
                    
                }
            }
            
        }.onAppear(perform: {
            addRate.DoctorId = Doctor.id ?? 0
        })
        
        
        
    }
}

struct ViewAddReview_Previews: PreviewProvider {
    static var previews: some View {
        ViewAddReview( Doctor: Doc.init())
    }
}
