//
//  ViewSummary.swift
//  SalamTech
//
//  Created by wecancity on 17/04/2022.
//


import SwiftUI
import Kingfisher
import ImageViewerRemote
//import XCTest

struct ViewSummary:View{
    var language = LocalizationService.shared.language

    var Doctor:Doc
  @StateObject var CreateAppointment = VMCreateAppointment()
    
    @Binding var ExType :Int
    
    @Binding var BookingscedualId :Int
    @Binding var BookiDate :Date
    @Binding var BookiTime :String
    
    @State var GotoSchedual = false
  
//    @EnvironmentObject var Tap:selectedtapNum
//    @StateObject var selectedTab = selectedtapNum()
    @State var ispreviewImage = false
    @State var previewImageurl = ""
    @State var goToLogin = false


    

    var body: some View{
//        NavigationView{

//        ZStack {
            ZStack{

                VStack {
                    ScrollView{

                                  
                            
//                                Spacer().frame(height:15)
                            ZStack {
                                VStack(alignment:.leading){
                                    
                                    ViewTopSection(Doctor: Doctor, ispreviewImage: $ispreviewImage, previewImageurl: $previewImageurl)
                                  
                                    Image("Line")
                                        .resizable()
                                        .renderingMode(.original)
                                        .tint(.black)
                                        .frame( height: 2)
                                        .foregroundColor(.black)
                        //MARK: ----- Booking Details --------
                                    VStack(spacing:5){
                                            HStack {
                                                Text("Booking_details".localized(language))
                                                Spacer()
                                            }.padding(.leading)
                                            .padding(.vertical,10)
                                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                                        HStack(){
                                                Image("Appointments")
                                                    .resizable()
                                                    .foregroundColor(Color("darkGreen"))
                                                    .frame(width: 25, height: 25)
                                                    .padding(.leading)
                                            VStack(alignment:.leading){
                                                Text("Booking_Date_&_Time_:".localized(language))
                                                    .foregroundColor(Color("darkGreen"))
                                                    .font(Font.SalamtechFonts.Reg14)
                                                
                                                Text(ConvertDateFormateToStr(inp: BookiDate, FormatTo: "dd MMM. yyyy") + " ( \( ConvertStringDate(inp: BookiTime, FormatFrom: "HH:mm:ss", FormatTo: "hh:mm a")) )" )
                                                    .foregroundColor(.secondary)
                                                    .font(Font.SalamtechFonts.Reg14)
                                                
                                                }
                                                .padding(.trailing)
                                            Spacer()
                                        }.padding(.leading)
                                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                                            
                                                    HStack{
                                                        Image(systemName: getEx(id: ExType).image ?? "")
                                                    .resizable()
                                                    .foregroundColor(Color("darkGreen"))
                                                    .frame(width: 25, height: 25)
                                                    .aspectRatio( contentMode: .fit)
                                                    .padding(.leading)

                                                        VStack(alignment:.leading){
                                                            Text("\(getEx(id: ExType).name ?? "") " + "Appointment".localized(language) + ":")
                                                    .foregroundColor(Color("darkGreen"))
                                                    .font(Font.SalamtechFonts.Reg14)
                                                    Text(getEx(id: ExType).Comment ?? "")
                                                    .foregroundColor(.secondary)
                                                    .font(Font.SalamtechFonts.Reg14)
                                                
                                                }
                                                .padding(.trailing)
                                        
                                                        Spacer()

                                        }.padding(.leading)
                                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                                            
                                            HStack{
                                        Image("doc4")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .padding(.leading)
                                                
                                                VStack(alignment:.leading){
                                                    Text("Waiting_Time:".localized(language))
                                            .foregroundColor(Color("darkGreen"))
                                            .font(Font.SalamtechFonts.Reg14)
                                                    Text("\(Doctor.WaitingTime ?? 15) " + "Minutes".localized(language))
                                            .foregroundColor(.secondary)
                                            .font(Font.SalamtechFonts.Reg14)
                                        
                                        }
                                        .padding(.trailing)
                                
                                                Spacer()

                                }.padding(.leading)
                                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                            .cornerRadius(9)
                                    }
                                    
                        //MARK: ----- Patient Details ------
                                    VStack(spacing:10){
                                        HStack {
                                            Text("Patient_details".localized(language))
                                            Spacer()
                                        }

                                        .padding(.leading)
                                            .padding(.vertical,10)
                                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)


                                    HStack(){
                                            Image("person")
                                                .resizable()
                                                .foregroundColor(Color("darkGreen"))

                                                .frame(width: 25, height: 25)
                                                .padding(.leading)
                                        HStack{
                                            Text("Patient_Name_:".localized(language))
                                                .foregroundColor(Color("darkGreen"))
                                                .font(Font.SalamtechFonts.Reg14)
                                            Text(  Helper.getpatientName() )
                                                .foregroundColor(.secondary)
                                                .font(Font.SalamtechFonts.Reg14)
                                            
                                            }
                                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                                            .padding(.trailing)
                                        Spacer()
                                    }.padding(.leading)
                                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                                                HStack{
                                                    Image( "Phone")
                                                .resizable()
        //                                        .renderingMode(.original)
                                                .foregroundColor(Color("darkGreen"))
                                                .frame(width: 25, height: 25)
                                                .padding(.leading)
                                                    
                                                    HStack(){
                                                        Text("Patient_Number_:".localized(language))
                                                .foregroundColor(Color("darkGreen"))
                                                .font(Font.SalamtechFonts.Reg14)
                                                        Text("\(Helper.getUserPhone() )" )
                                                .foregroundColor(.secondary)
                                                .font(Font.SalamtechFonts.Reg14)
                                            
                                            }
                                            .padding(.trailing)
                                    
                                                    Spacer()

                                    }.padding(.leading)
                                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                                        
                                        
                                        HStack{
                                            Circle()
                                                .fill(Color("CLVBG"))
                                                            .shadow(color: .black.opacity(0.2), radius: 2)
                                                            .frame(width: 40, height: 40).padding(.leading,-20)
                                            Image("Line")
                                                .resizable()
                                                .renderingMode(.original)
                                                .tint(.black)
                                                .frame( height: 2)
                                                .foregroundColor(.black)
                                            Circle()
                                                .fill(Color("CLVBG"))
                                                            .shadow(color: .black.opacity(0.2), radius: 2)
                                                            .frame(width: 40, height: 40).padding(.trailing,-20)

                                        }
                                        .padding(.bottom,0)
                                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)


                                        
                                        HStack{
                                            Text("Total_Fee".localized(language))
                                          Spacer()
                                            ZStack {
                                                Text("\(String(Doctor.FeesFrom ?? 0.0)) "+"EGP".localized(language))
                                                    .fontWeight(.semibold)
                                                    .font(.title3)
        //                                            .padding(.all,10)
                                            }
                                            .padding(10)
                                            .foregroundColor(Color("darkGreen"))
                                            .background(Color("darkGreen").opacity(0.3))
                                            .cornerRadius(12)
                                            .border( .regularMaterial ,width: 1.1)

                                            //                                    .clipShape(RoundedRectangle(cornerSize: .init( )) )

                                        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                                        .padding(.top, 0)

                                        .padding(.horizontal, 20)
                                    }

                                    Spacer()
                                    
                                }

                                .background(Color.white)
                                .cornerRadius(9)
                            .shadow(color: .black.opacity(0.1), radius: 9)
                                
                            }
                            .padding(.horizontal,15)


                        }
    //                    .padding(.top,120)

        //                .frame(width: UIScreen.main.bounds.width)
    //                        .edgesIgnoringSafeArea(.vertical)
                    .background(Color("CLVBG"))
                }

                VStack{
                    AppBarView(Title: "Summary".localized(language))
//                            .navigationBarItems(leading: BackButtonView())
                        .navigationBarBackButtonHidden(true)
                    Spacer()
                }
                .edgesIgnoringSafeArea(.top)

//                VStack{
//                        Spacer()
                    ConfirmBooking(IsPresented: .constant(true), content: {
                            HStack{
                                    ZStack() {
                                        Text("\(String(Doctor.FeesFrom ?? 0.0))")                                .font(.system(size: 18))
                                            .padding(.top,-20)

                                        Text("\n"+"EGP".localized(language))
                                            .font(.system(size: 15))
                                            .foregroundColor(.black.opacity(0.5))
                                            .padding(.bottom,-20)

                                    }
                                    .padding(.leading)
                                    Button(action: {
                                        // Create patient appointment
                                        CreateAppointment.isLoading = true
                                        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                                            CreateAppointment.CreatePatientAppointment()
                                        })
                                        
                                        //                                            print("patient id : \(Helper.getUserID())")
//                                            print("schedual id : \(BookingscedualId)")
//                                            print("schedual dateTime : \(Filterdatef.string(from: BookiDate))T\(BookiTime)")
//                                            print("fees : \(Doctor.FeesFrom ?? 00)")
                                        
                                    }, label: {
                                        HStack {
                                            Text("Confirm".localized(language))
                                                .fontWeight(.semibold)
                                                .font(.title2)
                                        }
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Color("blueColor"))
                                        .cornerRadius(12)
                                        .padding(.horizontal, 20)
                                    })
                                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                                .frame( height: 60)
                                .padding(.horizontal)
                                .padding(.bottom,20)

                    })

