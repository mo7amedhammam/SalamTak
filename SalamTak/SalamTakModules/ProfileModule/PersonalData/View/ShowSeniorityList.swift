//
//  ShowSeniorityList.swift
//  SalamTak
//
//  Created by wecancity on 12/01/2023.
//

import SwiftUI

struct ShowSeniorityList: View {

    @Binding var ShowSeniority:Bool
    @Binding var SelectedSeniorityName : String
    @Binding var SelectedSeniorityId : Int
        
        var body: some View {
            ZStack {
                ChooseSeniority(IsPresented: $ShowSeniority, SelectedSeniorityName: $SelectedSeniorityName, SelectedSeniorityId: $SelectedSeniorityId)
            }
            .transition(.move(edge: .bottom))
            .background(
                Color.black
                    .ignoresSafeArea()
                    .opacity(0.3)
                    .blur(radius: 0.5)
                    .disabled(ShowSeniority)
            )
            .onTapGesture(perform: {
                ShowSeniority = false
            })
        }
    }

    struct ShowSeniorityList_Previews: PreviewProvider {
        static var previews: some View {
            
            ShowSeniorityList(ShowSeniority: .constant(true),SelectedSeniorityName: .constant(""),SelectedSeniorityId: .constant(0))
        }
    }
