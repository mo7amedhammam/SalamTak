//
//  ScheduleEachCellView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 19/04/2022.
//
import SwiftUI
import Kingfisher
extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}

struct ScheduleEachCellView: View {
    var language = LocalizationService.shared.language

   @State var schedule: AppointmentInfo
    let screenWidth = UIScreen.main.bounds.size.width - 50
    @State var goingToRate = false
    @State var goingToHelp = false
    
    @EnvironmentObject var scheduleVM : ViewModelGetAppointmentInfo
   
    
    var body: some View {
      
                if schedule.isCancel == true {
                    
                    VStack{
                        ZStack{
                            VStack{
                                HStack{
                                    Spacer()
                                    Text("Canceled".localized(language))
                                        .foregroundColor(.red)
                                    Text(schedule.medicalTypeName ?? "")
                                    
                                    Text(" | ")
                                    
//                                    Text(String(schedule.appointmentDate ?? ""))
                                    Text(ConvertStringDate(inp:schedule.appointmentDate ?? "",FormatFrom:"yyyy-MM-dd'T'HH:mm:ss" ,FormatTo:"d/M/yyyy"))
                                    
                                    Text(" | ")
                                    
                                    Text(ConvertStringDate(inp:schedule.appointmentDate ?? "",FormatFrom:"yyyy-MM-dd'T'HH:mm:ss" ,FormatTo:"hh:mm a"))

                                    Spacer()
                                    
                                }
                            }
                            
                            .frame( height: 40)
                        }
                        .background(Color("lightGray").opacity(0.2))
                        
                        
                        VStack{
                            HStack{
                                VStack{
                                    ZStack {
                                        ZStack {
                                            Button(action: {

                                            }, label: {
                                                KFImage(URL(string: URLs.BaseUrl + "\(schedule.doctorImage ?? "")"))
                                                           .resizable()
                                                           .scaledToFill()
                                                           .background(Color.clear)

                                            })

                                        }
                                        .frame(width: 55, height: 70, alignment: .center)
                                        .background(Image(systemName: "camera")
                                                        .resizable()
                                                        .foregroundColor(Color("blueColor").opacity(0.4))
                                                        .frame(width: 25, height: 25)
                                                        .background(Rectangle()
                                                                        .frame(width:70,height:70)
                                                                        .foregroundColor(Color("lightGray")).opacity(0.3)
                                                                        .cornerRadius(4))
                                        )
                                        .cornerRadius(10)
                                        
            //                                            CircularButton(ButtonImage:Image(systemName: "pencil" ) , forgroundColor: Color.gray, backgroundColor: Color.white.opacity(0.8), Buttonwidth: 20, Buttonheight: 20){
            //                                                self.showImageSheet = true
            //
            //                                            }.padding(.top,70)
                                      
                                    }
//                                    .frame(width: 90, height: 90, alignment: .center)
                                    .padding(.horizontal)
                                        .background(Color.clear)
                                }
                                
                                VStack{
                                    // Second Row
                                    Text("Dr/ ".localized(language) + (schedule.doctorName ?? "") )
                                        .foregroundColor(Color("blueColor"))
                                    VStack{
                                        HStack{
                                            Text(schedule.specialistName ?? "")
                                                .foregroundColor(Color("lightGray"))
                                            Text(schedule.clinicName ?? "")
                                                .foregroundColor(Color("lightGray"))
                                        }
                                    }
                                    
                                }
                                Spacer()
                            }
                            
                        }
                        
                        VStack{
                            HStack{
                                Button(action: {
                                 
                                    goingToHelp = true
                                }, label: {
                                    HStack{
                                        Image(systemName: "headphones.circle")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .foregroundColor(Color("blueColor"))
                                        Text("Help".localized(language))
                                            .foregroundColor(Color("blueColor"))
                                    }
                                    .padding(10)
                                    .padding(.bottom,1)
                                    .frame(width: 300, height: 40)
                                    .background( Color("lightGray").opacity(0.3)
                                                    .cornerRadius(5))
                                    .clipShape(Rectangle())
                                })
                                
                                
                               
                            }
                        }
                        Spacer()
                    }
//                    .frame(width: screenWidth, height: 170)
                    .frame(width: screenWidth)

                    .font(.system(size: 15))
                    .border(Color("lightGray").opacity(0.3))
            //        .padding(12)
                    .disableAutocorrection(true)
                    .background(
                        Color.clear
                    ).foregroundColor(Color("blueColor"))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.099), radius: 3)
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                } else if schedule.isCancel == false && schedule.canRate == false{
                    VStack{
                        ZStack{
                            VStack{
                                HStack{
                                    Spacer()
                                    Text(schedule.medicalTypeName ?? "clinic")
                                    
                                    Text(" | ")
                                    
                                    Text(ConvertStringDate(inp:schedule.appointmentDate ?? "",FormatFrom:"yyyy-MM-dd'T'HH:mm:ss" ,FormatTo:"d/M/yyyy"))
                                    
                                    Text(" | ")
                                    
                                    Text(ConvertStringDate(inp:schedule.appointmentDate ?? "",FormatFrom:"yyyy-MM-dd'T'HH:mm:ss" ,FormatTo:"hh:mm a"))

                                    Spacer()
                                    
                                }
                            }
                            
                            .frame( height: 40)
                        }
                        .background(Color("blueColor"))
                        
                        Spacer().frame( height: 30)
                        VStack{
                            HStack{
                                VStack{
                                    ZStack {
                                        ZStack {
                                            Button(action: {
//                                                ispreviewImage = true
//                                                previewImageurl = URLs.BaseUrl + "\(Doctor.Image ?? "")"
                                            }, label: {
                                                
//                                                AsyncImage(url: URL(string:   URLs.BaseUrl + "\(schedule.doctorImage ?? "")" )) { image in
//
//                                                    image.resizable()
//
//                                                } placeholder: {
//                                                    Image("logo")
//                                                        .resizable()
//                                                }
//                                                    .scaledToFill()
//                                                    .frame(width:60)
//                                                    .background(Color.gray)
//                                                    .cornerRadius(9)
                                                
                                                
                                                KFImage(URL(string: URLs.BaseUrl + "\(schedule.doctorImage ?? "")"))
                                                           .resizable()
                                                           .scaledToFill()
                                                           .background(Color.clear)

                                            })

                                        }
                                        .frame(width: 55, height: 70, alignment: .center)
                                        .background(Image(systemName: "camera")
                                                        .resizable()
                                                        .foregroundColor(Color("blueColor").opacity(0.4))
                                                        .frame(width: 25, height: 25)
                                                        .background(Rectangle()
                                                                        .frame(width:70,height:70)
                                                                        .foregroundColor(Color("lightGray")).opacity(0.3)
                                                                        .cornerRadius(4))
                                        )
                                        .cornerRadius(10)
                                        
            //                                            CircularButton(ButtonImage:Image(systemName: "pencil" ) , forgroundColor: Color.gray, backgroundColor: Color.white.opacity(0.8), Buttonwidth: 20, Buttonheight: 20){
            //                                                self.showImageSheet = true
            //
            //                                            }.padding(.top,70)
                                      }
//                                    .frame(width: 90, height: 90, alignment: .center)
                                    .padding(.horizontal)
                                        .background(Color.clear)
                                }
                                //Spacer()
                                VStack{
                                    // Second Row
                                    Text("Dr/ ".localized(language) + (schedule.doctorName ?? "mostafa ") )
                                        .foregroundColor(Color("blueColor"))
                                    VStack{
                                        HStack{
                                            Text(schedule.specialistName ?? "")
                                                .foregroundColor(Color("lightGray"))
                                            Text(schedule.clinicName ?? "")
                                                .foregroundColor(Color("lightGray"))
                                        }
                                    }
                                    
                                }
                                Spacer()
                            }
                            
                        }
                        
                        VStack{
                            HStack{
                                Spacer()
                                Button(action: {
                                    Helper.openGoogleMap(longitude: schedule.clinicLongitude?.toDouble() ?? 0.0, latitude: schedule.clinicLatitude?.toDouble() ?? 0.0)
                                }, label: {
                                    HStack{
                                        Image(systemName: "map.circle.fill")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(Color("blueColor"))
                                        Text("Map".localized(language))
                                            .foregroundColor(Color("blueColor"))
                                            .font(.system(size: 12))
                                    }
                                    .padding(10)
                                    .padding(.bottom,1)
                                    .frame(width: 90, height: 40)
                                    .background( Color("lightGray").opacity(0.3)
                                                    .cornerRadius(5))
                                    .clipShape(Rectangle())
                                    
                                })
                                Spacer()
                                
                                Button(action: {
                              

                                    goingToHelp = true

                                }, label: {
                                    HStack{
                                        Image(systemName: "headphones.circle")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(Color("blueColor"))
                                        Text("Help".localized(language))
                                            .foregroundColor(Color("blueColor"))
                                            .font(.system(size: 12))
                                    }
                                    .padding(10)
                                    .padding(.bottom,1)
                                    .frame(width: 90, height: 40)
                                    .background( Color("lightGray").opacity(0.3)
                                                    .cornerRadius(5))
                                    .clipShape(Rectangle())
                                })
                                Spacer()
                                
                                Button(action: {
                                    scheduleVM.AppointmentCancelID = schedule.id ?? 1
                                    scheduleVM.showcncel = true

                                }, label: {
                                    HStack{
                                        Image(systemName: "multiply.circle")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(Color("blueColor"))
                                        Text("Cancel".localized(language))
                                            .foregroundColor(Color("blueColor"))
                                            .font(.system(size: 12))
                                    }
                                    .padding(10)
                                    .padding(.bottom,1)
                                    .frame(width: 90, height: 40)
                                    .background( Color("lightGray").opacity(0.3)
                                                    .cornerRadius(5))
                                    .clipShape(Rectangle())
                                })
                                Spacer()
                            }
                        }
                        Spacer()
                    }
                    //                    .frame(width: screenWidth, height: 170)
                                        .frame(width: screenWidth)                    .font(.system(size: 15))
                    .border(Color("lightGray").opacity(0.3))
            //        .padding(12)
                    .disableAutocorrection(true)
                    .background(
                        Color.clear
                    ).foregroundColor(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.099), radius: 3)
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                } else if schedule.canRate == true {
                    VStack{
                        ZStack{
                            VStack{
                                HStack{
                                    Spacer()
                                    Text("Done".localized(language))
                                        .foregroundColor(Color("blueColor"))
                                    Text(schedule.medicalTypeName ?? "")
                                    
                                    Text(" | ")
                                    
                                    Text(ConvertStringDate(inp:schedule.appointmentDate ?? "",FormatFrom:"yyyy-MM-dd'T'HH:mm:ss" ,FormatTo:"d/M/yyyy"))
                                    
                                    Text(" | ")
                                    
                                    Text(ConvertStringDate(inp:schedule.appointmentDate ?? "",FormatFrom:"yyyy-MM-dd'T'HH:mm:ss" ,FormatTo:"hh:mm a"))
                                    Spacer()
                                    
                                }
                            }
                            
                            .frame( height: 40)
                        }
                        .background(Color("lightGray").opacity(0.2))
                        
                        
                        VStack{
                            HStack{
                                VStack{
                                    ZStack {
                                        ZStack {
                                            Button(action: {
//                                                ispreviewImage = true
//                                                previewImageurl = URLs.BaseUrl + "\(Doctor.Image ?? "")"
                                            }, label: {
                                                
                                                
                                                KFImage(URL(string: URLs.BaseUrl + "\(schedule.doctorImage ?? "")"))
                                                           .resizable()
                                                           .scaledToFill()
                                                           .background(Color.clear)

                                            })

                                        }
                                        .frame(width: 55, height: 70, alignment: .center)
                                        .background(Image(systemName: "camera")
                                                        .resizable()
                                                        .foregroundColor(Color("blueColor").opacity(0.4))
                                                        .frame(width: 25, height: 25)
                                                        .background(Rectangle()
                                                                        .frame(width:70,height:70)
                                                                        .foregroundColor(Color("lightGray")).opacity(0.3)
                                                                        .cornerRadius(4))
                                        )
                                        .cornerRadius(10)
                                        
            //                                            CircularButton(ButtonImage:Image(systemName: "pencil" ) , forgroundColor: Color.gray, backgroundColor: Color.white.opacity(0.8), Buttonwidth: 20, Buttonheight: 20){
            //                                                self.showImageSheet = true
            //
            //                                            }.padding(.top,70)
                                      }
//                                    .frame(width: 90, height: 90, alignment: .center)
                                    .padding(.horizontal)
                                        .background(Color.clear)
                                }
                                
                                VStack{
                                    // Second Row
                                    Text("Dr/ ".localized(language) + (schedule.doctorName ?? "") )
                                        .foregroundColor(Color("blueColor"))
                                    VStack{
                                        HStack{
                                            Text(schedule.specialistName ?? "")
                                                .foregroundColor(Color("lightGray"))
                                            Text(schedule.clinicName ?? "")
                                                .foregroundColor(Color("lightGray"))
                                        }
                                    }
                                    
                                }
                                Spacer()
                            }
                            
                        }
                        
                        VStack{
                            HStack{
                                Button(action: {
                                    self.goingToRate = true
                                }, label: {
                                    HStack{
                                        Image(systemName: "star")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.white)
                                        Text("Rate".localized(language))
                                            .foregroundColor(.white)
                                    }
                                    .padding(10)
                                    .padding(.bottom,1)
                                    .frame(width: 150, height: 40)
                                    .background( Color("darkGreen")
                                                    .cornerRadius(5))
                                    .clipShape(Rectangle())
                                })
                                
                               
                                
                                Button(action: {
                                    goingToHelp = true

                                }, label: {
                                    HStack{
                                        Image(systemName: "headphones.circle")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .foregroundColor(Color("blueColor"))
                                        Text("Help".localized(language))
                                            .foregroundColor(Color("blueColor"))
                                    }
                                    .padding(10)
                                    .padding(.bottom,1)
                                    .frame(width: 150, height: 40)
                                    .background( Color("lightGray").opacity(0.3)
                                                    .cornerRadius(5))
                                    .clipShape(Rectangle())
                                })
                                
                                
                                
                               
                            }
                        }
                        Spacer()
                    }
                    //                    .frame(width: screenWidth, height: 170)
                                        .frame(width: screenWidth)                    .font(.system(size: 15))
                    .border(Color("lightGray").opacity(0.3))
            //        .padding(12)
                    .disableAutocorrection(true)
                    .background(
                        Color.clear
                    ).foregroundColor(Color("blueColor"))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.099), radius: 3)
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                }

        // go to addReview
        NavigationLink(destination:ViewAddReview( Doctor: Doc.init(), schedule: schedule),isActive: $goingToRate) {
                }

        
