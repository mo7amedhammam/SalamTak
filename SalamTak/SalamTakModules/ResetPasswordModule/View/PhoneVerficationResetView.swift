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
                AppBarView(Title: "PhoneVerfication_Screen_title".localized(language))
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
                
                if hideIncorrectCode == false {
                    Text("PhoneVerfication_Screen_codeMessage".localized(language)).font(.custom("SF UI Text", size: 14)).fontWeight(.light)
                        .foregroundColor(.red)
                        .padding()
                        .frame( alignment: .center)
                        .multilineTextAlignment(.center)
                }
                
                Text("Code \n\(passedmodel?.publishedUserResetModel?.code ?? 0)").font(.custom("SF UI Text", size: 16)).fontWeight(.light)
                    .foregroundColor(.black)
                    .padding()
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
                
                
                Button(action: {
                    // resend code action
                    minutes = 02
                    hideIncorrectCode =  true
                    
                }, label: { Text("PhoneVerfication_Screen_resendCode".localized(language))
                        .font(.title3)
                        .foregroundColor( (minutes == 00 && seconds == 00) ? Color("darkGreen") : Color(uiColor: .lightGray))
                    
                }).disabled(minutes != 00 && seconds != 00)
                
                Button(action: {
                    // send code action
                    
                    let otp = viewModel.otp1+viewModel.otp2+viewModel.otp3+viewModel.otp4
                    if checkOTP(sentOTP: passedmodel?.publishedUserResetModel?.code ?? 1111, TypedOTP: Int(otp) ?? 0000){
                        self.matchedOTP.toggle()
                        self.userId = passedmodel?.publishedUserResetModel?.userId ?? 0
                    }else{
                        hideIncorrectCode =  false
                        print("not Matching")
                        isErrorCode = true
                    }
                    
                }, label: {
                    Text("PhoneVerfication_Screen_sendCode_Button".localized(language))
                        .fontWeight(.semibold)
                        .frame(width: 220, height: 53)
                        .foregroundColor( .white)
                        .background( viewModel.otp4 != "" ? Color("blueColor") :                                 Color(uiColor: .lightGray) )
                        .cornerRadius(6.0)
                    
                }).padding(.top, 120)
                    .disabled(viewModel.otp4 == "" || (minutes == 00 && seconds == 00))
                
                NavigationLink(destination: ChangePasswordView(userId: $userId),isActive: $matchedOTP, label: {
                })
                
                // Alert with no internet connection
                    .alert(isPresented: $isErrorCode, content: {
                        Alert(title: Text("Error_Code".localized(language)), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                            isErrorCode = false
                        }))
                    })
                
                Spacer()
            }  .edgesIgnoringSafeArea(.all)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .adaptsToKeyboard()
        .ignoresSafeArea()
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
            .font(.SalamtechOTPFont36)
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
    
}


struct PhoneVerificationResetView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
        PhoneVerificationResetView()
    }
    }
}


