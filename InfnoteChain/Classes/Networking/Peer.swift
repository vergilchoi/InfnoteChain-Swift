//
//  Peer.swift
//  InfnoteChain
//
//  Created by Vergil Choi on 2018/10/4.
//

import Foundation
import RealmSwift
import Starscream


public class Peer: Object {
    
    @objc open dynamic var address: String = ""
    @objc open dynamic var port: Int = 80
    @objc open dynamic var rank: Int = 100
    
    var socket: WebSocket! = nil
    
    public override static func primaryKey() -> String? {
        return "address"
    }
    
    public convenience init?(address: String, port: Int = 80) {
        self.init()
        self.address = address
        self.port = port
        if !createSocket() {
            return nil
        }
    }
    
    public func createSocket() -> Bool {
        guard let url = URL(string: "ws://\(address):\(port)") else {
            return false
        }
        socket = WebSocket(url: url)
        return true
    }
}

public class PeerManager {
    
    public static var shared = PeerManager()
    
    public var allPeers: Results<Peer> {
        return database.objects(Peer.self).sorted(byKeyPath: "rank", ascending: false)
    }
    
    let database = try! Realm()
    
    private init() {}
    
    public func addOrUpdate(peer: Peer) {
        try! database.write {
            database.add(peer, update: true)
        }
    }
}