//
//  ViewSummary.swift
//  SalamTech
//
//  Created by wecancity on 17/04/2022.
//


import SwiftUI
import Kingfisher

struct ViewSummary:View{
    var Doctor:Doc = Doc.init(id: 1, SumRate: 3, Rate: 3, NumVisites: 5, WaitingTime: 15, FeesFrom: 230, FeesTo: 250, DoctorName: "mohamed hammam", SpecialistName: "surgery", SeniortyLevelName: "senior", ClinicName: "clinic name ", ClinicAddress: "add", Image: "imag", AvailableFrom: "av from", SubSpecialistName: ["sub", "sub1"], MedicalExamationTypeImage: [])
    @State var showQuickLogin = false

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

                                
                        Spacer().frame(height:11)
                    ZStack {
                        VStack(alignment:.leading){
                            
                            ViewTopSection(Doctor: Doctor)
                          
                            Image("Line")
                                .resizable()
                                .renderingMode(.original)
                                .tint(.black)
                                .frame( height: 2)
                                .foregroundColor(.black)
                            
                            VStack(spacing:5){
                                    HStack {
                                        Text("Booking details")
                                        Spacer()
                                    }.padding(.leading)
                                    .padding(.vertical,10)
                                HStack(){
                                        Image("Appointments")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .padding(.leading)
                                    VStack(alignment:.leading){
                                        Text("Booking Date & Time :")
                                            .foregroundColor(Color("darkGreen"))
                                            .font(Font.SalamtechFonts.Reg14)
                                            Text( String( Doctor.ClinicName ?? "08 Feb. 2022  (08:00 PM)"))
                                            .foregroundColor(.secondary)
                                            .font(Font.SalamtechFonts.Reg14)
                                        
                                        }
                                        .padding(.trailing)
                                    Spacer()
                                }.padding(.leading)
                                    
                                            HStack{
                                        Image("Phone")
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
                                        Text(  Doctor.ClinicName ?? "Mostafa Morsy")
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
                                        Text("\(Doctor.ClinicName ?? "01201201255")" )
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
                                        Text("230 EGP")
                                            .fontWeight(.semibold)
                                            .font(.title2)
                                            .padding(.all,10)
                                    }
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
                    .cornerRadius(9)
                    .shadow(color: .black.opacity(0.1), radius: 9)
                    }
                    
                    .padding(.horizontal,10)
                    Spacer()
                 
                    ConfirmBooking(IsPresented: $showQuickLogin, content: {
                        VStack {
                            HStack{
                                    ZStack() {
                                        Text("230")                                .font(.system(size: 18))
                                            .padding(.top,-20)

                                        Text("\nEGP")
                                            .font(.system(size: 15))
                                            .foregroundColor(.black.opacity(0.5))
                                            .padding(.bottom,-20)

                                    }
                                    .padding(.leading)
                                    Button(action: {
                                        // add review
                                        showQuickLogin =  true
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
//                            .padding(.bottom,10)
                            Spacer()
                        }
                    })
                        .edgesIgnoringSafeArea(.bottom)



                }
//                .frame(width: UIScreen.main.bounds.width)
                    .edgesIgnoringSafeArea(.vertical)
                    .background(Color("CLVBG"))

            
      
            
         

    
            
        }
            .edgesIgnoringSafeArea(.vertical)
            .onAppear(perform: {

            })
        
        
       
        
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
            ViewSummary(Doctor: Doc.init())
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

        }
        .frame(width: UIScreen.main.bounds.width)
//        .background(
//            Color.black.opacity(0.3)
//                .blur(radius: 12)
//        )
        .onTapGesture(perform: {
            IsPresented.wrappedValue.toggle()

        })
        
    }
}
