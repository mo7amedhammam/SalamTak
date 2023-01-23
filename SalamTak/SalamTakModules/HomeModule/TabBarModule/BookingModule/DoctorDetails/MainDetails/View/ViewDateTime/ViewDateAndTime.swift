//
//  ViewDateAndTime.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 07/06/2022.
//

import Foundation
import SwiftUI
struct ViewDateAndTime: View {
    var language = LocalizationService.shared.language
    
    @State var TappedDate = Date()
    @State var timeexpanded = false
    @EnvironmentObject var DocDetails : ViewModelDocDetails
    
    var weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    var vGridLayout = [ GridItem(.adaptive(minimum: 90), spacing: 30) ]
    
    @State var seldatenum = ""
    @State var openSlots = false
    @Binding var ShowCalendar : Bool
    @Binding var selectedSchedualId :Int
    @Binding var selectedTime :String
    
    @Binding var DoctorId :Int
    @Binding var ClinicId :Int
    @Binding var ExTypeId :Int
    @Binding var BookingFees :Int
    
    init(ShowCalendar: Binding<Bool>, selectedSchedualId: Binding<Int>,selectedTime: Binding<String>,DoctorId: Binding<Int>,ClinicId: Binding<Int>,ExTypeId: Binding<Int>,BookingFees: Binding<Int>){
        self._ShowCalendar = ShowCalendar
        self._selectedSchedualId = selectedSchedualId
        self._selectedTime = selectedTime
        self._DoctorId = DoctorId
        self._ClinicId = ClinicId
        self._ExTypeId = ExTypeId
        self._BookingFees = BookingFees
        setWeekView()
    }
    var body: some View {
        VStack{
            HStack {
                Text("Choose_date_&_time".localized(language))
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .bold()
//                    .frame(width: UIScreen.main.bounds.width-20, height: 35, alignment:.bottomLeading)
//                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            }
            .padding(10)
            .background(Color.salamtackWelcome)
            .cornerRadius(20)

            
            //MARK: ---- Days of Week --------
            ZStack{
                VStack{
                    
                    //MARK: Selected date & show calednar
                    Button(action: {
                        // open Calendar
                        ShowCalendar = true
                    }, label: {
                        HStack(spacing:0){
                            Image("TabBar_schedual")
                                .resizable()
                                .frame(width: 25, height: 25)
                            
                                .padding(8)
                                .clipShape(Circle())
                                .AddBlueBorder(cornerRadius: 25,linewidth: 1.2)
                            Text("\(seldatenum) \(CalendarHelper().monthString(date: DocDetails.SchedualDate)) ,")
                                .foregroundColor(.salamtackWelcome)
                                .font(.system(size: 18))
                                .bold()

                            Text(" \(CalendarHelper().yearString(date: DocDetails.SchedualDate) )")
                                .foregroundColor(.salamtackBlue)
                                .font(.system(size: 18))
                                .bold()
                            
//                            Image( systemName: "chevron.forward")
//                                .foregroundColor(Color("darkGreen"))
//                                .padding(.bottom,3)
                            Spacer()
                        }
                        //                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                        .frame(height:15)
                    })
                        .padding()
                    
//                    Divider().padding(.top,-10)
                    
                    //MARK: --- Current Week ------
                    HStack(spacing:0){
                        ForEach(0..<weekdays.count, id:\.self){ day in
                            let date = totalSquares[day]
                            
                            Button(action: {
                                // select date
//                                TappedDate = date
                                DocDetails.SchedualDate = date
                                openSlots = true
                                seldatenum = String(CalendarHelper().dayOfMonth(date: date))
                            }, label: {
                                VStack{
                                    Text(String(CalendarHelper().dayOfMonth(date: date)))
                                    Text(weekdays[day])
                                    if TappedDate == date{
                                        Text(".")
                                            .font(.system(size: 40) )
                                            .padding(.top, -40)
                                    }
                                } .frame(width:(UIScreen.main.bounds.width-40)/7)
                            }).foregroundColor(Color("blueColor"))
                                .background( TappedDate == date ? Color("darkGreen").opacity(0.19):.clear)
                                .cornerRadius(8)
                                .padding(.bottom, 10)
                            
                            
                        }
                    }
                    .frame(height: 60)
                }
//                .background(Color.white)
            }
            .frame(width: UIScreen.main.bounds.width-30)
//            .cornerRadius(9)
//            .shadow(color: .black.opacity(0.1), radius: 9)
            
            //MARK: ---- periods of slot --------
            if  true || openSlots && (DocDetails.publishedModelSearchDoc?.DoctorScheduals?.count ?? 0) > 0 {
                VStack{
                    ForEach(DocDetails.publishedModelSearchDoc?.DoctorScheduals ?? [], id:\.id ){ sched in
                        Button(action: {
                            selectedSchedualId = sched.id ?? 0
                            if selectedSchedualId == sched.id ?? 0{
                                self.BookingFees = sched.Fees ?? 0
                                timeexpanded.toggle()
                            }else{
                                timeexpanded = true
                            }
                        }, label: {
                            HStack{
                                HStack{
                                    Text(ConvertStringDate(inp: sched.TimeFrom ?? "12:25:20", FormatFrom: "HH:mm:ss", FormatTo: "hh:mm a") )
                                        .foregroundColor(Color("darkGreen"))
                                        .font(Font.SalamtechFonts.Reg16)
                                    
                                    Text("to".localized(language))
                                        .foregroundColor(.gray)
                                        .font(Font.SalamtechFonts.Reg16)
                                    
                                    Text(ConvertStringDate(inp: sched.TimeTo ?? "24:20:20", FormatFrom: "HH:mm:ss", FormatTo: "hh:mm a") )
                                        .foregroundColor(Color("darkGreen"))
                                        .font(Font.SalamtechFonts.Reg16)
                                    
                                }
                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                
                                .background(Image("Rectangle2")
                                                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                )
                                Spacer()
                                Text("Fees:".localized(language))
                                    .foregroundColor(.gray)
                                    .font(Font.SalamtechFonts.Reg16)
                                
                                Text("\(sched.Fees ?? 0)" + "EGP".localized(language))
                                    .foregroundColor(Color("darkGreen"))
                                    .font(Font.SalamtechFonts.Reg16)
                                
                                Image( systemName: timeexpanded ?  "chevron.up":"chevron.down")
                                    .foregroundColor(Color("blueColor"))
                                    .padding(.bottom,3)
                                
                            }
//                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                .frame(height:50)
                                .padding(.horizontal)
                                .background(Color.white)
                        })
                            .frame(width: UIScreen.main.bounds.width-30)
                            .cornerRadius(9)
                            .shadow(color: .black.opacity(0.1), radius: 9)
                        if timeexpanded == true && selectedSchedualId == sched.id ?? 0{
                            slotView(slots: sched.DoctorSchedualSlots ?? [], selectedTime: $selectedTime )
                        }
                    }
                }
            }
//            ViewAboutDoctor(DoctorAbout: DocDetails.publishedModelSearchDoc?.DoctorInfo ?? "")
        }
        .onAppear(perform: {
            DocDetails.DoctorId = DoctorId
            DocDetails.ClinicId = ClinicId
            DocDetails.MedicalExaminationTypeId = ExTypeId
            DocDetails.FetchDoctorDetails()
        })
        .onChange(of:self.TappedDate ){newdate in
            DocDetails.SchedualDate = newdate
            DocDetails.publishedModelSearchDoc?.DoctorScheduals?.removeAll()
            DocDetails.FetchDoctorDetails()
        }
        .onChange(of: DocDetails.SchedualDate){newdate in
            self.TappedDate = newdate
            DocDetails.SchedualDate = newdate
            seldatenum = String(CalendarHelper().dayOfMonth(date: newdate))
        }
        .onChange(of: self.selectedTime){ newTime in
            self.selectedTime = newTime
        }
        
        // Alert with message
        .alert(isPresented: $DocDetails.isAlert, content: {
                Alert(title: Text(DocDetails.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                    DocDetails.isAlert = false
                    }))
            })

    }
}

struct ViewDateAndTime_Previews: PreviewProvider {
    static var previews: some View {
        ViewDateAndTime(ShowCalendar: .constant(false), selectedSchedualId: .constant(55), selectedTime: .constant(""), DoctorId: .constant(125), ClinicId: .constant(125), ExTypeId: .constant(3),BookingFees: .constant(0))
            .environmentObject(ViewModelDocDetails())
    }
}
