// Big step semantic in swift, recursive way

// This time I want to try class instead of struct, to feel the difference in this case

// Expressions

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

// Statements

extension DoNothing {
	func evaluate(environment: [String: Expression]) -> [String: Expression] {	
		return environment
	}
}

extension Assign {
	func evaluate(environment: [String: Expression]) -> [String: Expression] {
		var new_env = environment
		new_env[name] = expression.evaluate(environment)
		return new_env
	}
}

extension If {
	func evaluate(environment: [String: Expression]) -> [String: Expression] {	
		if let conditionBool = condition.evaluate(environment) as? Boolean {
			if conditionBool.value {
				return consequence.evaluate(environment)
			} else {
				return alternative.evaluate(environment)
			}
		}
		fatalError("If evaluate failed.")
	}
}

extension Sequence {
	func evaluate(environment: [String: Expression]) -> [String: Expression] {
		return second.evaluate(first.evaluate(environment))
	}
}

extension While {
	func evaluate(environment: [String: Expression]) -> [String: Expression] {
		if let conditionBool = condition.evaluate(environment) as? Boolean {
			if conditionBool.value {
				// self recursive, big heap may occur
				return evaluate(body.evaluate(environment))
			} else {
				return environment
			}
		}
		fatalError("While evaluate failed.")
	}
}