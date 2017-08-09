import Vapor
import HTTP

final class BlogController: ResourceRepresentable {

    let drop: Droplet 
    init(_ drop: Droplet) {
        self.drop = drop
    }

    func makeResource() -> Resource<Blog> {
        return Resource(
            index: index,
            create:create,
            store: store,
            show: show,
            edit: edit,
            update: update,
            destroy: delete
        )
    }

    /// DELETE /:id
    func delete( req: Request, blog: Blog) throws -> ResponseRepresentable {
      try blog.delete()
      return Response(redirect: "/")
    }

    // GET /:id/edit
    func edit (req: Request,blog: Blog) throws -> ResponseRepresentable {
      drop.log.info("edit called")

      return try drop.view.make("blog/edit.leaf", ["blog": blog.makeNode(in:nil)])
    }

    // PATCH /:id/
    func update (req: Request,blog: Blog) throws -> ResponseRepresentable {
      drop.log.info("update called")

      try blog.update(for: req)
      try blog.save()

      return Response(redirect: "/")
    }


    // GET /:id
    func show(request: Request, blog: Blog) throws -> ResponseRepresentable {
      drop.log.info("show called")
      return try drop.view.make("blog/show.leaf",[ "blog": blog.makeNode(in:nil)])
    }

    // GET /create
    func create(_ req: Request) throws -> ResponseRepresentable {
      drop.log.info("create called")
      return try drop.view.make("blog/create.leaf")
    }

    // POST /
    func store(_ req: Request) throws -> ResponseRepresentable {
      drop.log.info("store called")

      guard let title = req.data["title"]?.string else { 
        drop.log.info("missing title")
        throw Abort(.badRequest)
      }
      guard let body = req.data["body"]?.string else { 
        drop.log.info("missing body")
        throw Abort(.badRequest)
      }

      let blog = Blog(title: title, body: body)
      try blog.save();

      return Response(redirect: "/")
    }

    // GET /
    func index(_ req: Request) throws -> ResponseRepresentable {
      drop.log.info("index called")

      var blogNodes = [Node]()
      for blog in try Blog.all() {
        blogNodes.append(try blog.makeNode(in:nil))
      }

      return try drop.view.make("blog/index.leaf",[ "blogs": blogNodes] )
    }


}
