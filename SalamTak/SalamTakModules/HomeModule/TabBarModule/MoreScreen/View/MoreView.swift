//
//  MoreView.swift
//  SalamTech-DR
//
//  Created by Mostafa Morsy on 24/02/2022.
//
import SwiftUI

struct MoreView: View {
    @State var islogout:Bool = false
    @State var goToLogin:Bool = false
    
    @State var goingToPatientUpdate = false
    @State var goingToResetPassword = false
    @State var aboutApp = false
    @State var TermsAndConditions = false
//    @EnvironmentObject  var infoProfileVM : PatientInfoViewModel
//    @EnvironmentObject  var medicalProfileVM : PatientMedicalInfoViewModel
    @EnvironmentObject  var environments : EnvironmentsVM

    @StateObject  var notificationsVM = NotificationsViewModel()

    @AppStorage("languageKey")
    var language = LocalizationService.shared.language

    //---------------------
    @Binding var index :Int // 0=listing, 1=profile
    @State var secondViewId : Int = 0 // 0=Notification, 1=Change Password
    @Binding var SelectedTab :String // 0=listing, 1=profile
    @Binding var DesiredScroll : Int
    @Binding var showingList : Bool?

    var body: some View {
        ZStack {
            
            TabView (selection: self.$index){
            VStack{
                        Button(action: {
                            print("\(Helper.getUserimage())")
                        }, label: {
                            AsyncImage(url: URL(string:  Helper.getUserimage())) { image in
                                image.resizable()
                            } placeholder: {
                               ProgressView()
                            }
                            .onTapGesture(perform: {
                                print("\(Helper.getUserimage())")
                            })
                        })
                            .buttonStyle(.plain)
                            .clipShape(Rectangle())
                            .frame(width: 80, height: 80, alignment: .center)
                            .background(Color.black.opacity(0.3))
                            .cornerRadius(10)
//                            .padding(.top,hasNotch ? 60:40)
                        Spacer().frame( height: 15)
                        VStack{
                            Text("More_Screen_updateProfile".localized(language))
                                .foregroundColor(Color("blueColor"))
                                .font(.salamtakBold(of: 16))
                                .multilineTextAlignment(.center)
                        }
                        
                        ScrollView( showsIndicators: false){
                            HStack(alignment:.top){
                                Menu {
                                    Button("Arabic", action: {
                                            LocalizationService.shared.language = .arabic
                                            Helper.setLanguage(currentLanguage: "ar")
                                    })
                                        .buttonStyle(.plain)
                                    Button("English", action: {
                                                LocalizationService.shared.language = .english_us
                                                Helper.setLanguage(currentLanguage: "en")
                                    })
                                        .buttonStyle(.plain)
                                }
                            label: {
                                VStack(spacing: 5){
                                    ZStack {
                                        HStack {
                                            Image("new-arabic")
                                                .resizable()
                                                .scaledToFit()
                                            
                                            Image("new-english")
                                                .resizable()
                                                .scaledToFit()
                                        }
                                    }
                                    .frame(height:100)
                                    .frame(width:100)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke( Color("blueColor"), lineWidth: 1.5)
                                    )
                                    
                                    Text("More_Screen_Language".localized(language))
                                        .font(.salamtakBold(of: 16))
                                    //                                Spacer()
                                }
                                .frame(width:120)
                            }
                            .font(.system(size: 13))
                            .padding(.horizontal, 12)
                            .foregroundColor(Color("blueColor"))
                                
                                Button(action: {
                                    secondViewId = 0
                                    index = 2
                                }, label: {
                                    VStack(spacing: 5){
                                        ZStack {
                                            Image( notificationsVM.NewNotificationCount > 0 ? "new-hasnotifications":"new-nonotifications")
                                                .resizable()
                                                .scaledToFit()
                                                .padding()
                                        }
                                        .frame(height:100)
                                        .frame(width:100)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke( Color("blueColor"), lineWidth: 1.5)
                                        )
                                        
                                        Text("More_Screen_Notifications".localized(language))
                                            .font(.salamtakBold(of: 16))
                                    }
                                    .frame(width:120)
                                    .font(.system(size: 13))
                                    .padding(.horizontal, 12)
                                    .disableAutocorrection(true)
                                    .foregroundColor(Color("blueColor"))
                                })
                                    .buttonStyle(.plain)
                            }
                            .padding(.top,5)
                            
                            HStack(alignment:.top){
                                Button(action: {
                                    index = 1
                                }, label: {
                                    VStack(spacing: 5){
                                        ZStack {
                                            Image( "new-person")
                                                .resizable()
                                                .scaledToFit()
                                                .padding()
                                        }
                                        .frame(height:100)
                                        .frame(width:100)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke( Color("blueColor"), lineWidth: 1.5)
                                        )
                                        
                                        Text("More_Screen_myprofile".localized(language))
                                            .font(.salamtakBold(of: 16))
                                        
                                    }
                                    .frame(width:120)
                                    .font(.system(size: 13))
                                    .padding(.horizontal, 12)
                                    .disableAutocorrection(true)
                                    .foregroundColor(Color("blueColor"))
                                })
                                    .buttonStyle(.plain)
                                Button(action: {
                                    TermsAndConditions = true
                                }, label: {
                                    VStack(spacing: 5){
                                        ZStack {
                                            Image("new-like")
                                                .resizable()
                                                .scaledToFit()
                                                .padding()
                                        }
                                        .frame(height:100)
                                        .frame(width:100)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke( Color("blueColor"), lineWidth: 1.5)
                                        )
                                        
                                        Text("More_Screen_termsAndCondition".localized(language))
                                            .font(.salamtakBold(of: 16))

                                    }
                                    .frame(width:140)
                                    .font(.system(size: 13))
                                    .disableAutocorrection(true)
                                    .foregroundColor(Color("blueColor"))
                                })
                                    .buttonStyle(.plain)
                            }
                            
                            HStack(alignment:.top){
                                Button(action: {
                                    Helper.MakePhoneCall(PhoneNumber: "17143")
                                }, label: {
                                    VStack(spacing: 5){
                                        ZStack {
                                            Image("new-phone")
                                                .resizable()
                                                .scaledToFit()
                                                .padding()
                                        }
                                        .frame(height:100)
                                        .frame(width:100)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke( Color("blueColor"), lineWidth: 1.5)
                                        )
                                        
                                        Text("More_Screen_callUs".localized(language))
                                            .font(.salamtakBold(of: 16))
                                    }
                                    .frame(width:120)
                                    .font(.system(size: 13))
                                    .padding(.horizontal, 12)
                                    .disableAutocorrection(true)
                                    .foregroundColor(Color("blueColor"))
                                    
                                })
                                    .buttonStyle(.plain)
                                
                                Button(action: {
                                    aboutApp = true
                                    
    ////                                MARK: -- test crash lytics --
    //                                fatalError("Crash was triggered")
                                    
                                }, label: {
                                    VStack(spacing: 5){
                                        ZStack {
                                            Image("new-about")
                                                .resizable()
                                                .scaledToFit()
                                                .padding()
                                        }
                                        .frame(height:100)
                                        .frame(width:100)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke( Color("blueColor"), lineWidth: 1.5)
                                        )
                                        
                                        Text("More_Screen_aboutApp".localized(language))
                                            .font(.salamtakBold(of: 16))
                                    }
                                    .frame(width:120)
                                    .font(.system(size: 13))
                                    .padding(.horizontal, 12)
                                    .disableAutocorrection(true)
                                    .foregroundColor(Color("blueColor"))
                                })
                                    .buttonStyle(.plain)
                            }
                            
                            HStack(alignment:.top){
                                Button(action: {
                                    secondViewId = 1
                                    index = 2
                                }, label: {
                                    VStack(spacing: 5){
                                        ZStack {
                                            Image("new-lock")
                                                .resizable()
                                                .scaledToFit()
                                                .padding()
                                        }
                                        .frame(height:100)
                                        .frame(width:100)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke( Color("blueColor"), lineWidth: 1.5)
                                        )
                                        
                                        Text("More_Screen_resetPassword".localized(language))
                                            .font(.salamtakBold(of: 16))
                                    }
                                    .frame(width:120)
                                    .font(.system(size: 13))
                                    .padding(.horizontal, 12)
                                    .disableAutocorrection(true)
                                    .foregroundColor(Color("blueColor"))
                                })
                                    .buttonStyle(.plain)
                                Button(action: {
                                    Helper.logout()
                                    goToLogin = true
                                }, label: {
                                    VStack(spacing: 5){
                                        ZStack {
                                            Image( "new-logout")
                                                .resizable()
                                                .scaledToFit()
                                                .padding()
                                        }
                                        .frame(height:100)
                                        .frame(width:100)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke( Color("blueColor"), lineWidth: 1.5)
                                        )
                                        
                                        Text("More_Screen_SignOut".localized(language))
                                            .font(.salamtakBold(of: 16))
                                    }
                                    .frame(width:120)
                                    .font(.system(size: 13))
                                    .padding(.horizontal, 12)
                                    .disableAutocorrection(true)
                                    .foregroundColor(Color("blueColor"))
                                })
                                    .buttonStyle(.plain)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                    }