//                }
//                // Alert with Error message
//                    .alert(CreateAppointment.errorMsg, isPresented: $CreateAppointment.isError) {
//                        Button("OK".localized(language), role: .cancel) { }
//                }

                // showing loading indicator
                ActivityIndicatorView(isPresented: $CreateAppointment.isLoading)
                 
//                    .overlay(content: {
                        ImageViewerRemote(imageURL: $previewImageurl , viewerShown: $ispreviewImage, disableCache: true, closeButtonTopRight: true)
//                    })

                
        //      go to clinic info
                NavigationLink(destination:TabBarView(selectedTab1:"TabBar_schedual"),isActive: $GotoSchedual) {
                     }
       
        //      go to clinic info
                        NavigationLink(destination:WelcomeScreenView(),isActive: $goToLogin) {
                             }
                
            }
//            .navigationBarHidden(ispreviewImage)
            .navigationViewStyle(StackNavigationViewStyle())
            .background(Color.red)
//                .edgesIgnoringSafeArea(.vertical)
                

                .onAppear(perform: {
                    CreateAppointment.DoctorId = Doctor.id ?? 0
                    CreateAppointment.DoctorWorkingDayTimeId = BookingscedualId
                    CreateAppointment.AppointmentDate = "\(Filterdatef.string(from: BookiDate))T\(BookiTime)"
                    CreateAppointment.Fees = Doctor.FeesFrom  ?? 00
                })
           
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if self.CreateAppointment.isDone == false && !ispreviewImage{
                            BackButtonView()
                        }
                    }
                }
               
            
    //            .popup(isPresented: .constant(true)){
                        .popup(isPresented: $CreateAppointment.isDone){
                    BottomPopupView{
                        ZStack{
                            VStack{
                                Image("Awsome")
                                    .resizable()
                                    .frame(width: 100, height: 55 , alignment: .center)
                                    .padding(.top)
                                
                                Text("Confirmed!".localized(language))
                                    .foregroundColor(Color("blueColor"))
                                    .font(.system(size: 24, weight: .bold))
                                    .padding()

                                Text("Your_appointment_is".localized(language) + "\n \(ConvertDateFormateToStr(inp: BookiDate, FormatTo: "dd MMM. yyyy") + " ( \( ConvertStringDate(inp: BookiTime, FormatFrom: "HH:mm:ss", FormatTo: "hh:mm a")) )")")
                                    .font(.system(size: 18))
                                    .multilineTextAlignment(.center)
    //                                .padding()
                                    .foregroundColor(Color("subText"))
                                    .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                
                            Button(action: {
                                // Goto my scheduals
//                                selectedTab.tabNum = "TabBar_schedual"
                                CreateAppointment.isDone = false
                                GotoSchedual = true

                            }, label: {
                                HStack {
                                    Text("Myـschedule".localized(language))
                                        .fontWeight(.semibold)
                                        .font(.title2)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color("blueColor"))
                                .cornerRadius(12)
                                .padding(.horizontal, 20)
                            })
//                                    .environmentObject(selectedTab)
                        }
                        
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(12)

                        Spacer()
                    }
                    .shadow(color: .black.opacity(0.3), radius: 12)
                    .padding()
                    }
            
//        }

        
//     }
  
     .navigationBarHidden(ispreviewImage)
//     .navigationBarBackButtonHidden(true)

 

        // Alert with no internet connection
            .alert(isPresented: $CreateAppointment.isAlert, content: {
                
                switch CreateAppointment.activeAlert{
                case .NetworkError :
                    return   Alert(title: Text("Check_Your_Internet_Connection".localized(language)), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                        CreateAppointment.isAlert = false

                    }))
                    
                case .serverError :
                    return  Alert(title: Text(CreateAppointment.errorMsg), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                        CreateAppointment.isAlert = false

                    }))
                    
                case .success :
                    return Alert(title: Text(CreateAppointment.errorMsg), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                        CreateAppointment.isAlert = false
                 
                }))
                case .unauthorized:
                    return Alert(title: Text("Session_expired\nlogin_again".localized(language)), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                        CreateAppointment.isAlert = false
                        self.goToLogin = true

                      
                     }))
                
                }
                })
        
        
        
    }
  
}

