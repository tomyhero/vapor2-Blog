import XCTest
import Testing
import HTTP
import Sockets
@testable import Vapor
@testable import App

class BlogControllerTests: TestCase {

  func testIndex() throws {
    let drop :Droplet = try! Droplet.testable()
    let controller :BlogController = BlogController(drop)

    let req = Request.makeTest(method: .get)
    try controller.index(req).makeResponse()
    .assertBody(contains: "記事一覧") 
  }

  func testShow() throws {
    let drop :Droplet = try! Droplet.testable()
    let controller :BlogController = BlogController(drop)

    let req = Request.makeTest(method: .get)
    let blog = Blog(title: "タイトル", body: "body")
    try controller.show(request: req, blog: blog).makeResponse()
    .assertBody(contains: "タイトル") 
  }

  func testCreate() throws {
    let drop :Droplet = try! Droplet.testable()
    let controller :BlogController = BlogController(drop)

    let req = Request.makeTest(method: .get)
    try controller.create( req ).makeResponse()
    .assertBody(contains: "記事作成") 
  }

  func testEdit() throws {
    let drop :Droplet = try! Droplet.testable()
    let controller :BlogController = BlogController(drop)

    let req = Request.makeTest(method: .get)
    let blog = Blog(title: "タイトル", body: "body")
    try controller.edit( req: req , blog: blog).makeResponse()
    .assertBody(contains: "記事編集") 
  }

}

// MARK: Manifest

extension BlogControllerTests {
  static let allTests = [
    ("testIndex", testIndex),
    ("testShow", testShow)
  ]
}
