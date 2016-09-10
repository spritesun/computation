// Big step semantic in swift

// This time I want to try class instead of struct, to feel the difference in this case

extension Number {
	func evaluate(environment: [String: Expression]) -> Expression {
		return self
	}
}

extension Boolean {
	func evaluate(environment: [String: Expression]) -> Expression {
		return self
	}
}

extension Variable {
	func evaluate(environment: [String: Expression]) -> Expression {
		return environment[name]!
	}
}