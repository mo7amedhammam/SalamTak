//
//  PhoneVerficationResetView.swift
//  SalamTech-DR
//
//  Created by Mostafa Morsy on 03/03/2022.
//

import SwiftUI


struct PhoneVerificationResetView: View {
    var language = LocalizationService.shared.language
    
    var passedmodel : ViewModelResetPassword? = nil

    @State private var matchedOTP = false
    

//    @State private var timeRemaining = 120

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var minutes: Int = 02
    @State private var seconds: Int = 00

    @State private var fieldOne = ""
    @State private var fieldTwo   = ""
    @State private var fieldThree = ""
    @State private var fieldFour  = ""
    
    @State private var hideIncorrectCode = true
    @State var userId = 0
    @StateObject var viewModel = OTPViewModel()
    @State var isFocused = false
    @State var isErrorCode = false
    
    let textBoxWidth = UIScreen.main.bounds.width / 8
    let textBoxHeight = UIScreen.main.bounds.width / 8
    let spaceBetweenBoxes: CGFloat = 10
    let paddingOfBox: CGFloat = 1
    var textFieldOriginalWidth: CGFloat {
        (textBoxWidth*4)+(spaceBetweenBoxes*3)+((paddingOfBox*2)*3)
    }
    @FocusState private var isfocused : Bool

    var body: some View {
        
        ZStack {
            VStack( spacing: 1){
                AppBarView(Title: "PhoneVerfication_Screen_title".localized(language),withbackButton: true)
                    .navigationBarItems(leading: BackButtonView())
                    .navigationBarBackButtonHidden(true)
                Text("PhoneVerfication_Screen_subtitle".localized(language)).font(.custom("SF UI Text", size: 16))
                    .foregroundColor(Color("subText"))
                    .padding(.top, 35)
                    .multilineTextAlignment(.center)
                
                
                ZStack {
                    HStack (spacing: spaceBetweenBoxes){
                        otpText(text: viewModel.otp1)
                        otpText(text: viewModel.otp2)
                        otpText(text: viewModel.otp3)
                        otpText(text: viewModel.otp4)
                    }
                    
                    TextField("", text: $viewModel.otpField)
                        .focused($isfocused)
                        .autocapitalization(.none)
                        .frame(width: isfocused ? 2 : textFieldOriginalWidth, height: textBoxHeight)
                        .disabled(viewModel.isTextFieldDisabled)
                        .textContentType(.oneTimeCode)
                        .foregroundColor(.clear)
                        .accentColor(.clear)
                        .background(Color.clear)
                        .keyboardType(.numberPad)
                }.padding(.top, 25)
                
                if hideIncorrectCode == false || (minutes == 0 && seconds == 0 ) {
                    Text("PhoneVerfication_Screen_codeMessage".localized(language)).font(.custom("SF UI Text", size: 14)).fontWeight(.light)
                        .foregroundColor(.red)
                        .padding(.top,20)
                        .frame( alignment: .center)
                        .multilineTextAlignment(.center)
                    
                }
                Text("Code sent to \n+2\(passedmodel?.phoneNumber ?? "" )").font(.custom("SF UI Text", size: 16)).fontWeight(.light)
                    .foregroundColor(.black)
                    .frame( alignment: .center)
                    .multilineTextAlignment(.center)
                    .padding(.top,20)
                    .padding(.bottom,50)
                
                
                Group{
                    Text("The code will be expired within").font(.custom("SF UI Text", size: 16))
                        .fontWeight(.light)
                        .foregroundColor(Color("blueColor"))
//                        .padding()
                        .frame( alignment: .center)
                        .multilineTextAlignment(.center)
                Text("\(minutes):\(seconds)")
                    .font(.subheadline)
                    .onReceive(timer) { time in
                        updateTimer()
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.2)
                    )
                }
                .padding(.bottom)
                        
                Button(action: {
                    // resend code action
                    passedmodel?.startFetchResetPassword()
                    hideIncorrectCode =  true
                    DynamicTimer(sentTimer: passedmodel?.publishedUserResetModel?.resendCounter ?? 60)
                    
                }, label: { Text("PhoneVerfication_Screen_resendCode".localized(language))
                        .font(.title3)
                        .foregroundColor( (minutes == 00 && seconds == 00) ? Color("darkGreen") : Color("blueColor"))
                }).disabled(minutes != 00 && seconds != 00)
                    .frame(height:40)
                    .padding(.horizontal,40)
                    .overlay(
                                   RoundedRectangle(cornerRadius: 25)
                                    .stroke(minutes != 00 && seconds != 00 ? Color("blueColor").opacity(0.5):Color("blueColor"), lineWidth: 1.5)
                           )
                    .padding(.top,15)
                
//                        Button(action: {
//                            let otp = viewModel.otp1+viewModel.otp2+viewModel.otp3+viewModel.otp4
//                            if checkOTP(sentOTP: passedmodel?.publishedUserResetModel?.code ?? 1111, TypedOTP: Int(otp) ?? 0000){
//                                self.matchedOTP.toggle()
//                                self.userId = passedmodel?.publishedUserResetModel?.userId ?? 0
//                            }else{
//                                hideIncorrectCode =  false
//                                    print("not Matching")
//                                }
//
//                        }, label: {
//                            Text("PhoneVerfication_Screen_sendCode_Button".localized(language))
//                                    .fontWeight(.semibold)
//                                    .frame(width: 220, height: 53)
//                                    .foregroundColor( .white)
//                                    .background( viewModel.otp4 != "" ? Color("blueColor") :                                 Color(uiColor: .lightGray) )
//                                    .cornerRadius(6.0)
//
//                        }).padding(.top, 120)
//                    .disabled(viewModel.otp4 == "" || (minutes == 00 && seconds == 00))
                
                NavigationLink(destination: ChangePasswordView(),isActive: $matchedOTP, label: {
                })
                
                // Alert with no internet connection
                    .alert(isPresented: $isErrorCode, content: {
                Alert(title: Text("Error Code"), message: nil, dismissButton: .cancel())
                })
                
                        Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
        }  .adaptsToKeyboard()
            .ignoresSafeArea()
            .onChange(of: viewModel.otp4, perform: { newval in
//                    viewModel.otp4 = newval
                let otp = viewModel.otp1+viewModel.otp2+viewModel.otp3+newval
                if checkOTP(sentOTP: passedmodel?.publishedUserResetModel?.code ?? 1111, TypedOTP: Int(otp) ?? 0000){
                    self.matchedOTP.toggle()
                    self.userId = passedmodel?.publishedUserResetModel?.userId ?? 0
                }else{
                    hideIncorrectCode =  false
                        print("not Matching")
                    }
            })
        
            .background(
                newBackImage(backgroundcolor: .white, imageName: .image1)
            )

            .onTapGesture(perform: {
                hideKeyboard()
            })
            .toolbar{
                ToolbarItemGroup(placement: .keyboard ){
                    Spacer()
                    Button("Done"){
                        isfocused = false
                    }
                }
            }

    }
        
        
        
