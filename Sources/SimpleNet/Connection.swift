//
//  Connection.swift
//  VimChannelKit
//
//  Created by Morgan Lieberthal on 10/31/16.
//
//

import Dispatch
import Socket

// MARK: - Connection

/// The `Connection` class provides an abstraction around a connected socket.
open class Connection {
  /// Tracks the connection number (for DispatchQueue labels)
  private static var connectionNumber = 0

  // MARK: - Properties

  // MARK: Public

  /// The delegate of the server that is serving this connection
  public weak var delegate: ServerDelegate?

  /// The socket this connection takes place over
  public internal(set) var socket: Socket

  /// The IP:Port pair of the remote address (other side of the connection)
  public var remoteAddress: String {
    return "\(socket.remoteHostname):\(socket.remotePort)"
  }

  // MARK: Internal

  /// The socket's file descriptor
  var socketfd: Int32 {
    return socket.socketfd
  }

  /// Dispatch queue for reading from the socket
  let readQueue: DispatchQueue

  /// Dispatch queue for writing to the socket
  let writeQueue: DispatchQueue

  // MARK: - Initializers

  /// Create a Connection, over a given socket
  init(socket: Socket, using delegate: ServerDelegate? = nil) {
    self.socket   = socket
    self.delegate = delegate

    self.readQueue  = createQueue(forSocket: socket, type: .read)
    self.writeQueue = createQueue(forSocket: socket, type: .write)
  }

  // MARK: - Public Methods 
  
  /// If there is data waiting to be written, set a flag and the socket will
  /// be closed when all the buffered data has been written.
  /// Otherwise, immediately close the socket.
  public func prepareToClose() {
  }
}

// MARK: - Fileprivate Implementation Helpers

/// For `createQueue(forSocket:type:)`
fileprivate enum QueueType: String {
  case read, write
}

/// Create a `DispatchQueue` for a given Socket
fileprivate func createQueue(forSocket socket: Socket, type: QueueType) -> DispatchQueue {
  let label = "simple-net.connection.sockfd=\(socket.socketfd).\(type)"
  return DispatchQueue(label: label)
}
