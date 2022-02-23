//
//  ContentView.swift
//  kyboard
//
//  Created by Xcode2021 on 2022/01/09.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var data = MyData()
    //追記
    let def = UserDefaults.standard
    var dateFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateStyle = .short
        f.timeStyle = .short
        f.locale = Locale(identifier: "ja_JP")
        return f
    }
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    VStack(alignment: .leading) {
                        Text("【年月日】")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title)
                        Text(dateFormatter.string(from: data.yyyymmdd))
                            .font(.title2)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .border(Color("keisenColor"), width: 2)

                    VStack(alignment: .leading) {
                        Text("【氏名　血液型】")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title)
                        ForEach(0 ..< data.name.count, id: \.self) {i in
                            Text(data.name[i])
                        }
                        .font(.title2)
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .border(Color("keisenColor"), width: 2)

                    VStack(alignment: .leading) {
                        Text("【作業内容】")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title)
                        ForEach(0 ..< data.sagyo.count, id:\.self) {i in
                            Text(data.sagyo[i])
                        }
                        .font(.title2)
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .border(Color("keisenColor"), width: 2)

                    VStack(alignment: .leading) {
                        Text("【危険予知】")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title)
                        ForEach(0 ..< data.kiken.count, id:\.self) {i in
                            Text(data.kiken[i])
                        }
                        .font(.title2)
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .border(Color("keisenColor"), width: 2)

                    VStack(alignment: .leading) {
                        Text("【安全対策】")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title)
                        ForEach(0 ..< data.taisaku.count, id:\.self) {i in
                            Text(data.taisaku[i])
                        }
                        .font(.title2)
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .border(Color("keisenColor"), width: 2)
                }
                Button(action: {
                    //保持データのクリア
                    UserDefaults.standard.removeObject(forKey: "NAME")
                    UserDefaults.standard.removeObject(forKey: "NAMERIREKI")
                    UserDefaults.standard.removeObject(forKey: "SAGYO")
                    UserDefaults.standard.removeObject(forKey: "SAGYORIREKI")
                    UserDefaults.standard.removeObject(forKey: "KIKEN")
                    UserDefaults.standard.removeObject(forKey: "KIKENRIREKI")
                    UserDefaults.standard.removeObject(forKey: "TAISAKU")
                    UserDefaults.standard.removeObject(forKey: "TAISAKURIREKI")
                    data.name = []
                    data.nameRireki = []
                    data.sagyo = []
                    data.sagyoRireki = []
                    data.kiken = []
                    data.kikenRireki = []
                    data.taisaku = []
                    data.taisakuRireki = []
                }) {
                    Text("保持データのクリア(デバック用機能)")
                        .padding(.all, 10)
                        .foregroundColor(.black)
                        .background(Color(white: 0.95))
                        .cornerRadius(10)
                }
            }



            .padding()
            //.font(.system(size: 25, weight: .regular, design: .monospaced))

            .navigationTitle("KYDoc（危険予知記録）")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing: NavigationLink(
                                    destination: InputView(data: data),
                                    label: {
                                        Text("編集画面へ")
                                    }))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        //追記
        .onAppear {
            let tmp1 = def.array(forKey: "NAME") as? [String]
            if (tmp1 != nil) {
                data.name = tmp1!
                print("123")
            }
            let tmp2 = def.array(forKey: "NAMERIREKI") as? [String]
            if (tmp2 != nil) {
                    data.nameRireki = tmp2!
                print("abc")
            }
            let tmp3 = def.array(forKey: "SAGYO") as? [String]
            if (tmp3 != nil) {
                data.sagyo = tmp3!
                print("123")
            }
            let tmp4 = def.array(forKey: "SAGYORIREKI") as? [String]
            if (tmp4 != nil) {
                    data.sagyoRireki = tmp4!
                print("abc")
            }
            let tmp5 = def.array(forKey: "KIKEN") as? [String]
            if (tmp5 != nil) {
                data.kiken = tmp5!
                print("123")
            }
            let tmp6 = def.array(forKey: "KIKENRIREKI") as? [String]
            if (tmp6 != nil) {
                    data.kikenRireki = tmp6!
                print("abc")
            }
            let tmp7 = def.array(forKey: "TAISAKU") as? [String]
            if (tmp7 != nil) {
                data.taisaku = tmp7!
                print("123")
            }
            let tmp8 = def.array(forKey: "TAISAKURIREKI") as? [String]
            if (tmp8 != nil) {
                    data.kikenRireki = tmp8!
                print("abc")
            }
            print("hij")
            //データロード部分
            let Ntmp1 = UserDefaults.standard.stringArray(forKey: "NAME")
            let NRtmp1 = UserDefaults.standard.stringArray(forKey: "NAMERIREKI")
            let Stmp2 = UserDefaults.standard.stringArray(forKey: "SAGYO")
            let SRtmp2 = UserDefaults.standard.stringArray(forKey: "SAGYORIREKI")
            let Ktmp3 = UserDefaults.standard.stringArray(forKey: "KIKEN")
            let KRtmp3 = UserDefaults.standard.stringArray(forKey: "KIKENRIREKI")
            let Ttmp4 = UserDefaults.standard.stringArray(forKey: "TAISAKU")
            let TRtmp4 = UserDefaults.standard.stringArray(forKey: "TAISAKURIREKI")

            if Ntmp1 != nil {
                data.name = Ntmp1!
                print("データNAMEを読み込み成功")
            }
            if NRtmp1 != nil {
                data.nameRireki = NRtmp1!
                print("データNAMERIREKIを読み込み成功")
            }
            if Stmp2 != nil {
                data.sagyo = Stmp2!
                print("データSAGYOを読み込み成功")
            }
            if SRtmp2 != nil {
                data.sagyoRireki = SRtmp2!
                print("データSAGYORIREKIを読み込み成功")
            }
            if Ktmp3 != nil {
                data.kiken = Ktmp3!
                print("データKIKENを読み込み成功")
            }
            if KRtmp3 != nil {
                data.kikenRireki = KRtmp3!
                print("データKIKENRIREKIを読み込み成功")
            }
            if Ttmp4 != nil {
                data.taisaku = Ttmp4!
                print("データKIKENを読み込み成功")
            }
            if TRtmp4 != nil {
                data.taisakuRireki = TRtmp4!
                print("データKIKENを読み込み成功")
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)

            ContentView()

        }
    }
}
