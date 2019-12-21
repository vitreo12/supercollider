TestUnitTest : UnitTest {

	var someVar;

	setUp {
		someVar = \setUp;
	}

	test_setUp {
		this.assertEquals(someVar, \setUp, "someVar be set in setUp");
	}

	test_bootServer {
		var server = Server(this.class.name);
		server.bootSync;
		this.assert(server.serverRunning, "The test's Server should be booted while we waited");
		server.quit.remove;
	}

	test_assert {
		this.assert(true, "assert(true) should certainly work");
	}

	test_findTestedClass {
		this.assertEquals(TestMixedBundleTester.findTestedClass, MixedBundleTester)
	}

	test_assertException_implicitThrow {
		this.assertException({ 1789.monarchy }, DoesNotUnderstandError, "assertException should return true for any error")
	}

	test_assertException_explicitThrow {
		this.assertException({ BinaryOpFailureError("I prefer ternary").throw },
			BinaryOpFailureError,
			"assertException should return true for specific error",
		)
	}

	test_assertNoException_nonExceptionThrow {
		this.assertNoException({ \stone.throw }, "assertException should return false for thrown object")
	}

	test_assertNoException_nonThrowingFunction {
		this.assertNoException({ try { 1789.monarchy } }, "assertNoThrow should return true for not an error")
	}

	test_wait {
		var condition = Condition.new;
		var r = Routine {
			0.01.yield;
			condition.test = true;
		};
		r.play;
		this.wait(condition, maxTime:0.02);
		this.assert(condition.test, "UnitTest.wait should continue when test is true");
	}

	/*** IF YOU ADD MORE TESTS, UPDATE THE numTestMethods var ***/
	// test_findTestMethods {
	// 	var numTestMethods = 7;
	// 	this.assert( this.findTestMethods.size == numTestMethods, "should be " + numTestMethods + " test methods");
	// }


}
