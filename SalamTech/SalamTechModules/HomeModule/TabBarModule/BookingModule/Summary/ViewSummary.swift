//
//  ViewSummary.swift
//  SalamTech
//
//  Created by wecancity on 17/04/2022.
//


import SwiftUI
import Kingfisher
//import XCTest

struct ViewSummary:View{
    var Doctor:Doc
  @StateObject var CreateAppointment = VMCreateAppointment()
    
    @Binding var ExType :Int
    
    @Binding var BookingscedualId :Int
    @Binding var BookiDate :Date
    @Binding var BookiTime :String
    
    @State var GotoSchedual = false

    

    var body: some View{
//        NavigationView{

        ZStack{
            
                VStack{
                    VStack{
                        AppBarView(Title: "Summary")
                            .navigationBarItems(leading: BackButtonView())
                            .navigationBarBackButtonHidden(true)
                        Spacer()
                    }
                    .edgesIgnoringSafeArea(.vertical)

                          
                    
                        Spacer().frame(height:15)
                    ZStack {
                        VStack(alignment:.leading){
                            
                            ViewTopSection(Doctor: Doctor)
                          
                            Image("Line")
                                .resizable()
                                .renderingMode(.original)
                                .tint(.black)
                                .frame( height: 2)
                                .foregroundColor(.black)
                //MARK: ----- Booking Details --------
                            VStack(spacing:5){
                                    HStack {
                                        Text("Booking details")
                                        Spacer()
                                    }.padding(.leading)
                                    .padding(.vertical,10)
                                HStack(){
                                        Image("Appointments")
                                            .resizable()
                                            .foregroundColor(Color("darkGreen"))
                                            .frame(width: 25, height: 25)
                                            .padding(.leading)
                                    VStack(alignment:.leading){
                                        Text("Booking Date & Time :")
                                            .foregroundColor(Color("darkGreen"))
                                            .font(Font.SalamtechFonts.Reg14)
                                        Text( String( "\(Filterdatef.string(from: BookiDate)) (\(BookiTime))" ))
                                            .foregroundColor(.secondary)
                                            .font(Font.SalamtechFonts.Reg14)
                                        
                                        }
                                        .padding(.trailing)
                                    Spacer()
                                }.padding(.leading)
                                    
                                            HStack{
                                        Image(LogoType(MedicalExaminationTypeId: ExType))
                                            .resizable()
                                            .foregroundColor(Color("darkGreen"))
                                            .frame(width: 25, height: 25)
                                            .padding(.leading)
                                                
                                                VStack(alignment:.leading){
                                        Text("Call Appointment :")
                                            .foregroundColor(Color("darkGreen"))
                                            .font(Font.SalamtechFonts.Reg14)
                                            Text("Doctor will call you on time")
                                            .foregroundColor(.secondary)
                                            .font(Font.SalamtechFonts.Reg14)
                                        
                                        }
                                        .padding(.trailing)
                                
                                                Spacer()

                                }.padding(.leading)
                                    
                                    HStack{
                                Image("doc4")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(.leading)
                                        
                                        VStack(alignment:.leading){
                                Text("Waiting Time :")
                                    .foregroundColor(Color("darkGreen"))
                                    .font(Font.SalamtechFonts.Reg14)
                                    Text("\(Doctor.WaitingTime ?? 15)" + " Minutes")
                                    .foregroundColor(.secondary)
                                    .font(Font.SalamtechFonts.Reg14)
                                
                                }
                                .padding(.trailing)
                        
                                        Spacer()

                        }.padding(.leading)
                    .cornerRadius(9)
                            }
                            
                //MARK: ----- Patient Details ------
                            VStack(spacing:10){
                                HStack {
                                    Text("Patient  details")
                                    Spacer()
                                }
                                .padding(.leading)
                                    .padding(.vertical,10)

                            HStack(){
                                    Image("person")
                                        .resizable()
                                        .foregroundColor(Color("darkGreen"))

                                        .frame(width: 25, height: 25)
                                        .padding(.leading)
                                HStack{
                                    Text("Patient Name :")
                                        .foregroundColor(Color("darkGreen"))
                                        .font(Font.SalamtechFonts.Reg14)
                                    Text(  Helper.getpatientName() )
                                        .foregroundColor(.secondary)
                                        .font(Font.SalamtechFonts.Reg14)
                                    
                                    }
                                    .padding(.trailing)
                                Spacer()
                            }.padding(.leading)
                                        HStack{
                                            Image( "Phone")
                                        .resizable()
//                                        .renderingMode(.original)
                                        .foregroundColor(Color("darkGreen"))
                                        .frame(width: 25, height: 25)
                                        .padding(.leading)
                                            
                                            HStack(){
                                    Text("Patient Number :")
                                        .foregroundColor(Color("darkGreen"))
                                        .font(Font.SalamtechFonts.Reg14)
                                                Text("\(Helper.getUserPhone() )" )
                                        .foregroundColor(.secondary)
                                        .font(Font.SalamtechFonts.Reg14)
                                    
                                    }
                                    .padding(.trailing)
                            
                                            Spacer()

                            }.padding(.leading)
                                
                                
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

                                }                                .padding(.bottom,0)

                                
                                HStack{
                                    Text("Total Fee")
                                  Spacer()
                                    ZStack {
                                        Text("\(String(Doctor.FeesFrom ?? 0.0)) EGP")
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

                                }
                                .padding(.top, 0)

                                .padding(.horizontal, 20)
                            }

                            Spacer()
                            
                        }

                        .background(Color.white)
//                        .background(
//                            Image("summaryBack")
//                                .resizable()
//                                .padding()
//                        )
                    .cornerRadius(9)
                    .shadow(color: .black.opacity(0.1), radius: 9)
                        
                    }
                    
                    .padding(.horizontal,15)
                    Spacer()
                 //


                    VStack{
//                        Spacer()
                        ConfirmBooking(IsPresented: .constant(true), content: {
                                HStack{
                                        ZStack() {
                                            Text("\(String(Doctor.FeesFrom ?? 0.0))")                                .font(.system(size: 18))
                                                .padding(.top,-20)

                                            Text("\nEGP")
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
                                                Text("Confirm")
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
                                    }
                                    .frame( height: 60)
                                    .padding(.horizontal)
                                    .padding(.bottom,20)

                        })

                    }
                    
//                    .edgesIgnoringSafeArea(.vertical)


                }
            
            
            
            
            
//                .frame(width: UIScreen.main.bounds.width)
                    .edgesIgnoringSafeArea(.vertical)
                    .background(Color("CLVBG"))

            
      
            
            // Alert with Error message
                .alert(CreateAppointment.errorMsg, isPresented: $CreateAppointment.isError) {
                                    Button("OK", role: .cancel) { }
            }

            // showing loading indicator
            ActivityIndicatorView(isPresented: $CreateAppointment.isLoading)
              
        }
        .background(Color.red)
            .edgesIgnoringSafeArea(.vertical)
        
            .onAppear(perform: {
                CreateAppointment.PatientId = Helper.getUserID()
            
                CreateAppointment.DoctorWorkingDayTimeId = BookingscedualId
                CreateAppointment.AppointmentDate = "\(Filterdatef.string(from: BookiDate))T\(BookiTime)"
                CreateAppointment.Fees = Doctor.FeesFrom  ?? 00
            })
       
        
            .popup(isPresented: .constant(true)){
//                    .popup(isPresented: $CreateAppointment.isDone){
                BottomPopupView{
                    ZStack{
                        VStack{
                            Image("Awsome")
                                .resizable()
                                .frame(width: 100, height: 55 , alignment: .center)
                                .padding(.top)
                            
                        Text("Confirmed!")
                                .foregroundColor(Color("blueColor"))
                                .font(.system(size: 24, weight: .bold))
                                .padding()

                    Text("Your appointment is\nFeb. 2022  (08:00 PM)")
                                .font(.system(size: 18))
                                .multilineTextAlignment(.center)
//                                .padding()
                                .foregroundColor(Color("subText"))
                            
                        Button(action: {
                            // Goto my scheduals
                            GotoSchedual = true
                        }, label: {
                            HStack {
                                Text("My schedule")
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

      
        
//     }
        
     // go to clinic info
//        NavigationLink(destination:SpecialityView(),isActive: $gotoSpec) {
//             }
//     .navigationBarHidden(true)
//     .navigationBarBackButtonHidden(true)

        
    }
    
    


    
}

struct ViewSummary_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ViewSummary(Doctor: Doc.init(), ExType: .constant(645454545),BookingscedualId :.constant(645454545),BookiDate :.constant(Date()),BookiTime :.constant("645454545"))
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
