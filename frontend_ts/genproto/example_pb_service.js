// package: example
// file: example.proto

var example_pb = require("./example_pb");
var grpc = require("@improbable-eng/grpc-web").grpc;

var Example = (function () {
  function Example() {}
  Example.serviceName = "example.Example";
  return Example;
}());

Example.SomeFunc = {
  methodName: "SomeFunc",
  service: Example,
  requestStream: false,
  responseStream: false,
  requestType: example_pb.SomeRequest,
  responseType: example_pb.SomeReply
};

exports.Example = Example;

function ExampleClient(serviceHost, options) {
  this.serviceHost = serviceHost;
  this.options = options || {};
}

ExampleClient.prototype.someFunc = function someFunc(requestMessage, metadata, callback) {
  if (arguments.length === 2) {
    callback = arguments[1];
  }
  var client = grpc.unary(Example.SomeFunc, {
    request: requestMessage,
    host: this.serviceHost,
    metadata: metadata,
    transport: this.options.transport,
    debug: this.options.debug,
    onEnd: function (response) {
      if (callback) {
        if (response.status !== grpc.Code.OK) {
          var err = new Error(response.statusMessage);
          err.code = response.status;
          err.metadata = response.trailers;
          callback(err, null);
        } else {
          callback(null, response.message);
        }
      }
    }
  });
  return {
    cancel: function () {
      callback = null;
      client.close();
    }
  };
};

exports.ExampleClient = ExampleClient;