struct ViewSummary_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ViewSummary(Doctor: Doc.init(), ExType: .constant(5),BookingscedualId :.constant(645454545),BookiDate :.constant(Date()),BookiTime :.constant("18:33"))
        }.navigationBarHidden(true)
    }
}





struct ConfirmBooking <Content: View>: View {

    let content: Content
    var language : Language
      var IsPresented: Binding<Bool>

    init(  IsPresented:Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.language = LocalizationService.shared.language
        self.IsPresented = IsPresented
        self.content = content()
    }

    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                
              
                
                VStack {
                        Capsule()
                            .frame(width: 50, height: 4)
                            .foregroundColor(.gray)
                            .padding(.top ,10)
                            .padding(.bottom,20)
                    
                    VStack {
                        self.content
                    }

                }.background(
                    RoundedRectangle(cornerRadius: 40.0)
                        .foregroundColor(.white)
                        .ignoresSafeArea()
                        .opacity(1.5)
                        .shadow(radius: 15)
                        .frame(width: UIScreen.main.bounds.width)

)

            }
//            .background(Color.red)
//                .edgesIgnoringSafeArea(.bottom)

        }
        .edgesIgnoringSafeArea(.bottom)
//        .frame(width: UIScreen.main.bounds.width)
//        .background(
//            Color.black.opacity(0.3)
////                .blur(radius: 12)
//        )
        .onTapGesture(perform: {
            IsPresented.wrappedValue.toggle()

        })
        
    }
}
