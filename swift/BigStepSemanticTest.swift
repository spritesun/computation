func BigStepSemanticTest() {
	print(">> BigStepSemanticTest")
	var statement : Statement
	var env : [String: Expression]

	statement = While(LessThan(Variable("x"), Number(5)), Assign("x", Multiply(Variable("x"), Number(3))))
	env = ["x": Number(1)]
	
	print(statement.evaluate(env))
}

