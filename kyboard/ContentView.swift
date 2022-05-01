//
//  ContentView.swift
//  kyboard
//
//  Created by Xcode2021 on 2022/01/09.
//

import SwiftUI
import UIKit
import PDFKit

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

    @State var rect: CGRect = .zero
    @State var uiImage: UIImage? = nil
    @State var flag = false
    @State var deleAlertMain = false

    var body: some View {
        let tempfile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("KY.pdf")

            NavigationView {
                            ScrollView {
                                            VStack(spacing: 10) {
                                                VStack(alignment: .leading) {
                                                    Text("【年月日】")
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .font(.title)
                                                    if data.yyyymmdd != nil {
                                                        Text(dateFormatter.string(from: data.yyyymmdd!))
                                                            .font(.title2)
                                                    } else {
                                                        Text("")
                                                            .font(.title2)
                                                    }
                                                }
                                                .padding()
                                                .frame(maxWidth: .infinity)
                                                .border(Color("keisenColor"), width: 2)

                                                VStack(alignment: .leading) {
                                                    Text("【氏名　血液型】")
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .font(.title)
                                                    ForEach(0 ..< data.name.count, id: \.self) {i in
                                                        HStack{
                                                            Text(String(format: "(%3d)", i + 1))
                                                                .frame(width: 70,alignment: .trailing)
                                                            Text(data.name[i])
                                                        }
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
                                                        HStack{
                                                            Text(String(format: "(%3d)", i + 1))
                                                                .frame(width: 70)
                                                            Text(data.sagyo[i])
                                                        }

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
                                                        HStack{
                                                            Text(String(format: "(%3d)", i + 1))
                                                                .frame(width: 70)
                                                            Text(data.kiken[i])
                                                        }

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
                                                        HStack{
                                                            Text(String(format: "(%3d)", i + 1))
                                                                .frame(width: 70)
                                                            Text(data.taisaku[i])
                                                        }

                                                    }
                                                    .font(.title2)
                                                    Spacer()
                                                }
                                                .padding()
                                                .frame(maxWidth: .infinity)
                                                .border(Color("keisenColor"), width: 2)
                                            }

                                            Button(action: {
                                                deleAlertMain = true
                                            }) {
                                                Text("全クリア")
                                                    .padding(.all, 10)
                                                    .foregroundColor(.black)
                                                    .background(Color(white: 0.95))
                                                    .cornerRadius(10)
                                            }
                                            .alert(isPresented: $deleAlertMain) {
                                                Alert(title:  Text("確認"), message: Text("全ての項目を完全に削除しますか？"), primaryButton: .default(Text("はい"), action: {
                                                    //保持データのクリア
                                                                                                    UserDefaults.standard.removeObject(forKey: "NAME")
                                                                                                    UserDefaults.standard.removeObject(forKey: "NAMERIREKI")
                                                                                                    UserDefaults.standard.removeObject(forKey: "SAGYO")
                                                                                                    UserDefaults.standard.removeObject(forKey: "SAGYORIREKI")
                                                                                                    UserDefaults.standard.removeObject(forKey: "KIKEN")
                                                                                                    UserDefaults.standard.removeObject(forKey: "KIKENRIREKI")
                                                                                                    UserDefaults.standard.removeObject(forKey: "TAISAKU")
                                                                                                    UserDefaults.standard.removeObject(forKey: "TAISAKURIREKI")
                                                                                                    data.yyyymmdd = nil
                                                                                                    data.name = []
                                                                                                    data.nameRireki = []
                                                                                                    data.sagyo = []
                                                                                                    data.sagyoRireki = []
                                                                                                    data.kiken = []
                                                                                                    data.kikenRireki = []
                                                                                                    data.taisaku = []
                                                                                                    data.taisakuRireki = []

                                                }),
                                                      secondaryButton: .cancel(Text("やめる"))
                                                )
                                            }

                            }
                        .padding()
                        //.font(.system(size: 25, weight: .regular, design: .monospaced))

                        .navigationTitle("KY-Board（危険予知記録）")
                        .navigationBarTitleDisplayMode(.large)
                        .navigationBarItems(trailing:
                            HStack {
                                Button(action: {
                                    let pdf = PDFDocument(data: makeData())
                                    pdf!.write(to: tempfile)
                                    flag = true
                                }) {
                                    VStack(spacing: 0) {
                                        Image(systemName: "square.and.arrow.up")
                                            .font(.body)
                                        Text("PDF共有")
                                            .font(.caption)
                                    }
                                }
                                .sheet(isPresented: $flag) {
                                    ActivityView(items: [tempfile])
                                }
                                NavigationLink(
                                    destination: InputView(data: data),
                                    label: {
                                        Text("編集画面へ")
                                })
                            }
                                                )
                    }
                    .navigationViewStyle(StackNavigationViewStyle())


        //追記
        .onAppear {
            //データロード部分
            let YMDtmp = UserDefaults.standard.object(forKey: "YMD") as? Date
            let Ntmp1 = UserDefaults.standard.stringArray(forKey: "NAME")
            let NRtmp1 = UserDefaults.standard.stringArray(forKey: "NAMERIREKI")
            let Stmp2 = UserDefaults.standard.stringArray(forKey: "SAGYO")
            let SRtmp2 = UserDefaults.standard.stringArray(forKey: "SAGYORIREKI")
            let Ktmp3 = UserDefaults.standard.stringArray(forKey: "KIKEN")
            let KRtmp3 = UserDefaults.standard.stringArray(forKey: "KIKENRIREKI")
            let Ttmp4 = UserDefaults.standard.stringArray(forKey: "TAISAKU")
            let TRtmp4 = UserDefaults.standard.stringArray(forKey: "TAISAKURIREKI")

            if YMDtmp != nil {
                data.yyyymmdd = YMDtmp
                print("年月日を読み込み成功")
            }
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
    //新PDF
    func makeData() -> Data {
        var ctx: UIGraphicsPDFRendererContext!
        var att20: [NSAttributedString.Key: Any]!
        var y1: CGFloat = 0
        var y2: CGFloat = 0

        let a4_w = 210 * 72 / 25.4
        let a4_h = 297 * 72 / 25.4

        func makeTable(lst: [String], lbl: String) {
            for i in 0 ... lst.count {
                if y2 + 30 > a4_h - 20 {
                    UIColor.black.setStroke()
                    UIBezierPath(rect: CGRect(x: 20, y: y1, width: a4_w - 40, height: y2 - y1)).stroke()
                    ctx.beginPage()
                    y1 = 20
                    y2 = y1
                    NSAttributedString(string: lbl, attributes: att20).draw(at: CGPoint(x: 30, y: y2 + 5))
                    y2 += 30
                }

                NSAttributedString(string: i == 0 ? lbl : String(format: "(%3d)", i) + "   \(lst[i - 1])", attributes: att20).draw(at: CGPoint(x: 30, y: y2 + 5))
                y2 += 30
            }
            UIColor.black.setStroke()
            UIBezierPath(rect: CGRect(x: 20, y: y1, width: a4_w - 40, height: y2 - y1)).stroke()
        }

        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: a4_w, height: a4_h))

        let data = renderer.pdfData { content in
            ctx = content
            ctx.beginPage()

            att20 = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]

            y1 = 20
            y2 = y1

            //タイトル
            NSAttributedString(string: "KY-Bord（危険予知記録）", attributes: att20).draw(at: CGPoint(x: 30, y: y2 + 10))
            y2 += 40

            //日付
            y1 = y2 + 20
            y2 = y1
            NSAttributedString(string: "【年月日】", attributes: att20).draw(at: CGPoint(x: 30, y: y2 + 10))
            y2 += 40
            NSAttributedString(string: dateFormatter.string(from: self.data.yyyymmdd!), attributes: att20).draw(at: CGPoint(x: 30, y: y2 + 10))
            y2 += 40
            UIBezierPath(rect: CGRect(x: 20, y: y1, width: a4_w - 40, height: y2 - y1)).stroke()

            //表1
            y1 = y2 + 15
            y2 = y1
            makeTable(lst: self.data.name, lbl: "【氏名　血液型】")

            //表2
            y1 = y2 + 15
            y2 = y1
            makeTable(lst: self.data.sagyo, lbl: "【作業内容】")

            //表3
            y1 = y2 + 15
            y2 = y1
            makeTable(lst: self.data.kiken, lbl: "【危険予知】")

            //表4
            y1 = y2 + 15
            y2 = y1
            makeTable(lst: self.data.taisaku, lbl: "【安全対策】")
        }
        return data
    }
}

struct ActivityView: UIViewControllerRepresentable {
    var items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        return UIActivityViewController(activityItems: items, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
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