        private func otpText(text: String) -> some View {
            
            return Text(text)
                .font(.salamtakRegular(of: 36))
                .foregroundColor(Color("blueColor"))
                .frame(width: textBoxWidth, height: textBoxHeight)
                .background(
                    RoundedRectangle(cornerRadius: 6).frame(width: 55, height: 55, alignment: .center)
                        .foregroundColor(Color(uiColor: .secondaryLabel ).opacity(0.2))
                )
                .padding(paddingOfBox)
        }
    
    func updateTimer(){
      
       if self.seconds > 0 {
    self.seconds = self.seconds - 1
}
else if self.minutes > 0 && self.seconds == 0 {
    self.minutes = self.minutes - 1
    self.seconds = 59
}
        }
    
    //MARK: validOTP
    func checkOTP(sentOTP:Int, TypedOTP:Int ) -> Bool{
        if sentOTP == TypedOTP {
            return true
        }else{
            return false
        }
        }
    
    //MARK: validOTP
    func DynamicTimer(sentTimer:Int ){
        self.minutes = sentTimer/60
        
    }

    
    }
 



    struct PhoneVerificationResetView_Previews: PreviewProvider {
        static var previews: some View {
            VStack {
//                AppBarView(Title: "Sign In")
//                    .navigationBarItems(leading: BackButtonView())
//                    .navigationBarBackButtonHidden(true)
            PhoneVerificationResetView()
                
//                Spacer()
//
            }
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        }
    }
    


