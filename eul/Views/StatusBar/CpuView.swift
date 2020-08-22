//
//  CpuView.swift
//  eul
//
//  Created by Gao Sun on 2020/6/27.
//  Copyright © 2020 Gao Sun. All rights reserved.
//

import SwiftUI

struct CpuView: SizeChangeView {
    var onSizeChange: ((CGSize) -> Void)?
    @ObservedObject var cpuStore = CpuStore.shared

    var body: some View {
        HStack(spacing: 6) {
            Image("CPU")
                .resizable()
                .frame(width: 15, height: 15)
            VStack(alignment: .leading, spacing: 0) {
                Text(cpuStore.temp)
                    .compact()
                Text(cpuStore.usage)
                    .compact()
            }
        }
        .fixedSize()
        .background(GeometryReader { self.reportSize($0) })
    }
}
