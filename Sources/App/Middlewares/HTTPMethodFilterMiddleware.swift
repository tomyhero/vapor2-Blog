import Vapor

// https://docs.vapor.codes/2.0/http/middleware/
// https://github.com/vapor/vapor/issues/472 create own middlware which this owner suggest

final class HTTPMethodFilterMiddleware: Middleware {

  func respond(to request: Request, chainingTo next: Responder) throws -> Response {

    if ( request.method == .post ) {
        if let method = request.data["_METHOD"]?.string {

          if method.uppercased() == "PATCH" {
            request.method = .patch
          } else if method.uppercased() == "DELETE" {
            request.method = .delete
          } else if method.uppercased() == "PUT" {
            request.method = .put
          }
        }
    }

    let response = try next.respond(to: request)

    return response
  }

}
