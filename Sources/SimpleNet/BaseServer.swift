//
//  BaseServer.swift
//  SimpleNet
//
//  Created by Morgan Lieberthal on 11/1/16.
//
//

import Foundation

open class BaseServer {
  /// The address to bind the server to
  public let serverAddress: ServerAddress

  /// The ServerDelegate that will handle requests for this server
  public var delegate: ServerDelegate?

  /// Initialize a `BaseServer` to listen on a given address 
  public init(address: ServerAddress, delegate: ServerDelegate? = nil) {
    self.serverAddress = address
    self.delegate = delegate
  }

  /// Initialize a `BaseServer` to listen on a given address
  public init(address: (String, Int), delegate: ServerDelegate? = nil) {
    self.serverAddress = ServerAddress(address)
    self.delegate = delegate
  }
}
