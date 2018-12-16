//
//  GCDBlackBox.swift
//  VirtualTourist
//
//  Created by Sam Townsend on 2018-12-16.
//  Copyright © 2018 Sam Townsend. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
