//
//  StatusBarTextView.swift
//  eul
//
//  Created by Gao Sun on 2020/9/12.
//  Copyright © 2020 Gao Sun. All rights reserved.
//

import SwiftUI

struct StatusBarTextView: View {
    @ObservedObject var preferenceStore = PreferenceStore.shared
    var texts: [String] = []

    func getCompactRow(_ index: Int) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(self.texts[index * 2])
                .compact()
            Text(self.texts[index * 2 + 1])
                .compact()
        }
    }

    var body: some View {
        HStack {
            if preferenceStore.textDisplay == .singleLine {
                ForEach(0..<texts.count, id: \.self) {
                    Text(self.texts[$0])
                        .normal()
                }
            }

            if preferenceStore.textDisplay == .compact {
                ForEach(0..<(texts.count / 2), id: \.self) {
                    self.getCompactRow($0)
                }
                if texts.count % 2 == 1 {
                    Text(texts[texts.count - 1])
                        .normal()
                }
            }
        }
    }
}
