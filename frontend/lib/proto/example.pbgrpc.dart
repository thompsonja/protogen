///
//  Generated code. Do not modify.
//  source: example.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'example.pb.dart' as $0;
export 'example.pb.dart';

class ExampleClient extends $grpc.Client {
  static final _$someFunc = $grpc.ClientMethod<$0.SomeRequest, $0.SomeReply>(
      '/example.Example/SomeFunc',
      ($0.SomeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SomeReply.fromBuffer(value));

  ExampleClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.SomeReply> someFunc($0.SomeRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$someFunc, request, options: options);
  }
}

abstract class ExampleServiceBase extends $grpc.Service {
  $core.String get $name => 'example.Example';

  ExampleServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.SomeRequest, $0.SomeReply>(
        'SomeFunc',
        someFunc_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SomeRequest.fromBuffer(value),
        ($0.SomeReply value) => value.writeToBuffer()));
  }

  $async.Future<$0.SomeReply> someFunc_Pre(
      $grpc.ServiceCall call, $async.Future<$0.SomeRequest> request) async {
    return someFunc(call, await request);
  }

  $async.Future<$0.SomeReply> someFunc(
      $grpc.ServiceCall call, $0.SomeRequest request);
}
