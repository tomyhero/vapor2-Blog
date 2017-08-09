import Vapor

final class Routes: RouteCollection {
    let drop: Droplet 
    init(_ drop: Droplet) {
        self.drop = drop
    }
    
    func build(_ builder: RouteBuilder) throws {
        builder.resource("", BlogController(drop))
        
    }
}
