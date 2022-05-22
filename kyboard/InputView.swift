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
                    Image(systemName: "tablecells.badge.ellipsis")
                        .font(.body)
                }
            EditView(items: $data.name, itemRirekis: $data.nameRireki, msg1: "作業者氏名・血液型・Rh+-", itemSave: "NAME", itemRirekiSave: "NAMERIREKI")
                .tabItem {
                    Text("氏名")
                    Image(systemName: "tablecells.badge.ellipsis")
                        .font(.body)
                }
            EditView(items: $data.sagyo, itemRirekis: $data.sagyoRireki, msg1: "作業内容", itemSave: "SAGYO", itemRirekiSave: "SAGYORIREKI")
                .tabItem {
                    Text("作業内容")
                    Image(systemName: "tablecells.badge.ellipsis")
                        .font(.body)
                }
            EditView(items: $data.kiken, itemRirekis: $data.kikenRireki, msg1: "危険予知", itemSave: "KIKEN", itemRirekiSave: "KIKENRIREKI")
                .tabItem {
                    Text("危険予知")
                    Image(systemName: "tablecells.badge.ellipsis")
                        .font(.body)
                }
            EditView(items: $data.taisaku, itemRirekis: $data.taisakuRireki, msg1: "安全対策", itemSave: "TAISAKU", itemRirekiSave: "TAISAKURIREKI")
                .tabItem {
                    Text("安全対策")
                    Image(systemName: "tablecells.badge.ellipsis")
                        .font(.body)
                }
        }
        .accentColor(.red)
        //.tabViewStyle(.page(indexDisplayMode: .automatic))
        .padding(20)
        .background(Color(red: 0.9, green: 0.9, blue: 0.9))

        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("戻る")
        }))
        .navigationTitle("編集画面")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(data: MyData())
    }
}
