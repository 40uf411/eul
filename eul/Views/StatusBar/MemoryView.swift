//
//  MemoryView.swift
//  eul
//
//  Created by Gao Sun on 2020/6/29.
//  Copyright © 2020 Gao Sun. All rights reserved.
//

import SwiftUI

struct MemoryView: SizeChangeView {
    var onSizeChange: ((CGSize) -> Void)?
    @ObservedObject var memoryStore = MemoryStore.shared

    var texts: [String] {
        [memoryStore.freeString, memoryStore.usedString]
    }

    var body: some View {
        HStack(spacing: 6) {
            Image("Memory")
                .resizable()
                .frame(width: 15, height: 15)
            StatusBarTextView(texts: texts)
        }
        .fixedSize()
        .background(GeometryReader { self.reportSize($0) })
    }
}
