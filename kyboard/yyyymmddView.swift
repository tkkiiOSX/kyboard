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
    @State var yyyymmddTemp: Date = Date()

    var body: some View {
        VStack {
            Button(action: {
                data.yyyymmdd = yyyymmddTemp
                UserDefaults.standard.set(data.yyyymmdd, forKey: "YMD")
            }) {
                Text("年月日時刻設定")
            }
            if data.yyyymmdd != nil {
                Text(dateFormatter.string(from: data.yyyymmdd!))
                    .font(.title2)
            } else {
                Text("")
                    .font(.title2)
            }

            DatePicker(selection: $yyyymmddTemp, label: { Text("年月日時刻") })
                .datePickerStyle(.wheel)
        }
        .padding()
        .onAppear {
            if data.yyyymmdd != nil {
                yyyymmddTemp = data.yyyymmdd!
            }
        }
    }
}

struct yyyymmddView_Previews: PreviewProvider {
    static var previews: some View {
        yyyymmddView(data: MyData())
    }
}
