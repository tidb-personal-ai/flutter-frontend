// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_state_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AudioMessage {
  Uint8List get data => throw _privateConstructorUsedError;
  String get mimeType => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AudioMessageCopyWith<AudioMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioMessageCopyWith<$Res> {
  factory $AudioMessageCopyWith(
          AudioMessage value, $Res Function(AudioMessage) then) =
      _$AudioMessageCopyWithImpl<$Res, AudioMessage>;
  @useResult
  $Res call({Uint8List data, String mimeType});
}

/// @nodoc
class _$AudioMessageCopyWithImpl<$Res, $Val extends AudioMessage>
    implements $AudioMessageCopyWith<$Res> {
  _$AudioMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? mimeType = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AudioMessageCopyWith<$Res>
    implements $AudioMessageCopyWith<$Res> {
  factory _$$_AudioMessageCopyWith(
          _$_AudioMessage value, $Res Function(_$_AudioMessage) then) =
      __$$_AudioMessageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Uint8List data, String mimeType});
}

/// @nodoc
class __$$_AudioMessageCopyWithImpl<$Res>
    extends _$AudioMessageCopyWithImpl<$Res, _$_AudioMessage>
    implements _$$_AudioMessageCopyWith<$Res> {
  __$$_AudioMessageCopyWithImpl(
      _$_AudioMessage _value, $Res Function(_$_AudioMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? mimeType = null,
  }) {
    return _then(_$_AudioMessage(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AudioMessage with DiagnosticableTreeMixin implements _AudioMessage {
  _$_AudioMessage({required this.data, required this.mimeType});

  @override
  final Uint8List data;
  @override
  final String mimeType;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AudioMessage(data: $data, mimeType: $mimeType)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AudioMessage'))
      ..add(DiagnosticsProperty('data', data))
      ..add(DiagnosticsProperty('mimeType', mimeType));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AudioMessage &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(data), mimeType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AudioMessageCopyWith<_$_AudioMessage> get copyWith =>
      __$$_AudioMessageCopyWithImpl<_$_AudioMessage>(this, _$identity);
}

abstract class _AudioMessage implements AudioMessage {
  factory _AudioMessage(
      {required final Uint8List data,
      required final String mimeType}) = _$_AudioMessage;

  @override
  Uint8List get data;
  @override
  String get mimeType;
  @override
  @JsonKey(ignore: true)
  _$$_AudioMessageCopyWith<_$_AudioMessage> get copyWith =>
      throw _privateConstructorUsedError;
}
