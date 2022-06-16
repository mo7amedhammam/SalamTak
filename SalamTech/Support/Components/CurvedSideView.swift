//
//  CurvedSideRectangleView.swift
//  Salamtech-Dr
//
//  Created by wecancity agency on 12/27/21.
//

import SwiftUI

struct CurvedSideRectangleView: Shape {
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: 0, y: rect.maxY),
                          control: CGPoint(x: rect.midX, y: rect.maxY + 35))
        path.closeSubpath()
        
        return path
    }
}

struct CurvedSideRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        CurvedSideRectangleView()
            .frame(height: 100)
    }
}
