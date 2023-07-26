// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AudioController {
  FlutterSoundRecorder get recorder => throw _privateConstructorUsedError;
  FlutterSoundPlayer get player => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AudioControllerCopyWith<AudioController> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioControllerCopyWith<$Res> {
  factory $AudioControllerCopyWith(
          AudioController value, $Res Function(AudioController) then) =
      _$AudioControllerCopyWithImpl<$Res, AudioController>;
  @useResult
  $Res call({FlutterSoundRecorder recorder, FlutterSoundPlayer player});
}

/// @nodoc
class _$AudioControllerCopyWithImpl<$Res, $Val extends AudioController>
    implements $AudioControllerCopyWith<$Res> {
  _$AudioControllerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recorder = null,
    Object? player = null,
  }) {
    return _then(_value.copyWith(
      recorder: null == recorder
          ? _value.recorder
          : recorder // ignore: cast_nullable_to_non_nullable
              as FlutterSoundRecorder,
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as FlutterSoundPlayer,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AudioControllerCopyWith<$Res>
    implements $AudioControllerCopyWith<$Res> {
  factory _$$_AudioControllerCopyWith(
          _$_AudioController value, $Res Function(_$_AudioController) then) =
      __$$_AudioControllerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FlutterSoundRecorder recorder, FlutterSoundPlayer player});
}

/// @nodoc
class __$$_AudioControllerCopyWithImpl<$Res>
    extends _$AudioControllerCopyWithImpl<$Res, _$_AudioController>
    implements _$$_AudioControllerCopyWith<$Res> {
  __$$_AudioControllerCopyWithImpl(
      _$_AudioController _value, $Res Function(_$_AudioController) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recorder = null,
    Object? player = null,
  }) {
    return _then(_$_AudioController(
      recorder: null == recorder
          ? _value.recorder
          : recorder // ignore: cast_nullable_to_non_nullable
              as FlutterSoundRecorder,
      player: null == player
          ? _value.player
          : player // ignore: cast_nullable_to_non_nullable
              as FlutterSoundPlayer,
    ));
  }
}

/// @nodoc

class _$_AudioController
    with DiagnosticableTreeMixin
    implements _AudioController {
  _$_AudioController({required this.recorder, required this.player});

  @override
  final FlutterSoundRecorder recorder;
  @override
  final FlutterSoundPlayer player;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AudioController(recorder: $recorder, player: $player)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AudioController'))
      ..add(DiagnosticsProperty('recorder', recorder))
      ..add(DiagnosticsProperty('player', player));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AudioController &&
            (identical(other.recorder, recorder) ||
                other.recorder == recorder) &&
            (identical(other.player, player) || other.player == player));
  }

  @override
  int get hashCode => Object.hash(runtimeType, recorder, player);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AudioControllerCopyWith<_$_AudioController> get copyWith =>
      __$$_AudioControllerCopyWithImpl<_$_AudioController>(this, _$identity);
}

abstract class _AudioController implements AudioController {
  factory _AudioController(
      {required final FlutterSoundRecorder recorder,
      required final FlutterSoundPlayer player}) = _$_AudioController;

  @override
  FlutterSoundRecorder get recorder;
  @override
  FlutterSoundPlayer get player;
  @override
  @JsonKey(ignore: true)
  _$$_AudioControllerCopyWith<_$_AudioController> get copyWith =>
      throw _privateConstructorUsedError;
}
