//
//  MenuItemView.swift
//  eul
//
//  Created by Gao Sun on 2020/6/26.
//  Copyright © 2020 Gao Sun. All rights reserved.
//

import SwiftUI

enum MenuItem: String, CaseIterable, Identifiable {
    var id: String {
        rawValue
    }

    case General
    case CPU
    case Battery
    case Network
    case Disk
}

struct MenuItemView: View {
    var item: MenuItem
    var active = false

    var body: some View {
        HStack {
            Text(item.rawValue)
                .font(.body)
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 20)
        .background(active ? Color.selectedBackground : Color.clear)
        .padding(.vertical, 2)
        .contentShape(Rectangle())
    }
}
