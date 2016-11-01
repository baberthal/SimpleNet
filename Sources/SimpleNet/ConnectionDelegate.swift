//
//  ConnectionDelegate.swift
//  SimpleNet
//
//  Created by Morgan Lieberthal on 11/1/16.
//
//

import struct Foundation.Data
import struct Dispatch.DispatchData

/// The `ConnectionDelegate` protocol describes an interface that should be
/// implemented by the delegate for an instance of the `Connection` class.
public protocol ConnectionDelegate {
  /// Sent when the connection fails to load a request successfully.
  ///
  /// This method is optional, and the provided default implementation is a no-op.
  ///
  /// - parameter connection: The connection sending the message.
  /// - parameter error: An error object containing details of why the connection failed.
  func connection(_ connection: Connection, didFailWithError: Swift.Error)

  /// Sent as a connection loads data incrementally.
  ///
  /// This method is optional, and the provided default implementation is a no-op.
  ///
  /// - parameter connection: The connection sending the message.
  /// - parameter data: The newly available data. The delegate should concatenate the contents
  ///             of each `data` object delivered to build up the complete data for the
  ///             request.
  func connection(_ connection: Connection, didReceive data: Data)

  /// Convenience method for receiving a `DispatchData` structure.
  ///
  /// This method is optional, and the provided default implementation is a no-op.
  ///
  /// - parameter connection: The connection sending the message.
  /// - parameter data: The newly available `DispatchData` structure.
  func connection(_ connection: Connection, didReceive data: DispatchData)
}

/// Default implementations
extension ConnectionDelegate {
  /// Empty
  public func connection(_ connection: Connection, didFailWithError: Swift.Error) {
  }

  /// Empty
  public func connection(_ connection: Connection, didReceive data: Data) {
  }

  /// The default implementaion simply converts the `DispatchData` struct to a `Data` struct,
  /// and calls `connection(_:didReceive:)` with the resulting `Data` struct.
  ///
  /// - parameter connection: The connection sending the message.
  /// - parameter data: The newly available `DispatchData` structure.
  func connection(_ connection: Connection, didReceive data: DispatchData) {
    let someData: Data = data.withUnsafeBytes(body: { (bytePointer: UnsafePointer<UInt8>) in
      return Data(bytes: bytePointer, count: data.count)
    })

    self.connection(connection, didReceive: someData)
  }
}
