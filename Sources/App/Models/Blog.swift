import Vapor
import FluentProvider
import HTTP

final class Blog: Model, Timestampable {
    let storage = Storage()
    
    var title: String
    var body: String
    
    static let idKey = "id"
    static let titleKey = "title"
    static let bodyKey = "body"

    init(title: String, body: String) {
        self.body = body
        self.title = title
    }


    // Node作成
    func makeNode(in context: Context?) throws -> Node {
        var node = Node([:])
        try node.set(Blog.idKey, id)
        try node.set(Blog.titleKey, title)
        try node.set(Blog.bodyKey, body)
        try node.set(Blog.updatedAtKey, updatedAt)
        try node.set(Blog.createdAtKey, createdAt)
        return node
    }

    // ストレージ(Row)からのBlogモデルの作成
    init(row: Row) throws {
        body = try row.get(Blog.bodyKey)
        title = try row.get(Blog.titleKey)
    }

    // ストレージ(Row)に格納し返却
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(Blog.bodyKey, body)
        try row.set(Blog.titleKey, title)
        return row
    }

}

extension Blog : Preparation {

  // システム起動時にテーブルが存在しない場合作成する。
  static func prepare(_ database: Database) throws {
    try database.create(self) { builder in
      builder.id()
      builder.string(Blog.titleKey)
      builder.string(Blog.bodyKey)
    }
  }

  // テーブルを一旦削除する時に実行される
  static func revert(_ database: Database) throws {
    try database.delete(self)
  }
}

extension Blog: Updateable {
    public static var updateableKeys: [UpdateableKey<Blog>] {
        return [
            UpdateableKey(Blog.bodyKey, String.self) { blog, body in
                blog.body = body
            },
            UpdateableKey(Blog.titleKey, String.self) { blog, title in
                blog.title = title 
            }
        ]
    }
}
