protocol Statement : CustomStringConvertible {
    var isReducible: Bool { get }
	
	// reduce need to keep intermediate statement
    func reduce(_: [String: Expression]) -> (statement: Statement, env: [String: Expression])
	
	// evaluate do not keep intermediate statement, only return new environment
	func evaluate(environment: [String: Expression]) -> [String: Expression]
}

extension Statement {
    func reduce(env: [String: Expression]) -> (statement: Statement, env: [String: Expression]) {
        fatalError("Unimplemented reduce been called")
    }
	
	func evaluate(environment: [String: Expression]) -> [String: Expression] {
		fatalError("Unimplemented evaluate been called")
	}
}
