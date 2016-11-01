# LoggerAPI

Based on [IBM-Swift/LoggerAPI](https://github.com/IBM-Swift/LoggerAPI).

A logger protocol that can be implemented by various Logger implementations.
Additionally, a class with a set of static methods for logging to the active
implemention.

The following implementations are provided with the module:
  * `TTYLogger` - a logger that logs to stdout, with optional colored messages
  * `SystemLogger` - a logger that logs to the system log facility, dependent
    upon the OS: On Linux, it uses `syslog`, and on Darwin it uses the
    [unified logger interface](https://developer.apple.com/reference/os/1891852-logging?language=objc)
    if available, otherwise it falls back to
    [ASL](https://developer.apple.com/legacy/library/documentation/Darwin/Reference/ManPages/man3/asl.3.html).
