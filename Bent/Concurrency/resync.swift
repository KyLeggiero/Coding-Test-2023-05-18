//
//  resync.swift
//  Plural Diagramming
//
//  Created by The Ky Leggiero on 2023-01-17.
//

import Foundation

import OptionalTools
import SafePointer



/// Converts the given `async` function to a synchronous function.
///
/// This works by executing the given async function in the background, waiting for the result, then returning the result
///
/// - Parameters:
///   - timeout:      _optional_ - How long to wait for the async function to complete before giving up. `nil` signifies to wait forever. Defaults to `nil`
///   - asyncFunction: The function to convert into a synchronous one
public func resync<Value>(timeout: DispatchTime? = nil,
                          _ asyncFunction: @escaping () async throws -> Value)
throws -> Value {
    let semaphore = DispatchSemaphore.default
    
    let result = MutableSafePointer<Optional<Result<Value, Error>>>(to: .none)
    
    Task.detached(priority: .high) {
        defer {
            semaphore.signal()
        }
        
        do {
            result.pointee = .some(.success(try await asyncFunction()))
        }
        catch {
            result.pointee = .failure(error)
        }
    }
    
    if let timeout {
        let timeoutResult = semaphore.wait(timeout: timeout)
        
        switch timeoutResult {
        case .success:
            break
            
        case .timedOut:
            throw TaskNeverExecutedError()
        }
    }
    else {
        semaphore.wait()
    }
    
    return try result.pointee.unwrappedOrThrow(error: TaskNeverExecutedError()).get()
}



/// This error indicates that a task was started but never finished executing, or didn't finish on-time, or finished without running its closure
struct TaskNeverExecutedError: LocalizedError {
    var errorDescription: String? {
        "Attempted to run a background task, but the task didn't finish as expected"
    }
}
