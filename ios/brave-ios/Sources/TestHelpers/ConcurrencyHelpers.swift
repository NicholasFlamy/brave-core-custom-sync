// Copyright 2023 The Brave Authors. All rights reserved.
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

import Foundation
import XCTest

// swift-format-ignore
public func XCTAssertAsyncThrowsError<T>(
  _ expression: @autoclosure () async throws -> T,
  _ message: @autoclosure () -> String = "",
  file: StaticString = #filePath,
  line: UInt = #line,
  _ errorHandler: (_ error: Error) -> Void = { _ in }
) async {
  do {
    _ = try await expression()
    XCTFail(message(), file: file, line: line)
  } catch {
    errorHandler(error)
  }
}

// swift-format-ignore
public func XCTAssertAsyncNoThrow<T>(
  _ expression: @autoclosure () async throws -> T,
  _ message: @autoclosure () -> String = "",
  file: StaticString = #filePath,
  line: UInt = #line
) async {
  do {
    _ = try await expression()
  } catch {
    XCTFail(message(), file: file, line: line)
  }
}

// swift-format-ignore
public func XCTunwrapAsync<T>(
  _ expression: @autoclosure @escaping () async throws -> T?,
  file: StaticString = #file,
  line: UInt = #line
) async throws -> T {
  let result = try await expression()
  return try XCTUnwrap(result, file: file, line: line)
}
