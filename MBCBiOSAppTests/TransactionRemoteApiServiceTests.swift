//
//  TransactionRemoteApiServiceTests.swift
//  MBCBiOSAppTests
//
//  Created by Dipankar Kumar Biswas
//  Email: dipankarbiswas@live.com
//

import XCTest
@testable import MBCBiOSApp

 
final class TransactionRemoteApiServiceTests: XCTestCase {
    
    func test_whenFetchTransactionsIsCalled_andServerReturnsValidData_shouldReturnListOfTransactions() async throws {
        let sut = TransactionRemoteApiService(httpClient: DataHTTPClientStub(jsonStr: responseJson))
        
        let transactions = try await sut.fetchTransactions()
        
        XCTAssertEqual(transactions.count, 20)
        XCTAssertEqual(transactions[0].amount, 1000)
    }
    
    func test_whenFetchTransactionsIsCalled_andServerReturnInvalidData_shouldThrowError() async {
        let sut = TransactionRemoteApiService(httpClient: DataHTTPClientStub(jsonStr: "this is a invalid reponse"))
        
        var trans: [Transaction]?
        var err: ApiServiceError?
        
        do {
            trans = try await sut.fetchTransactions()
        } catch {
            err = error as? ApiServiceError
        }
        
        XCTAssertNil(trans)
        XCTAssertNotNil(err)
        XCTAssertEqual(err, ApiServiceError.invalidData)
    }
    
    func test_whenFetchTransactionsIsCalled_andServerReturnsError_shouldThrowNetworkError() async {
        let sut = TransactionRemoteApiService(httpClient: ErrorHTTPClientStub())
        
        var trans: [Transaction]?
        var err: ApiServiceError?
        
        do {
            trans = try await sut.fetchTransactions()
        } catch {
            err = error as? ApiServiceError
        }
        
        XCTAssertNil(trans)
        XCTAssertNotNil(err)
        XCTAssertEqual(err, ApiServiceError.networkError)
    }
    
    func test_whenFetchTransactionsIsCalled_andServerReturnsInvalidStatusCode_shouldThrowNetworkError() async {
        let sut = TransactionRemoteApiService(httpClient: InvalidCodeHTTPClientStub())
        
        var trans: [Transaction]?
        var err: ApiServiceError?
        
        do {
            trans = try await sut.fetchTransactions()
        } catch {
            err = error as? ApiServiceError
        }
        
        XCTAssertNil(trans)
        XCTAssertNotNil(err)
        XCTAssertEqual(err, ApiServiceError.networkError)
    }
    
}



// MARK: - mocks and stubs

class DataHTTPClientStub: HTTPClientProtocol {
    let jsonStr: String
    
    init(jsonStr: String) {
        self.jsonStr = jsonStr
    }
    
    func sendGetHTTPRequest(url: URL, headers: [String : String]?, data: Data?) async throws -> (Int, Data) {
        return (200, jsonStr.data(using: .utf8)!)
    }
}



class ErrorHTTPClientStub: HTTPClientProtocol {
    struct FakeError: Error {}
    
    func sendGetHTTPRequest(url: URL, headers: [String : String]?, data: Data?) async throws -> (Int, Data) {
        throw FakeError()
    }
}


class InvalidCodeHTTPClientStub: HTTPClientProtocol {
    func sendGetHTTPRequest(url: URL, headers: [String : String]?, data: Data?) async throws -> (Int, Data) {
        return (500, Data())
    }
}



let responseJson = """
[{"id":1,"description":"transaction 1","amount":1000,"date":"2022-01-06T18:00:00.000Z"},{"id":2,"description":"transaction 2","amount":57,"date":"2022-01-15T18:00:00.000Z"},{"id":3,"description":"transaction 3","amount":214,"date":"2022-01-23T18:00:00.000Z"},{"id":4,"description":"transaction 4","amount":708,"date":"2022-01-30T18:00:00.000Z"},{"id":5,"description":"transaction 5","amount":823,"date":"2022-02-06T18:00:00.000Z"},{"id":6,"description":"transaction 6","amount":789,"date":"2022-02-15T18:00:00.000Z"},{"id":7,"description":"transaction 7","amount":275,"date":"2022-02-22T18:00:00.000Z"},{"id":8,"description":"transaction 8","amount":-116,"date":"2022-03-03T18:00:00.000Z"},{"id":9,"description":"transaction 9","amount":559,"date":"2022-03-09T18:00:00.000Z"},{"id":10,"description":"transaction 10","amount":674,"date":"2022-03-15T18:00:00.000Z"},{"id":11,"description":"transaction 11","amount":396,"date":"2022-03-21T18:00:00.000Z"},{"id":12,"description":"transaction 12","amount":784,"date":"2022-03-29T18:00:00.000Z"},{"id":13,"description":"transaction 13","amount":713,"date":"2022-04-03T18:00:00.000Z"},{"id":14,"description":"transaction 14","amount":325,"date":"2022-04-11T18:00:00.000Z"},{"id":15,"description":"transaction 15","amount":894,"date":"2022-04-19T18:00:00.000Z"},{"id":16,"description":"transaction 16","amount":-666,"date":"2022-04-25T18:00:00.000Z"},{"id":17,"description":"transaction 17","amount":795,"date":"2022-05-02T18:00:00.000Z"},{"id":18,"description":"transaction 18","amount":451,"date":"2022-05-11T18:00:00.000Z"},{"id":19,"description":"transaction 19","amount":835,"date":"2022-05-20T18:00:00.000Z"},{"id":20,"description":"transaction 20","amount":521,"date":"2022-05-26T18:00:00.000Z"}]
"""
