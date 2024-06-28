import ballerina/http;
import ballerina/io;

type Greeting record {
    string 'from;
    string to;
    string message;
};

service / on new http:Listener(8090) {
    resource function get .(string name) returns Greeting {
        Greeting greetingMessage = {"from" : "Choreo", "to" : name, "message" : "Welcome to Choreo!"};
        return greetingMessage;
    }

    resource function get bee() returns json|error {
        http:Client beeClient = check new ("https://mytestbee.free.beeceptor.com");
        json|error resp = beeClient->get("/bee");
        if resp is error {
            io:println(resp.message());
            return error("ERROR");
        } else {
            io:println(resp.toString());
            return resp.toJson();
        }
    }
}