//        NavigationLink(destination: RateScreen(schedule: $schedule).navigationBarBackButtonHidden(true),isActive:$goingToRate , label: {
//        })
        
//        ViewAddReview(Doctor: schedule)
        


       

    }
}

struct ScheduleEachCellView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleEachCellView(schedule: AppointmentInfo.init(id: 1, medicalTypeId: 2, doctorName: "mostafa") )
    }
}




struct ViewCancelAppointmentPopUp: View {
    @EnvironmentObject var scheduleVM : ViewModelGetAppointmentInfo

    @Binding var showCancePopUp:Bool
    @Binding var cancelReason:String

    var language = LocalizationService.shared.language
    var body: some View {
        ZStack{
            VStack{
                
                Image("CancelAppointment")
                    .resizable()
                    .frame(width: 120, height: 72, alignment: .center)
                    .padding(.top)
                    
                Text("Popup_Cencel_Appointment".localized(language)).font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.center)
                    .frame( height:60)
                    .foregroundColor(Color("blueColor"))
                
                Text("Popup_Cencel_Appointment_msg".localized(language)).font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .frame( height:60)
                    .foregroundColor(Color("subText"))
                
                EMRInputTextField(text: $scheduleVM.AppointmentCancelReason , title: "Popup_Cencel_Appointment_reason".localized(language) )
                    .padding([.leading,.trailing])
                
                HStack{
                    Spacer()
                        .frame(width:15)
                    Button(action: {
                        self.showCancePopUp.toggle()
                    }, label: {
                        HStack{
                            Spacer().frame(width:2)

                            Text("Popup_Cencel_Appointment_Close".localized(language))
                            .foregroundColor(Color("blueColor"))
                            .bold()
                            .frame( height: 45 )
                            .padding([.leading,.trailing],40)
                            .background(Color(uiColor: .lightGray).opacity(0.3) )
                            .cornerRadius(8)
                            Spacer().frame(width:2)
                    }
                    }
                    )
                    Spacer()
                    Button(action: {
                        

                        scheduleVM.execute(operation: .cancelappointment)
                    }, label: {
                        HStack{
                            Spacer().frame(width:2)

                            Text("Popup_Cencel_Appointment_Confirm".localized(language))
                                .foregroundColor(.white)
                            .bold()
                            .frame( height: 45 )
                            .padding([.leading,.trailing],40)
                            .background(Color("blueColor"))
                            
                            .cornerRadius(8)
                            Spacer().frame(width:2)
                    }
                    }
                    )
                    Spacer().frame(width:5)
                    
                        .onChange(of: scheduleVM.isAlert){newval in
                            scheduleVM.showcncel = !newval
//                            scheduleVM.startFetchAppointmentInfo()
                    }

                }
                .frame( height: 40 )
                    .padding([.leading,.trailing],10)
                    .padding([.top,.bottom])

                
            }
            
            .frame( height: 350 )
            .background(Color.white)
            .cornerRadius(12)
            
        
        
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height,alignment: .center )
        .padding([.leading,.trailing],20)
        .edgesIgnoringSafeArea(.all)
//            .offset(y:(-UIScreen.main.bounds.height/2)/2)
        .background(Color.black.opacity(0.2))
        
        
       

        
    }
}



struct ViewCancelAppointmentPopUp_Previews: PreviewProvider {
    static var previews: some View {
        ViewCancelAppointmentPopUp( showCancePopUp: .constant(false), cancelReason: .constant(""))
    }
}
