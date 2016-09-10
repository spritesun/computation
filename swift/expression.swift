protocol Expression : CustomStringConvertible {
    var isReducible: Bool { get }
    func reduce(environment: [String: Expression]) -> Expression
	func evaluate(environment: [String: Expression]) -> Expression	
}

extension Expression {
	func reduce(environment: [String: Expression]) -> Expression {
		fatalError("Unimplemented reduce been called")
	}
}