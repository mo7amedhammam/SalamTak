//
//  ReviewsView.swift
//  SalamTech
//
//  Created by wecancity on 11/05/2022.
//

import SwiftUI

struct ReviewsView: View {
    
    @StateObject var DocReviews = ReviewsVM()
    var DoctorId:Int
    @State var hei: CGFloat = 180

    var body: some View {
        ZStack{
            VStack{
                
                List( ){
                    
                    ForEach(DocReviews.publishedReviewsModel ?? [] , id:\.self){Rate in
                        ZStack{
                            ZStack {
                                
                            } //Z
                            .frame(width:(UIScreen.main.bounds.width/1)-40)
                            .frame( minHeight: hei)
                            .background(.white)
                            
                            .cornerRadius(9)
                            .offset( y: 30)
                            
                            VStack( spacing:0){
                                
                                VStack( ) {
                                    Spacer().frame(height:0)
                                    HStack(){
                                        
                                        Image("logo")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .background(Color.gray)
                                            .cornerRadius(9)
                                    
                                        VStack(spacing:0){
                                            Text("Rate.PatientName" ).padding(.bottom,8)
//                                            .font(Font.SalamtechFonts.Bold18)
                                            .font(.system(size: 20))
                                        
//                                StarsView(rating: Float("Rate.Rate" ?? 00) )
                                            

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

                            .background(Color.clear)

                        }//Z
                        .frame(width: (UIScreen.main.bounds.width/1)-40)
                        //                        .offset(y:40)
                        .background(.clear)
                        .cornerRadius(9)
                        .shadow(color: .black.opacity(0.1), radius: 9)
                        
                    }
    
                }.refreshable(action: {
//                    getAllReviews()
                })
                    .listStyle(.plain)
                    .padding(.vertical,0)
                //            .background(Color.red)
                //                Spacer()
            }
            
            .frame(width: UIScreen.main.bounds.width)
            .edgesIgnoringSafeArea(.vertical)
            .background(Color("CLVBG"))
            
            VStack{
                AppBarView(Title: "Doctor Reviews")
                //                    .navigationBarItems(leading: BackButtonView())
                    .navigationBarBackButtonHidden(true)
                Spacer()
            }
            .edgesIgnoringSafeArea(.vertical)
            
            
        }.onAppear(perform: {
            DocReviews.doctorId = DoctorId
            DocReviews.startFetchReviews()
        })
        
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                    BackButtonView()
                
            }
        }
        
    }
}

struct ReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsView(DoctorId: 0)
    }
}
