//
//  TermsAndConditions.swift
//  SalamTak
//
//  Created by wecancity on 20/06/2022.
//

import Foundation
import SwiftUI

struct ApproveTermsPopUp: View {
    var language = LocalizationService.shared.language
    
    @Binding var showPopUp:Bool
    @Binding var letsgo:Bool
    @Binding var Skip:Bool
    @Binding var TermsAndConditions:Bool
    
    var action: () -> Void
    var body: some View {
        ZStack{
            VStack{
                Image("Awsome")
                    .resizable()
                    .frame(width: 100, height: 55   , alignment: .center)
                    .padding(.top)
                
                Text("Pop_note_terms".localized(language))
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.center)
                    .frame(width:.infinity, height:35)
                    .foregroundColor(Color("blueColor"))
                
                Text("Pop_Subnote_terms".localized(language))
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .frame(width:.infinity, height:30)
                    .foregroundColor(Color("subText"))
                Button(action: {
                    TermsAndConditions = true
                }, label: {
                    Text("Pop_terms".localized(language))
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .frame(width:.infinity, height:30)
                        .foregroundColor(Color("darkGreen"))
                })
                
                HStack{
                    Spacer()
                        .frame(width:15)
                    Button(action: {
                        self.showPopUp = false
                        self.Skip = true
                    }, label: {
                        HStack{
                            Spacer().frame(width:2)
                            
                            Text("Pop_cancel_terms".localized(language))
                                .foregroundColor(Color("blueColor"))
                                .bold()
                                .frame( height: 45 )
                                .padding([.leading,.trailing],30)
                                .background(Color(uiColor: .lightGray).opacity(0.3) )
                                .cornerRadius(8)
                            Spacer().frame(width:2)
                        }
                    }
                    )
                    Spacer()
                    Button(action: {
                        action()
                        
                        self.showPopUp = false
                        self.letsgo = true
                    }, label: {
                        HStack{
                            Spacer().frame(width:2)
                            
                            Text("Pop_approve_terms".localized(language))
                                .foregroundColor(.white)
                                .bold()
                                .frame( height: 45 )
                                .padding([.leading,.trailing],30)
                                .background(Color("blueColor"))
                            
                                .cornerRadius(8)
                            Spacer().frame(width:2)
                        }
                    }
                    )
                    Spacer().frame(width:5)
                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                
                    .frame( height: 45 )
                    .padding([.leading,.trailing],10)
                    .padding(.bottom,20)
            }
            
            .frame(width:UIScreen.main.bounds.width - 60 , height: 250 )
            .background(Color.white)
            .cornerRadius(12)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height,alignment: .center )
        .padding([.leading,.trailing],0)
        .edgesIgnoringSafeArea(.all)
        .background(Color.black.opacity(0.2))
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}



struct ApproveTermsPopUp_Previews: PreviewProvider {
    static var previews: some View {
        ApproveTermsPopUp( showPopUp: .constant(false),letsgo: .constant(false),Skip: .constant(false), TermsAndConditions: .constant(false), action: {})
    }
}

