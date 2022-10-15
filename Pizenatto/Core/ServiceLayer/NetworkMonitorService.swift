//
//  NetworkMonitorService.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 15.10.2022.
//

import Network

// MARK: - NetworkMonitorService
final class NetworkMonitorService {

    static let shared = NetworkMonitorService()

    private(set) var isConnected: Bool = false

    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor

    private init() {
        monitor = NWPathMonitor()
    }

    func startMonitoring(_ completion: @escaping () -> Void) {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            if path.status == .unsatisfied {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
