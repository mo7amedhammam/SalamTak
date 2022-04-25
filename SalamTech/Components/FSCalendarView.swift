//
//  FSCalendarView.swift
//  SalamTech
//
//  Created by wecancity on 23/04/2022.
//

import UIKit
import SwiftUI
import FSCalendar


struct FSCalendarView: UIViewRepresentable {
    
    typealias UIViewType = FSCalendar
    @Binding var SelectedDate : Date
    var calendar = FSCalendar()
    
  
    func updateUIView(_ uiView: FSCalendar, context: Context) {}
    
    func makeUIView(context: Context) -> FSCalendar {
        calendar.dataSource = context.coordinator
        calendar.delegate = context.coordinator

        calendar.scope = .week
        calendar.appearance.weekdayTextColor = UIColor(Color("blueColor"))
        calendar.appearance.headerTitleColor = UIColor(Color("blueColor"))
        calendar.appearance.selectionColor = UIColor.blue
        calendar.appearance.todayColor = UIColor.orange
        calendar.appearance.todaySelectionColor = UIColor.black
        calendar.appearance.weekdayFont = UIFont(name: "Futura", size: 20)
//        calendar.appearance.calendar.weekdayTextSize =
//        self.calendar.preferredWeekdayHeight =
//        let height = calendar.height - calendar.preferredHeaderHeight - calendar.preferredWeekdayHeight
//         calendar.contentView.height = height
//         calendar.daysContainer.height = height
//         calendar.collectionView.height = height
//         calendar.collectionViewLayout.invalidateLayout()

        return calendar
    }
    func makeCoordinator() -> coordinator {
        coordinator(self)
    }

    class coordinator :NSObject, FSCalendarDelegate, FSCalendarDataSource{
        var parent: FSCalendarView
        init(_ parent: FSCalendarView){
            self.parent = parent
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.SelectedDate = date
        }
        
//        func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
//            self.calendarHeightConstraint.constant = bounds.height
//            self.view.layoutIfNeeded()
//        }

        
        
    }
    
  
    
}



struct calview:View{
    @State var selectedDate = Date()
    var body: some View{
        VStack{
            FSCalendarView(SelectedDate: $selectedDate)
//                .padding()
        }
    }
}
struct calview_Previews: PreviewProvider {
    static var previews: some View {
        calview().navigationBarHidden(true)
    }
}



struct calendarPopUp:View{
    @Binding var selectedDate : Date
    @Binding var isPresented : Bool

    var body: some View{
        if isPresented{
        ZStack {
                DatePicker("", selection: $selectedDate, in: Date()..., displayedComponents: .date )
                    .datePickerStyle(.graphical)
                    .background(.white)
                    .cornerRadius(22)
                    .padding()

            
            
        }
        .shadow(color: .black.opacity(0.3), radius: 12)
                .onChange(of: selectedDate){_ in
                    isPresented = false
                }
        }
           

    }
}
struct calendarPopUp_Previews: PreviewProvider {
    static var previews: some View {
        calendarPopUp(selectedDate: .constant(Date()), isPresented: .constant(true))
        
    }
}



