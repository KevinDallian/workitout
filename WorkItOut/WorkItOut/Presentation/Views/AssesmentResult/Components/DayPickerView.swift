//
//  DayPickerView.swift
//  WorkItOut
//
//  Created by Jeremy Raymond on 02/11/23.
//

import SwiftUI

struct DayPickerView: View {
    @EnvironmentObject var vm: GeneratePlanViewModel
    var days: [Day] = [.monday, .wednesday, .friday]
    @State var selection: Day = .monday
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(days, id:\.self) { day in
                DayPickView(selected: $selection, day: day)
            }
        }
        .padding(0)
    }
}

#Preview {
    DayPickerView()
}
