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
    var schedule: AppointmentInfo
    let screenWidth = UIScreen.main.bounds.size.width - 50
    var body: some View {
        if schedule.isCancel == true {
            VStack{
                ZStack{
                    VStack{
                        HStack{
                            Spacer()
                            Text("Canceled")
                                .foregroundColor(.red)
                            Text(schedule.medicalTypeName ?? "")
                            
                            Text(" | ")
                            
                            Text(String(schedule.appointmentDate ?? ""))
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
                                            KFImage(URL(string: URLs.BaseUrl + "\(schedule.doctorImage)"))
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
                              } .frame(width: 90, height: 90, alignment: .center)
                                .background(Color.clear)
                        }
                        
                        VStack{
                            // Second Row
                            Text("Dr/ " + (schedule.doctorName ?? "") )
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
                            
                        }, label: {
                            HStack{
                                Image(systemName: "headphones.circle")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Color("blueColor"))
                                Text("Help")
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
            .frame(width: screenWidth, height: 200)
            .font(.system(size: 15))
            .border(Color("lightGray").opacity(0.3))
    //        .padding(12)
            .disableAutocorrection(true)
            .background(
                Color.clear
            ).foregroundColor(Color("blueColor"))
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.099), radius: 3)
        } else {
            VStack{
                ZStack{
                    VStack{
                        HStack{
                            Spacer()
                            Text(schedule.medicalTypeName ?? "")
                            
                            Text(" | ")
                            
                            Text(String(schedule.appointmentDate ?? ""))
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

                                    }, label: {
                                            KFImage(URL(string: URLs.BaseUrl + "\(schedule.doctorImage)"))
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
                              } .frame(width: 90, height: 90, alignment: .center)
                                .background(Color.clear)
                        }
                        //Spacer()
                        VStack{
                            // Second Row
                            Text("Dr/ " + (schedule.doctorName ?? "") )
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
                                Text("Map")
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
                            
                        }, label: {
                            HStack{
                                Image(systemName: "headphones.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color("blueColor"))
                                Text("Help")
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
                            
                        }, label: {
                            HStack{
                                Image(systemName: "multiply.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color("blueColor"))
                                Text("Cancel")
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
            .frame(width: screenWidth, height: 250)
            .font(.system(size: 15))
            .border(Color("lightGray").opacity(0.3))
    //        .padding(12)
            .disableAutocorrection(true)
            .background(
                Color.clear
            ).foregroundColor(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.099), radius: 3)
        }

    }
}


