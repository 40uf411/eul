//
//  NetworkView.swift
//  eul
//
//  Created by Gao Sun on 2020/8/15.
//  Copyright © 2020 Gao Sun. All rights reserved.
//

import SwiftUI

struct NetworkView: SizeChangeView {
    var onSizeChange: ((CGSize) -> Void)?
    @ObservedObject var networkStore = NetworkStore.shared

    var body: some View {
        HStack(spacing: 6) {
            Image("Network")
                .resizable()
                .frame(width: 15, height: 15)
            VStack(alignment: .leading, spacing: 0) {
                Text(networkStore.inSpeed)
                    .compact()
                Text(networkStore.outSpeed)
                    .compact()
            }
        }
        .fixedSize()
        .background(GeometryReader { self.reportSize($0) })
    }
}

