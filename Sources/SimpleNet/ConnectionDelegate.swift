//
//  ConnectionDelegate.swift
//  SimpleNet
//
//  Created by Morgan Lieberthal on 11/1/16.
//
//

import struct Foundation.Data

/// The `ConnectionDelegate` protocol describes an interface that should be
/// implemented by the delegate for an instance of the `Connection` class.
public protocol ConnectionDelegate {
  /// Sent when the connection fails to load a request successfully.
  ///
  /// This method is optional, and the provided default implementation is a no-op.
  ///
  /// - parameters:
  ///   - connection: The connection sending the message
  ///   - error: An error object containing details of why the connection failed
  func connection(_ connection: Connection, didFailWithError: Swift.Error)

  /// Sent as a connection loads data incrementally.
  ///
  /// This method is optional, and the provided default implementation is a no-op.
  ///
  /// - parameters:
  ///   - connection: The connection sending the message
  ///   - data: The newly available data. The delegate should concatenate the contents
  ///           of each `data` object delivered to build up the complete data for the 
  ///           request.
  func connection(_ connection: Connection, didReceive data: Data)
}

/// Default implementations
extension ConnectionDelegate {
  /// Empty
  func connection(_ connection: Connection, didFailWithError: Swift.Error) {
  }

  /// Empty
  func connection(_ connection: Connection, didReceive data: Data) {
  }
}
