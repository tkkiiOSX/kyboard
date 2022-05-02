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
    @State var deleAlertMain = false

    var body: some View {
        VStack {
            Button(action: {
                data.yyyymmdd = yyyymmddTemp
                UserDefaults.standard.set(data.yyyymmdd, forKey: "YMD")
            }) {
                Text("年月日時刻設定")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            if data.yyyymmdd != nil {
                Text(dateFormatter.string(from: data.yyyymmdd!))
                    .font(.title2)
            } else {
                Text("")
                    .font(.title2)
            }

            DatePicker(selection: $yyyymmddTemp, label: { Text("年月日時刻選択")
                    .padding()
                     })
                .datePickerStyle(.wheel)

            Button(action: {
                deleAlertMain = true

            }) {
                Text("現在時刻取得")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .alert(isPresented: $deleAlertMain) {
                Alert(title: Text("確認"), message: Text("現在時刻に置き換えますか？"), primaryButton: .default(Text("はい"), action: {
                    self.data.yyyymmdd = Date()
                }), secondaryButton: .cancel(Text("やめる")))
            }
        }
        .font(.system(size: 20, weight: .regular, design: .monospaced))
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
