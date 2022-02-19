//
//  InputView.swift
//  KY20211219
//
//  Created by Xcode2021 on 2021/12/26.
//

import SwiftUI

struct InputView: View {
    @StateObject  var data: MyData
    //@ObservedObject var data: MyData
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        TabView {
            yyyymmddView(data: data)
                .tabItem {
                    Text("年月日")
                }
            NameView(data: data)
                .tabItem {
                    Text("名前")
                }
            SagyoView(data: data)
                .tabItem {
                    Text("作業")
                }
            KikenView(data: data)
                .tabItem {
                    Text("危険")
                }
            TaisakuView(data: data)
                .tabItem {
                    Text("対策")
                }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            //キーと値の保存
            //UserDefaults.standard.set(値, forKey: "キー")
            //UserDefaults.standard.set(data, forKey: "data")
            self.presentationMode.wrappedValue.dismiss()

        }, label: {
            Text("戻る")
        }))

    }
}


struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(data: MyData())
    }
}
