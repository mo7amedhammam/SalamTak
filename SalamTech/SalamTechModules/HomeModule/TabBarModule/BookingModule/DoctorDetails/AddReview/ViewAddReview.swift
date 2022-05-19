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
    @State var rate = 0
    @State var reviewComment = "klmlkmklnklnlk"
    @State var wordCount = 0

    var body: some View {
        ZStack{
            VStack{
            
                ZStack{
                            
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
                                            Text("Dr/ \( Doctor.DoctorName ?? "Ali Ahmed")" )
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

//
                                    HStack{
                                        Spacer()
                                        Text("Clinic Visit  |  26.02.2019  |  18:20:00" )
                                            .frame(height: 40)
                                            .foregroundColor(Color("blueColor"))
                                            .font(Font.SalamtechFonts.Reg16)
                                    
                                    Spacer()
                                    
                                }
                                .background(Color("addReviewSubHead"))

                                
                            }//V
                            .padding(.top,50)
//                            .background(Color.gray)
                                                .background(.white)
                                                .cornerRadius(15)

                        }//Z
                    .padding(.top,60)
                    .background(.white)
//                    .background(Color("CLVBG"))

                Text("Choose Rate")
                    .frame(width: UIScreen.main.bounds.width-20, height: 35, alignment:.bottomLeading)
                HStack{
                    Spacer()
                    ForEach(0..<5){ num in
                        
                        Button(action: {
                            rate = num+1
                        }, label: {
                            Image(systemName: rate>num ? "star.fill":"star")
                                .resizable()
                                .frame(width: 35, height: 35, alignment: .center)
    //                            .padding(.horizontal,2)
                                .foregroundColor(.yellow)
                        })
                    }
                    Spacer()
                }

                .padding()
                .background(.white)
                .cornerRadius(15)
                .padding(.horizontal,30)

                
                Text("Add comment")
                    .frame(width: UIScreen.main.bounds.width-20, height: 35, alignment:.bottomLeading)
                ZStack{
                    TextEditor(text: $reviewComment)
                                    .font(.body)
                                    .padding()
//                                    .padding(.top, 20)
                                    .onChange(of: reviewComment) { value in
//                                        let words = reviewComment.split { $0 == " " || $0.isNewline }
//                                        self.wordCount = words.count
                                        reviewComment = String(value.prefix(500))

                                    }

                }
                .padding(.vertical,0)
                .frame(height:130)
                .background(.white)
                .cornerRadius(15)
                .padding(.horizontal,30)

                
                Text("\(reviewComment.count) / 500")
                    .frame(width: UIScreen.main.bounds.width-45, height: 30, alignment:.topTrailing)
                                .font(.headline)
                                .foregroundColor(.secondary)
                                .padding(.trailing)

                
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
