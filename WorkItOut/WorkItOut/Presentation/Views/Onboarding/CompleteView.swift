//
//  CompleteView.swift
//  WorkItOut
//
//  Created by Kevin Dallian on 25/10/23.
//

import SwiftUI

struct CompleteView: View {
    var counter: Double = 0.75
    
    var body: some View {
        let strings: [Double : LocalizedStringResource] = [
            1.5 : "Curating best yoga poses for your pregnancy weeks",
            1 : "Taking into account your health conditions",
            0.5 : "Predicting best sessions for your schedules",
        ]
        
        ZStack {
            VStack {
                Image("AssesmentBackground")
                Spacer()
            }
            VStack {
                Text("Creating Exercise Plan")
                    .font(.title.bold())
                Text("Please wait, we are crafting the best exercise plan for you")
                    .frame(width: 240)
                    .multilineTextAlignment(.center)
                LoadingCircle()
                    .padding(96)
                Text(strings[counter] ?? strings.randomElement()!.value)
                    .frame(width: 240)
                    .multilineTextAlignment(.center)
                
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CompleteView()
}
