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
    @State var goingToRate = false
    @State var goingToHelp = false
    
    @EnvironmentObject var scheduleVM : ViewModelGetAppointmentInfo
    var body: some View {
        ZStack {
            VStack{
                HStack{
                    Spacer()
                    Text( schedule.isCancel==true  ?  "Canceled".localized(language):schedule.canRate==true ? "Done".localized(language):""   )
                        .foregroundColor(schedule.isCancel==true ? .red:schedule.canRate==true ? Color("blueColor"):.black)
                    Group{
                        Text(schedule.medicalTypeName ?? "clinic")
                        
                        Text(" | ")
                        
                        Text(ConvertStringDate(inp:schedule.appointmentDate ?? "",FormatFrom:"yyyy-MM-dd'T'HH:mm:ss" ,FormatTo:"d/M/yyyy"))
                        
                        Text(" | ")
                        
                        Text(ConvertStringDate(inp:schedule.appointmentDate ?? "",FormatFrom:"yyyy-MM-dd'T'HH:mm:ss" ,FormatTo:"hh:mm a"))
                    }.foregroundColor(schedule.canRate==true||schedule.isCancel==true ? .black:.white)
                    Spacer()
                    
                }
                .frame( height: 40)

                .background(schedule.canRate==true ? Color("lightGray").opacity(0.2):Color("blueColor"))
                
                Spacer()
                HStack{
                    ZStack {
                        Button(action: {
                        }, label: {
                            
                            KFImage(URL(string: URLs.BaseUrl + "\(schedule.doctorImage ?? "")"))
                                .resizable()
                                .scaledToFill()
                                .background(Color.clear)
                            
                        })
                    }
                    .frame(width: 55, height: 65, alignment: .center)
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
                    .padding(.horizontal)
                    .background(Color.clear)
                    
                    VStack{
                        // Second Row
                        Text("Dr/ ".localized(language) + (schedule.doctorName ?? "mostafa ") )
                            .foregroundColor(Color("blueColor"))
                        
                        HStack{
                            Text(schedule.specialistName ?? "")
                                .foregroundColor(Color("lightGray"))
                            Text(schedule.clinicName ?? "")
                                .foregroundColor(Color("lightGray"))
                        }
                    }
                    Spacer()
                }
                
                HStack{
                    Group{
                        if schedule.isCancel == false && schedule.canRate == false {
                            
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
                            })
                            
                        }
                        if schedule.canRate == true{
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
                            })
                                .frame( height: 40 )
                                .frame(minWidth:100,maxWidth: 300 )
                                .background( Color("darkGreen").cornerRadius(9))
                        }
                        
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
                        })
                        
                        if schedule.isCancel == false && schedule.canRate == false {
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
                            })
                        }
                        
                    }
                    .frame( height: 40 )
                    .frame(minWidth:100,maxWidth: 300 )
                    .background( Color("lightGray").opacity(0.3)
                                    .cornerRadius(9))
                    
                }
                .frame(height:40)
                .padding(.horizontal)
                .padding(.bottom)
                
            }
            .background(Color.white)
            
        }
        .frame(minWidth:UIScreen.main.bounds.width - 30)
        .font(.system(size: 15))
        .foregroundColor(Color.white)
        .cornerRadius(10)
        .clipShape(Rectangle()).shadow(color: .black.opacity(0.22), radius: 12)
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
        
        
        
        // go to addReview
        NavigationLink(destination:ViewAddReview( Doctor: Doc.init(), schedule: schedule),isActive: $goingToRate) {
        }
    }
}

struct ScheduleEachCellView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleEachCellView(schedule: AppointmentInfo.init(id: 1, medicalTypeId: 2, doctorName: "mostafa") )
    }
}
