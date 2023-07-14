// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Ai _$AiFromJson(Map<String, dynamic> json) {
  return _Ai.fromJson(json);
}

/// @nodoc
mixin _$Ai {
  String get name => throw _privateConstructorUsedError;
  List<String> get traits => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AiCopyWith<Ai> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiCopyWith<$Res> {
  factory $AiCopyWith(Ai value, $Res Function(Ai) then) =
      _$AiCopyWithImpl<$Res, Ai>;
  @useResult
  $Res call({String name, List<String> traits});
}

/// @nodoc
class _$AiCopyWithImpl<$Res, $Val extends Ai> implements $AiCopyWith<$Res> {
  _$AiCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? traits = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      traits: null == traits
          ? _value.traits
          : traits // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AiCopyWith<$Res> implements $AiCopyWith<$Res> {
  factory _$$_AiCopyWith(_$_Ai value, $Res Function(_$_Ai) then) =
      __$$_AiCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<String> traits});
}

/// @nodoc
class __$$_AiCopyWithImpl<$Res> extends _$AiCopyWithImpl<$Res, _$_Ai>
    implements _$$_AiCopyWith<$Res> {
  __$$_AiCopyWithImpl(_$_Ai _value, $Res Function(_$_Ai) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? traits = null,
  }) {
    return _then(_$_Ai(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      traits: null == traits
          ? _value._traits
          : traits // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Ai implements _Ai {
  _$_Ai({required this.name, required final List<String> traits})
      : _traits = traits;

  factory _$_Ai.fromJson(Map<String, dynamic> json) => _$$_AiFromJson(json);

  @override
  final String name;
  final List<String> _traits;
  @override
  List<String> get traits {
    if (_traits is EqualUnmodifiableListView) return _traits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_traits);
  }

  @override
  String toString() {
    return 'Ai(name: $name, traits: $traits)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Ai &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._traits, _traits));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_traits));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AiCopyWith<_$_Ai> get copyWith =>
      __$$_AiCopyWithImpl<_$_Ai>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AiToJson(
      this,
    );
  }
}

abstract class _Ai implements Ai {
  factory _Ai(
      {required final String name, required final List<String> traits}) = _$_Ai;

  factory _Ai.fromJson(Map<String, dynamic> json) = _$_Ai.fromJson;

  @override
  String get name;
  @override
  List<String> get traits;
  @override
  @JsonKey(ignore: true)
  _$$_AiCopyWith<_$_Ai> get copyWith => throw _privateConstructorUsedError;
}
