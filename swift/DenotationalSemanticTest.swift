func DenotationalSemanticTest() {
	print(">> DenotationalSemanticTest")
	var statement : Statement

	print("To evaluate following swift statement, you need to manually declare variables in prior.")
	
	statement = Sequence(Assign("x", Number(3)),If(Boolean(false), DoNothing(), Assign("x", Number(50))))
	print(statement.toSwift())	
	
	statement = While(LessThan(Variable("x"), Number(5)), Assign("x", Add(Number(1), Multiply(Variable("x"), Number(3)))))	
	print(statement.toSwift())	
}