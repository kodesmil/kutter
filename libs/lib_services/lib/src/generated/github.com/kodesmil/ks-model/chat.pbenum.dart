///
//  Generated code. Do not modify.
//  source: github.com/kodesmil/ks-model/chat.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class ChatMessage_Status extends $pb.ProtobufEnum {
  static const ChatMessage_Status DELIVERED = ChatMessage_Status._(0, 'DELIVERED');
  static const ChatMessage_Status NOT_DELIVERED = ChatMessage_Status._(1, 'NOT_DELIVERED');

  static const $core.List<ChatMessage_Status> values = <ChatMessage_Status> [
    DELIVERED,
    NOT_DELIVERED,
  ];

  static final $core.Map<$core.int, ChatMessage_Status> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ChatMessage_Status valueOf($core.int value) => _byValue[value];

  const ChatMessage_Status._($core.int v, $core.String n) : super(v, n);
}

