// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'athlete_management.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const AthleteManagementSchema = Schema(
  name: r'AthleteManagement',
  id: -5236115453613496698,
  properties: {
    r'athleteList': PropertySchema(
      id: 0,
      name: r'athleteList',
      type: IsarType.objectList,
      target: r'AthleteItem',
    ),
    r'chipsVerified': PropertySchema(
      id: 1,
      name: r'chipsVerified',
      type: IsarType.long,
    ),
    r'totalChipsToVerify': PropertySchema(
      id: 2,
      name: r'totalChipsToVerify',
      type: IsarType.long,
    ),
    r'totalChipsToVerifyReadOnly': PropertySchema(
      id: 3,
      name: r'totalChipsToVerifyReadOnly',
      type: IsarType.long,
    )
  },
  estimateSize: _athleteManagementEstimateSize,
  serialize: _athleteManagementSerialize,
  deserialize: _athleteManagementDeserialize,
  deserializeProp: _athleteManagementDeserializeProp,
);

int _athleteManagementEstimateSize(
  AthleteManagement object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.athleteList.length * 3;
  {
    final offsets = allOffsets[AthleteItem]!;
    for (var i = 0; i < object.athleteList.length; i++) {
      final value = object.athleteList[i];
      bytesCount += AthleteItemSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _athleteManagementSerialize(
  AthleteManagement object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<AthleteItem>(
    offsets[0],
    allOffsets,
    AthleteItemSchema.serialize,
    object.athleteList,
  );
  writer.writeLong(offsets[1], object.chipsVerified);
  writer.writeLong(offsets[2], object.totalChipsToVerify);
  writer.writeLong(offsets[3], object.totalChipsToVerifyReadOnly);
}

AthleteManagement _athleteManagementDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AthleteManagement(
    athleteList: reader.readObjectList<AthleteItem>(
          offsets[0],
          AthleteItemSchema.deserialize,
          allOffsets,
          AthleteItem(),
        ) ??
        const <AthleteItem>[],
    chipsVerified: reader.readLongOrNull(offsets[1]) ?? 0,
    totalChipsToVerify: reader.readLongOrNull(offsets[2]) ?? 0,
  );
  return object;
}

P _athleteManagementDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<AthleteItem>(
            offset,
            AthleteItemSchema.deserialize,
            allOffsets,
            AthleteItem(),
          ) ??
          const <AthleteItem>[]) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension AthleteManagementQueryFilter
    on QueryBuilder<AthleteManagement, AthleteManagement, QFilterCondition> {
  QueryBuilder<AthleteManagement, AthleteManagement, QAfterFilterCondition>
      athleteListLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'athleteList',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<AthleteManagement, AthleteManagement, QAfterFilterCondition>
      athleteListIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'athleteList',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<AthleteManagement, AthleteManagement, QAfterFilterCondition>
      athleteListIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'athleteList',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AthleteManagement, AthleteManagement, QAfterFilterCondition>
      athleteListLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'athleteList',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<AthleteManagement, AthleteManagement, QAfterFilterCondition>
      athleteListLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'athleteList',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<AthleteManagement, AthleteManagement, QAfterFilterCondition>
      athleteListLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'athleteList',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<AthleteManagement, AthleteManagement, QAfterFilterCondition>
      chipsVerifiedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chipsVerified',
        value: value,
      ));
    });
  }

  QueryBuilder<AthleteManagement, AthleteManagement, QAfterFilterCondition>
      chipsVerifiedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chipsVerified',
        value: value,
      ));
    });
  }

  QueryBuilder<AthleteManagement, AthleteManagement, QAfterFilterCondition>
      chipsVerifiedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chipsVerified',
        value: value,
      ));
    });
  }

  QueryBuilder<AthleteManagement, AthleteManagement, QAfterFilterCondition>
      chipsVerifiedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chipsVerified',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AthleteManagement, AthleteManagement, QAfterFilterCondition>
      totalChipsToVerifyEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalChipsToVerify',
        value: value,
      ));
    });
  }

  QueryBuilder<AthleteManagement, AthleteManagement, QAfterFilterCondition>
      totalChipsToVerifyGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalChipsToVerify',
        value: value,
      ));
    });
  }

  QueryBuilder<AthleteManagement, AthleteManagement, QAfterFilterCondition>
      totalChipsToVerifyLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalChipsToVerify',
        value: value,
      ));
    });
  }

  QueryBuilder<AthleteManagement, AthleteManagement, QAfterFilterCondition>
      totalChipsToVerifyBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalChipsToVerify',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AthleteManagement, AthleteManagement, QAfterFilterCondition>
      totalChipsToVerifyReadOnlyEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalChipsToVerifyReadOnly',
        value: value,
      ));
    });
  }

  QueryBuilder<AthleteManagement, AthleteManagement, QAfterFilterCondition>
      totalChipsToVerifyReadOnlyGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalChipsToVerifyReadOnly',
        value: value,
      ));
    });
  }

  QueryBuilder<AthleteManagement, AthleteManagement, QAfterFilterCondition>
      totalChipsToVerifyReadOnlyLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalChipsToVerifyReadOnly',
        value: value,
      ));
    });
  }

  QueryBuilder<AthleteManagement, AthleteManagement, QAfterFilterCondition>
      totalChipsToVerifyReadOnlyBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalChipsToVerifyReadOnly',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AthleteManagementQueryObject
    on QueryBuilder<AthleteManagement, AthleteManagement, QFilterCondition> {
  QueryBuilder<AthleteManagement, AthleteManagement, QAfterFilterCondition>
      athleteListElement(FilterQuery<AthleteItem> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'athleteList');
    });
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AthleteManagement _$AthleteManagementFromJson(Map<String, dynamic> json) =>
    AthleteManagement(
      athleteList: (json['athleteList'] as List<dynamic>?)
              ?.map((e) => AthleteItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AthleteItem>[],
      totalChipsToVerify: json['totalChipsToVerify'] as int? ?? 0,
      chipsVerified: json['chipsVerified'] as int? ?? 0,
    );

Map<String, dynamic> _$AthleteManagementToJson(AthleteManagement instance) =>
    <String, dynamic>{
      'athleteList': instance.athleteList,
      'totalChipsToVerify': instance.totalChipsToVerify,
      'chipsVerified': instance.chipsVerified,
    };
