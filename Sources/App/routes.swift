import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Add basic healthcheck
    router.get("healthcheck") { req -> HealthCheckResponse in

        let serviceTests = HealthCheckServices(name: "PostgreSQL", status: "Operational");
        let healthCheck: HealthCheckResponse! = HealthCheckResponse(generated_at: Date()
            , tests: [serviceTests])
        return healthCheck
    }
    
    router.get("healthcheck", "ping") { req in
        return "pong";
    }

    
    // Example of configuring a controller
    let todoController = TodoController();
    router.get("todos", use: todoController.index);
    router.post("todos", use: todoController.create);
    router.delete("todos", Todo.parameter, use: todoController.delete);
}

struct HealthCheckResponse: Content {
    var generated_at: Date = Date();
    var tests: Array<HealthCheckServices>;
}

struct HealthCheckServices: Content {
    var name: String;
    var status: String;
}
