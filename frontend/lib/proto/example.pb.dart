///
//  Generated code. Do not modify.
//  source: example.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $1;

class SomeRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SomeRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'example'), createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'someTime', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  SomeRequest._() : super();
  factory SomeRequest({
    $1.Timestamp? someTime,
  }) {
    final _result = create();
    if (someTime != null) {
      _result.someTime = someTime;
    }
    return _result;
  }
  factory SomeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SomeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SomeRequest clone() => SomeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SomeRequest copyWith(void Function(SomeRequest) updates) => super.copyWith((message) => updates(message as SomeRequest)) as SomeRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SomeRequest create() => SomeRequest._();
  SomeRequest createEmptyInstance() => create();
  static $pb.PbList<SomeRequest> createRepeated() => $pb.PbList<SomeRequest>();
  @$core.pragma('dart2js:noInline')
  static SomeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SomeRequest>(create);
  static SomeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get someTime => $_getN(0);
  @$pb.TagNumber(1)
  set someTime($1.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSomeTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearSomeTime() => clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureSomeTime() => $_ensure(0);
}

class SomeReply extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SomeReply', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'example'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'response')
    ..hasRequiredFields = false
  ;

  SomeReply._() : super();
  factory SomeReply({
    $core.String? response,
  }) {
    final _result = create();
    if (response != null) {
      _result.response = response;
    }
    return _result;
  }
  factory SomeReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SomeReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SomeReply clone() => SomeReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SomeReply copyWith(void Function(SomeReply) updates) => super.copyWith((message) => updates(message as SomeReply)) as SomeReply; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SomeReply create() => SomeReply._();
  SomeReply createEmptyInstance() => create();
  static $pb.PbList<SomeReply> createRepeated() => $pb.PbList<SomeReply>();
  @$core.pragma('dart2js:noInline')
  static SomeReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SomeReply>(create);
  static SomeReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get response => $_getSZ(0);
  @$pb.TagNumber(1)
  set response($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasResponse() => $_has(0);
  @$pb.TagNumber(1)
  void clearResponse() => clearField(1);
}

