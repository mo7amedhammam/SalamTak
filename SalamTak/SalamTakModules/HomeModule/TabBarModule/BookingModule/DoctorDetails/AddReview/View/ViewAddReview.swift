//
//  ViewAddReview.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 18/05/2022.
//

import SwiftUI

struct ViewAddReview: View {
    var language = LocalizationService.shared.language
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var addRate = VMAddReview()
    var  Doctor:Doc
    @State var rate = 0
    @State var reviewComment = ""
    var schedule: AppointmentInfo
    
    var body: some View {
        ZStack{
            VStack {
                ScrollView{
                    VStack{
                        ZStack{
                            VStack( spacing:0){
                                VStack( ) {
                                    Spacer().frame(height:0)
                                    HStack(){
                                        AsyncImage(url: URL(string:   URLs.BaseUrl + "\(schedule.doctorImage ?? "")" )) { image in
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
                                            Text("Dr/ ".localized(language) + "\( schedule.doctorName ?? "Ali Ahmed")" )
                                                .padding(.bottom,8)
                                            //                                            .font(Font.SalamtechFonts.Bold18)
                                                .font(.system(size: 20))
                                            
                                            Text( schedule.seniorityName ?? "Psychiatry" )
                                                .padding(.bottom,8)
                                                .foregroundColor(.gray)
                                            //                                            .font(Font.SalamtechFonts.Bold18)
                                                .font(.system(size: 13))
                                            
                                        }
                                        .padding(.top, 10)
                                        
                                        Spacer()
                                    }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                    
                                } .padding()
                                
                                HStack{
                                    Spacer()
                                    Text("\(schedule.medicalTypeName ?? "")  |  \(schedule.appointmentDate ?? "")  " )
                                        .frame(height: 40)
                                        .foregroundColor(Color("blueColor"))
                                        .font(Font.SalamtechFonts.Reg16)
                                    
                                    Spacer()
                                    
                                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
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
                        
                        Text("Choose_Rate".localized(language))
                            .frame(width: UIScreen.main.bounds.width-20, height: 35, alignment:.bottomLeading)
                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                        
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
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                        .padding()
                        .background(.white)
                        .cornerRadius(15)
                        .padding(.horizontal,30)
                        
                        Text("Add_comment".localized(language))
                            .frame(width: UIScreen.main.bounds.width-20, height: 35, alignment:.bottomLeading)
                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                        
                        ZStack{
                            TextEditor(text: $reviewComment)
                                .font(.body)
                                .padding()
                                .onChange(of: reviewComment) { value in
                                    reviewComment = String(value.prefix(500))
                                }
                        }
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                        .padding(.vertical,0)
                        .frame(height:130)
                        .background(.white)
                        .cornerRadius(15)
                        .padding(.horizontal,30)
                        
                        Text("\(reviewComment.count) /"+"500".localized(language))
                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                            .frame(width: UIScreen.main.bounds.width-45, height: 30, alignment:.topTrailing)
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .padding(.trailing)
                        
                    }.ignoresSafeArea(.keyboard)
                    Spacer()
                    
                }
                .frame(width: UIScreen.main.bounds.width)
                .background(Color("CLVBG"))
                .keyboardSpace()
                Spacer()
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButtonView()
                }
            }
            .toolbar{
                ToolbarItemGroup(placement: .keyboard ){
                    Spacer()
                    Button("Done"){
                        UIApplication.shared.dismissKeyboard()
                    }
                }
            }
            .onTapGesture(perform: {
                hideKeyboard()
            })
            
            VStack{
                AppBarView(Title: "Rate_Doctor".localized(language))
                    .navigationBarBackButtonHidden(true)
                Spacer()
            }
            
            CustomSheet(IsPresented: .constant(true), TapToDismiss: .constant(false), content: {
                Button(action: {
                    // add review
                    addReview()
                }, label: {
                    HStack {
                        Text("Confirm".localized(language))
                            .fontWeight(.semibold)
                            .font(.title3)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("blueColor"))
                    .cornerRadius(12)
                    .padding(.horizontal, 12)
                })
                
                    .frame( height: 60)
                    .padding(.horizontal)
                    .padding(.bottom,10)
            })
            
            // showing loading indicator
            ActivityIndicatorView(isPresented: $addRate.isLoading)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .edgesIgnoringSafeArea(.top)
                
        // Alert with no internet connection
        .alert(isPresented: $addRate.isAlert, content: {
            Alert(title: Text(addRate.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                if addRate.activeAlert == .success{
                    self.presentationMode.wrappedValue.dismiss()
                    addRate.isAlert = false
                }else{
                    addRate.isAlert = false
                }
            }))
        })
    }
    func addReview(){
        addRate.isLoading = true
        addRate.DoctorId = schedule.id ?? 0
        addRate.Rate = rate
        addRate.Comment = reviewComment
        addRate.AddDocRate()
    }
}

struct ViewAddReview_Previews: PreviewProvider {
    static var previews: some View {
        ViewAddReview( Doctor: Doc.init(), schedule: AppointmentInfo.init())
    }
}
