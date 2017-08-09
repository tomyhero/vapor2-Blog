import LeafProvider
import FluentProvider

extension Config {
    public func setup() throws {
        // allow fuzzy conversions for these types
        // (add your own types here)
        Node.fuzzy = [JSON.self, Node.self]

        try setupProviders()
        try setupPreparations()
        try setupMiddlewares()
    }
    
    /// Configure providers
    private func setupProviders() throws {
        try addProvider(FluentProvider.Provider.self)
        try addProvider(LeafProvider.Provider.self)
    }

    private func setupPreparations() throws {
        preparations.append(Blog.self)
    }
    private func setupMiddlewares() throws {
      try addConfigurable(middleware: HTTPMethodFilterMiddleware(), name: "http_method_filter")
    }

}
