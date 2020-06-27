//
//  StatusBarView.swift
//  eul
//
//  Created by Gao Sun on 2020/6/27.
//  Copyright © 2020 Gao Sun. All rights reserved.
//

import SwiftUI

struct StatusBarView: View {
    static var height: CGFloat {
        NSStatusBar.system.thickness
    }
    var body: some View {
        CpuView()
            .environmentObject(CpuStore.shared)
    }
}
