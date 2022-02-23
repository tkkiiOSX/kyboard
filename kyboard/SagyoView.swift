import SwiftUI

struct SagyoView: View {
    @ObservedObject var data: MyData
    @State var tempS = ""
    @State var Ssel1 = 0
    @State var deleAlert = false

    @State var indexSave: IndexSet = IndexSet()

    let def = UserDefaults.standard

    var body: some View {
        VStack {
            EditButton()
            List {
                Section(header:
                            Text("【作業内容】")) {
                    ForEach(0 ..< data.sagyo.count, id: \.self) {i in
                        Text(data.sagyo[i])
                    }
                    .onDelete { indexDel in
                        data.sagyo.remove(atOffsets: indexDel)
                    }
                    .onMove { src, dst in
                        data.sagyo.move(fromOffsets: src, toOffset: dst)
                    }
                }
            }
            //.listStyle(SidebarListStyle())

            if data.sagyoRireki.count > 0 {
                HStack {
                    Picker(selection: $Ssel1, label: Text("作業選択")) {
                        ForEach(0 ..< data.sagyoRireki.count, id: \.self) {i in
                            Text(data.sagyoRireki[i])
                        }
                    }
                    Button(action: {
                        data.sagyo.append(data.sagyoRireki[Ssel1])
                        Ssel1 = 0
                        //追記
                        def.set(data.sagyo, forKey: "SAGYO" )
                        def.set(data.sagyoRireki, forKey: "SAGYORIREKI" )
                    }) {
                        Text("作業内容を選択する")
                    }
                }
            }

            HStack {
                TextField("作業内容を入力ください", text: $tempS)
                Button(action: {
                    data.sagyo.append(tempS)
                    data.sagyoRireki.append(tempS)
                    tempS = ""
                    //追記
                    //def.set(data.sagyo, forKey: "TestS" )
                    //def.set(data.sagyoRireki, forKey: "TestS1")
                    
                    //データセーブ部分
                    UserDefaults.standard.set(data.sagyo, forKey: "SAGYO")
                    UserDefaults.standard.set(data.sagyoRireki, forKey: "SAGYORIREKI")
                }) {
                    Text("作業内容を登録する")
                }
            }
        }
    }
}

struct SagyoView_Previews: PreviewProvider {
    static var previews: some View {
        SagyoView(data: MyData())
    }
}
