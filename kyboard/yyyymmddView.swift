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
            if data.yyyymmdd != nil {
                Text(dateFormatter.string(from: data.yyyymmdd!))
                    .font(.title)
            } else {
                Text(" ")
                    .font(.title)
            }
            DatePicker(selection: $yyyymmddTemp, displayedComponents: [.date]) {
                Text("年月日選択")
                    .padding()
            }
                .datePickerStyle(.wheel)

            DatePicker(selection: $yyyymmddTemp, displayedComponents: [.hourAndMinute]) {
                Text("時刻選択")
                    .padding()
            }
                .datePickerStyle(.wheel)
            HStack {
                Spacer()
                Button(action: {

                    data.yyyymmdd = yyyymmddTemp

                    UserDefaults.standard.set(data.yyyymmdd, forKey: "YMD")

                }) {
                    Text("年月日時刻設定")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 3, x: 10, y: 10)
                }
                Spacer()
                Button(action: {
                    deleAlertMain = true
                }) {
                    Text("現在時刻取得")
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 3, x: 10, y: 10)
                }
                .alert(isPresented: $deleAlertMain) {
                    Alert(title: Text("確認"), message: Text("現在時刻に置き換えますか？"), primaryButton:
                                .default(Text("はい"), action: {
                        self.data.yyyymmdd = Date()
                    }), secondaryButton: .cancel(Text("やめる")))
                }
                Spacer()
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
