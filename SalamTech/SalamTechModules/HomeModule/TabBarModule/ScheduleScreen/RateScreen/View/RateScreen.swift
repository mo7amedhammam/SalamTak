//
////
////  RateScreen.swift
////  SalamTech
////
////  Created by Mostafa Morsy on 23/04/2022.
////
//import SwiftUI
//import Kingfisher
//
//struct RateScreen: View {
//    @Binding var schedule: AppointmentInfo
//    @State var input = ""
//    @State var rating: Int = 0
//    var body: some View {
//        ZStack{
//            VStack{
//                AppBarView(Title: "Rate Doctor")
//                Spacer().frame( height: 30)
//
//                VStack{
//                    VStack{
//                        HStack{
//                            VStack{
//                                ZStack {
//                                    ZStack {
//                                        Button(action: {
//
//                                        }, label: {
//                                                KFImage(URL(string: URLs.BaseUrl + "\(schedule.doctorImage)"))
//                                                       .resizable()
//                                                       .scaledToFill()
//                                                       .background(Color.clear)
//
//                                        })
//
//                                    }
//                                    .frame(width: 55, height: 70, alignment: .center)
//                                    .background(Image(systemName: "camera")
//                                                    .resizable()
//                                                    .foregroundColor(Color("blueColor").opacity(0.4))
//                                                    .frame(width: 25, height: 25)
//                                                    .background(Rectangle()
//                                                                    .frame(width:70,height:70)
//                                                                    .foregroundColor(Color("lightGray")).opacity(0.3)
//                                                                    .cornerRadius(4))
//                                    )
//                                    .cornerRadius(10)
//
//        //                                            CircularButton(ButtonImage:Image(systemName: "pencil" ) , forgroundColor: Color.gray, backgroundColor: Color.white.opacity(0.8), Buttonwidth: 20, Buttonheight: 20){
//        //                                                self.showImageSheet = true
//        //
//        //                                            }.padding(.top,70)
//                                  } .frame(width: 90, height: 90, alignment: .center)
//                                    .background(Color.clear)
//                            }
//
//                            VStack{
//                                // Second Row
//                                Text("Dr/ " + (schedule.doctorName ?? "") )
//                                    .foregroundColor(Color("blueColor"))
//                                VStack{
//                                    HStack{
//                                        Text(schedule.specialistName ?? "")
//                                            .foregroundColor(Color("lightGray"))
//                                        Text(schedule.clinicName ?? "")
//                                            .foregroundColor(Color("lightGray"))
//                                    }
//                                }
//
//                            }
//                            Spacer()
//                        }
//
//                    }
//                    ZStack{
//                        VStack{
//                            HStack{
//                                Spacer()
//
//                                Text(schedule.medicalTypeName ?? "")
//                                    .foregroundColor(Color("blueColor"))
//                                Text(" | ")
//                                    .foregroundColor(Color("blueColor"))
//                                Text(String(schedule.appointmentDate ?? ""))
//                                    .foregroundColor(Color("blueColor"))
//                                Spacer()
//
//                            }
//                        }
//
//                        .frame( height: 40)
//                    }
//                    .background(Color("blueColor").opacity(0.2))
//                    Spacer().frame(height:40)
//
//                    List{
//                        Section{
////                            RatingView(rating: $rating)
//                        } header: {
//                            Text("Choose Rate")
//                        }
//
//                        Section(header: Text("Add Comment") ) {
//                            TextField("Your Comment", text: $input)
//                        }
//                        .textCase(nil) //
//
//
//                    }
//
//
//                }
//                Spacer()
////                CustomActionBottomSheetSingle( Confirmaction: {
////
////                }, isValid: .constant(true))
//            }
//            .edgesIgnoringSafeArea(.bottom)
//            .ignoresSafeArea()
//            .background(Color("CLVBG"))
//        }
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading:  BackButtonView())
//    }
//}
