//
//  ReviewsView.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 11/05/2022.
//

import SwiftUI

struct ReviewsView: View {
    
    @StateObject var DocReviews = ReviewsVM()
    var DoctorId:Int
    @State var hei: CGFloat = 180
    var language = LocalizationService.shared.language

    var body: some View {
        ZStack{
            VStack{
                
              
                List( ){
                    if DocReviews.noReviews == true{
                        Text("Sorry,\nNo_Reviews_Found_🤷‍♂️".localized(language))
                            .multilineTextAlignment(.center)
                        .frame(width:UIScreen.main.bounds.width-40,alignment:.center)
                    }
                    
                    ForEach(DocReviews.publishedReviewsModel , id:\.self){Rate in
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
                                            .font(.system(size: 20))
                                

                                        }
                                        .padding(.top, 10)

                                        Spacer()
                                    }
                                }
                                .padding()
                                
                                VStack(alignment:.leading, spacing:0){
                                    
                                    Text("Rate.Comment" )

                                    .foregroundColor(.gray)
                                        .font(Font.SalamtechFonts.Reg14)
                                }.padding(.leading)
                                    .frame(height: 100)
                                
                            }//V
                            .background(Color.clear)

                        }//Z
                        .frame(width: (UIScreen.main.bounds.width/1)-40)
                        .background(.clear)
                        .cornerRadius(9)
                        .shadow(color: .black.opacity(0.1), radius: 9)
                    }
                }.refreshable(action: {
                })
                    .listStyle(.plain)
                    .padding(.vertical,0)
                    .padding(.top, 110)
            }
            .frame(width: UIScreen.main.bounds.width)
            .edgesIgnoringSafeArea(.vertical)
            .background(Color("CLVBG"))
            
            VStack{
                AppBarView(Title: "Reviews".localized(language))
                    .navigationBarBackButtonHidden(true)
                Spacer()
            }
            .edgesIgnoringSafeArea(.vertical)
            
            // showing loading indicator
            ActivityIndicatorView(isPresented: $DocReviews.isLoading)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: {
            DocReviews.isLoading = true
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
