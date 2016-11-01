//
//  Thread.swift
//  SimpleNet
//
//  Created by Morgan Lieberthal on 11/1/16.
//
//

import Foundation

/// This class bridges the gap between OSX and Linux Foundation Threading API.
/// It provides closure based execution and a join method to block the calling
/// thread until the thread is finished executing.
///
/// This class is based on the class of the same name from the 
/// swift-package-manager project.
public final class Thread {
  /// The thread implementation -- Foundation.Thread on Linux and a custom
  /// subclass of Foundation.Thread on macOS to provide closure support.
  private var thread: ThreadImpl!

  /// Condition variable to support blocking other threads using `join()`
  /// when this thread has not yet finished execution.
  private var finishedCondition: Condition

  /// A boolean to track whether or not this thread has finised execution.
  private var finished: Bool

  /// Create an instance of `Thread` with a closure to be executed when 
  /// `start()` is called.
  public init(task: @escaping () -> Void) {
    self.finished = false
    self.finishedCondition = Condition()

    // Wrap the task with condition notifying any other threads blocked due to
    // this thread.  Capture self weakly to avoid reference cycle.  In case
    // `Thread` is `deinit`ed before the task runs, skip the use of
    // finishedCondition.
    let theTask = { [weak self] in
      if let strongSelf = self {
        precondition(!strongSelf.finished)
        strongSelf.finishedCondition.whileLocked {
          task()
          strongSelf.finished = true
          strongSelf.finishedCondition.broadcast()
        }
      } else {
        // If the containing thread has been destroyed, we can safely ignore
        // `finishedCondition` and just run the task.
        task()
      }
    }

    self.thread = ThreadImpl(block: theTask)
  }

  /// Starts the execution of the thread.
  public func start() {
    self.thread.start()
  }

  /// Blocks the calling thread until this thread finishes execution.
  public func join() {
    finishedCondition.whileLocked {
      while !finished {
        finishedCondition.wait()
      }
    }
  }
}

#if os(macOS)
private final class ThreadImpl: Foundation.Thread {
  /// The task to be executed
  private let task: () -> Void

  override func main() {
    task()
  }

  init(block task: @escaping () -> Void) {
    self.task = task
  }
}
#else
private typealias ThreadImpl = Foundation.Thread
#endif
