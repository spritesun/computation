// Big step semantic in swift, recursive way

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

extension Add {
	func evaluate(environment: [String: Expression]) -> Expression {
		if let leftNumber = left.evaluate(environment) as? Number, rightNumber = right.evaluate(environment) as? Number {
			return Number(leftNumber.value + rightNumber.value)
		}
		fatalError("Add evaluate failed.")
	}
}

extension Multiply {
	func evaluate(environment: [String: Expression]) -> Expression {
		if let leftNumber = left.evaluate(environment) as? Number, rightNumber = right.evaluate(environment) as? Number {
			return Number(leftNumber.value * rightNumber.value)
		}
		fatalError("Add evaluate failed.")
	}
}

extension LessThan {
	func evaluate(environment: [String: Expression]) -> Expression {
		if let leftNumber = left.evaluate(environment) as? Number, rightNumber = right.evaluate(environment) as? Number {
			return Boolean(leftNumber.value < rightNumber.value)
		}
		print(left.evaluate(environment).evaluate(environment).dynamicType)
		fatalError("LessThan evaluate failed.")
	}
}