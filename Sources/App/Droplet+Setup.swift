@_exported import Vapor

extension Droplet {
    public func setup() throws {
        let routes = Routes(self)
        try collection(routes)
    }
}
