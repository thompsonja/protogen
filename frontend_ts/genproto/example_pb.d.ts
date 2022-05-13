// package: example
// file: example.proto

import * as jspb from "google-protobuf";
import * as google_protobuf_timestamp_pb from "google-protobuf/google/protobuf/timestamp_pb";

export class SomeRequest extends jspb.Message {
  hasSomeTime(): boolean;
  clearSomeTime(): void;
  getSomeTime(): google_protobuf_timestamp_pb.Timestamp | undefined;
  setSomeTime(value?: google_protobuf_timestamp_pb.Timestamp): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): SomeRequest.AsObject;
  static toObject(includeInstance: boolean, msg: SomeRequest): SomeRequest.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: SomeRequest, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): SomeRequest;
  static deserializeBinaryFromReader(message: SomeRequest, reader: jspb.BinaryReader): SomeRequest;
}

export namespace SomeRequest {
  export type AsObject = {
    someTime?: google_protobuf_timestamp_pb.Timestamp.AsObject,
  }
}

export class SomeReply extends jspb.Message {
  getResponse(): string;
  setResponse(value: string): void;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): SomeReply.AsObject;
  static toObject(includeInstance: boolean, msg: SomeReply): SomeReply.AsObject;
  static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
  static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
  static serializeBinaryToWriter(message: SomeReply, writer: jspb.BinaryWriter): void;
  static deserializeBinary(bytes: Uint8Array): SomeReply;
  static deserializeBinaryFromReader(message: SomeReply, reader: jspb.BinaryReader): SomeReply;
}

export namespace SomeReply {
  export type AsObject = {
    response: string,
  }
}

