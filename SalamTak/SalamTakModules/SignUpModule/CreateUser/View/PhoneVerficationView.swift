//
//  PhoneVerification.swift
//  Salamtech-Dr
//
//  Created by wecancity on 03/01/2022.
//
import SwiftUI
import Combine


struct PhoneVerificationView: View {
    var language = LocalizationService.shared.language
    @EnvironmentObject var RegisterUserVM : ViewModelRegister
    // for creating user after confirming OTP
    @StateObject  var CreateUserVM = ViewModelCreateUser()
    @State private var matchedOTP = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var minutes: Int = 00
    @State private var seconds: Int = 00
    
    @State private var fieldOne = ""
    @State private var fieldTwo   = ""
    @State private var fieldThree = ""
    @State private var fieldFour  = ""
    @State private var hideIncorrectCode = true
    @StateObject var viewModel = OTPViewModel()
    @State var isErrorCode = false
    
    let textBoxWidth = UIScreen.main.bounds.width / 8
    let textBoxHeight = UIScreen.main.bounds.width / 8
    let spaceBetweenBoxes: CGFloat = 10
    let paddingOfBox: CGFloat = 1
    var textFieldOriginalWidth: CGFloat {
        (textBoxWidth*4)+(spaceBetweenBoxes*3)+((paddingOfBox*2)*3)
    }
    @FocusState  var isfocused : Bool
    
    var body: some View {
        
        ZStack {
            ScrollView(){
                Spacer().frame(height:120)
                Text("PhoneVerfication_Screen_subtitle".localized(language) + " (\(RegisterUserVM.publishedUserRegisteredModel?.Code ?? 0))").font(.custom("SF UI Text", size: 16))
                    .foregroundColor(Color("subTitle"))
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
                        .padding()
                        .frame( alignment: .center)
                        .multilineTextAlignment(.center)
                    
                }
                
                
                Text("Code sent to +2\(CreateUserVM.phoneNumber )").font(.custom("SF UI Text", size: 16)).fontWeight(.light)
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
                    RegisterUserVM.startFetchUserRegisteration()
                    hideIncorrectCode =  true
                    self.DynamicTimer(sentTimer: RegisterUserVM.publishedUserRegisteredModel?.ReSendCounter ?? 60)
                    
                }, label: { Text("PhoneVerfication_Screen_resendCode".localized(language))
                        .font(.title3)
                        .foregroundColor( (minutes == 00 && seconds == 00) ? Color("darkGreen") : Color(uiColor: .lightGray))
                    
                }).disabled(minutes != 00 && seconds != 00)
                
                
                Button(action: {
                    // send code action
                    let otp = viewModel.otp1+viewModel.otp2+viewModel.otp3+viewModel.otp4
                    if checkOTP(sentOTP: RegisterUserVM.publishedUserRegisteredModel?.Code ?? 1111, TypedOTP: Int(otp) ?? 0000){
                        self.matchedOTP.toggle()
                        // Create User
                        CreateUserVM.startFetchUserCreation()
                    }else{
                        hideIncorrectCode =  false
                        print("not Matching")
                    }
                    
                }, label: {
                    Text("PhoneVerfication_Screen_sendCode_Button".localized(language))
                        .fontWeight(.semibold)
                        .frame(width: 220, height: 53)
                        .foregroundColor( .white)
                        .background( viewModel.otp4 != "" ? Color("mainColor") :                                 Color(uiColor: .lightGray) )
                        .cornerRadius(6.0)
                    
                }).padding(.top, 120)
                    .disabled(viewModel.otp4 == "" || (minutes == 00 && seconds == 00))
                
                NavigationLink(destination: PersonalDataView(),isActive: $matchedOTP, label: {
                })
                
                // Alert with no internet connection
                    .alert(isPresented: $isErrorCode, content: {
                        Alert(title: Text("Error Code"), message: nil, dismissButton: .cancel())
                    })
                
                
                Spacer()
            }  .edgesIgnoringSafeArea(.all)
                .keyboardSpace()
            AppBarView(Title: "PhoneVerfication_Screen_title".localized(language))
//                    .navigationBarItems(leading: BackButtonView())
                .navigationBarBackButtonHidden(true)

        }
        .navigationViewStyle(StackNavigationViewStyle())
        
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
        .onAppear(perform: {
            DynamicTimer(sentTimer: RegisterUserVM.publishedUserRegisteredModel?.ReSendCounter ?? 60)
            CreateUserVM.fullName = RegisterUserVM.fullName
            CreateUserVM.email = RegisterUserVM.email
            CreateUserVM.phoneNumber = RegisterUserVM.phoneNumber
            CreateUserVM.password = RegisterUserVM.password
            
        })
        
        // Alert with no internet connection
        .alert(isPresented: $CreateUserVM.isAlert, content: {
            Alert(title: Text(CreateUserVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                CreateUserVM.isAlert = false
            }))
        })
        
        
    }
    
    private func otpText(text: String) -> some View {
        return Text(text)
            .font(.SalamtechOTPFont36)
            .foregroundColor(Color("mainColor"))
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

struct PhoneVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            PhoneVerificationView().environmentObject(ViewModelRegister())
        }
    }
}

extension Font {
    static var SalamtechOTPFont36: Font {
        return Font.custom("SF UI Text", size: 35)
    }
}
