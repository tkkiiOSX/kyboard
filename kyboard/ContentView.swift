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


    var body: some View {
        let tempfile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("KY.pdf")

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
                }
                NSAttributedString(string: i == 0 ? lbl : lst[i - 1], attributes: att20).draw(at: CGPoint(x: 30, y: y2 + 5))
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
            NSAttributedString(string: dateFormatter.string(from: self.data.yyyymmdd), attributes: att20).draw(at: CGPoint(x: 30, y: y2 + 10))
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

    //旧PDF
    /*func makeData() -> Data {
        let rect = CGRect(x: 0, y: 0, width: 595, height: 842)

        let renderer = UIGraphicsPDFRenderer(bounds: rect)
        let data = renderer.pdfData { context in
            context.beginPage()

            //PDF内容はここに書く
            UIColor.black.setStroke()
            let path = UIBezierPath(rect: CGRect(x: 10, y: 10, width: 595 - 20, height: 842 * 2 - 20))
            path.stroke()

            let txtA = "KY-Board（危険予知記録）"
            let att1 = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)
            ]
            txtA.draw(at: CGPoint(x: 50, y: 50), withAttributes: att1)

            let txtY = "【年月日】"
            let att2 = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)
            ]
            txtY.draw(at: CGPoint(x: 50, y: 50 + 50), withAttributes: att2)

            let txtYMD = dateFormatter.string(from: self.data.yyyymmdd)

            txtYMD.draw(at: CGPoint(x: 50, y: 150), withAttributes: att1)

            let txtS = "【作業内容】"
            let att3 = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)
            ]
            txtS.draw(at: CGPoint(x: 50, y: 200), withAttributes: att3)

            for i in 0 ..< self.data.name.count {
                let txtN = self.data.name[i]
                txtN.draw(at: CGPoint(x: 50, y: 30 * i + 250), withAttributes: att1)
            }

            for i in 0 ..< self.data.sagyo.count {
                let txtS = self.data.sagyo[i]
                txtS.draw(at: CGPoint(x: 50, y: 30 * i + 250 + self.data.name.count * 30 + 30), withAttributes: att1)
            }
            for i in 0 ..< self.data.kiken.count {
                let txtK = self.data.kiken[i]
                txtK.draw(at: CGPoint(x: 50, y: 30 * i + 250 + self.data.name.count * 30 + 30 + self.data.sagyo.count * 30 + 30), withAttributes: att1)
            }
            for i in 0 ..< self.data.taisaku.count {
                let txtK = self.data.taisaku[i]
                txtK.draw(at: CGPoint(x: 50, y: 30 * i + 250 + self.data.name.count * 30 + 30 + self.data.sagyo.count * 30 + 30 + self.data.kiken.count * 30 + 30), withAttributes: att1)
            }
        }
        return data
    }*/



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




