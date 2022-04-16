//
//  yyyymmddView.swift
//  kyboard
//
//  Created by Xcode2021 on 2022/02/19.
//

import SwiftUI

struct yyyymmddView: View {

    @ObservedObject var data: MyData
    var dateFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateStyle = .short
        f.timeStyle = .short
        f.locale = Locale(identifier: "ja_JP")
        return f
    }

    var body: some View {
        VStack {
            Text(dateFormatter.string(from: data.yyyymmdd))
            DatePicker(selection: $data.yyyymmdd, label: { Text("年月日") })
                .datePickerStyle(.wheel)
        }
        .padding()
    }
}

struct yyyymmddView_Previews: PreviewProvider {
    static var previews: some View {
        yyyymmddView(data: MyData())
    }
}