//                    .padding(.bottom,20)
                .tag(0)
//                .padding(.bottom,hasNotch ? 20:20)
                .contentShape(Rectangle()).gesture(DragGesture())

//                PatientInfoView(taskOP: .update)
                PatientProfile()
//                    .environmentObject(infoProfileVM)
//                    .environmentObject(medicalProfileVM)
                    .environmentObject(environments)
                .tag(1)
                    .contentShape(Rectangle()).gesture(DragGesture())
    //        }else if index == 2{
    //            ZStack{
                NotificationsList(SelectedTab: $SelectedTab,secondViewId: $secondViewId,DesiredScroll:$DesiredScroll)
                    .navigationBarHidden(true)
    //            }
                    .tag(2)
                    .contentShape(Rectangle())
    //                .gesture(DragGesture())
                    .environmentObject(notificationsVM)
    //        }else if index == 3{
    //            ZStack{
    //            ChangePasswordView(isChangingInside: true)
    //            }
    //                .tag(3)
    //                .contentShape(Rectangle()).gesture(DragGesture())
    //        }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            NavigationLink(destination: WelcomeScreenView()
                            .navigationBarBackButtonHidden(true),isActive:$goToLogin , label: {
            })

        }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())

            .background(
                newBackImage(backgroundcolor: .white,imageName: .image2)
            )

        
