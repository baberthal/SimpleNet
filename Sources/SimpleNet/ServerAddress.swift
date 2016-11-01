//
//  ServerAddress.swift
//  SimpleNet
//
//  Created by Morgan Lieberthal on 11/1/16.
//
//

public struct ServerAddress {
  /// The hostname of the address
  public var hostname: String

  /// The port of the address
  public var port: Int

  /// Create a default instance of `ServerAddress`
  public init(hostname: String, port: Int) {
    self.hostname = hostname
    self.port     = port
  }

  /// Create an instance of `ServerAddress`
  public init(_ tuple: (String, Int)) {
    self.init(hostname: tuple.0, port: tuple.1)
  }
}