//        NavigationLink(destination: PatientProfile().navigationBarHidden(true),isActive:$goingToPatientUpdate , label: {
//        })
        
//        NavigationLink(destination: PatientInfoView(taskOP: .update,index:.constant(0)).navigationBarHidden(true),isActive:$goingToPatientUpdate , label: {
//        })
//        NavigationLink(destination: ResetPasswordView().navigationBarHidden(true),isActive:$goingToResetPassword , label: {
//        })


            .sheet(isPresented: $aboutApp, content: {
                AboutApp(isPresented: $aboutApp)
            })
        
            .sheet(isPresented: $TermsAndConditions , content: {
                ZStack{
                SalamtakWebView(url: URL(string: URLs().TermsAndConditionsURL )!   , isPresented: $TermsAndConditions)
                    VStack {
                        Spacer()
                        Button(action: {
                            // add review
                            TermsAndConditions = false
                        }, label: {
                            HStack {
                                Text("Ok".localized(language))
                                    .fontWeight(.semibold)
                                    .font(.title3)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(.green)
                            .cornerRadius(12)
                            .padding(.horizontal, 20)
                        })
                    }
                }
                    
            })

//            .alert(isPresented: $islogout, content: {
//                Alert(title: Text("you_signed_out".localized(language)), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
//                  islogout = false
//
//              }))
//            })
        
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView( index: .constant(0), SelectedTab: .constant(""), DesiredScroll: .constant(0), showingList: .constant(false))
            .environmentObject(PatientInfoViewModel())
            .environmentObject(PatientMedicalInfoViewModel())
    }
}
