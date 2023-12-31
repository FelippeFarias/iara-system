// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'readers.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetReadersCollection on Isar {
  IsarCollection<Readers> get readers => this.collection();
}

const ReadersSchema = CollectionSchema(
  name: r'Readers',
  id: -6290994913614454828,
  properties: {
    r'athleteManagement': PropertySchema(
      id: 0,
      name: r'athleteManagement',
      type: IsarType.object,
      target: r'AthleteManagement',
    ),
    r'chipEndNumber': PropertySchema(
      id: 1,
      name: r'chipEndNumber',
      type: IsarType.string,
    ),
    r'chipStartNumber': PropertySchema(
      id: 2,
      name: r'chipStartNumber',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'eventCode': PropertySchema(
      id: 4,
      name: r'eventCode',
      type: IsarType.string,
    ),
    r'isarId': PropertySchema(
      id: 5,
      name: r'isarId',
      type: IsarType.long,
    )
  },
  estimateSize: _readersEstimateSize,
  serialize: _readersSerialize,
  deserialize: _readersDeserialize,
  deserializeProp: _readersDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'AthleteManagement': AthleteManagementSchema,
    r'AthleteItem': AthleteItemSchema
  },
  getId: _readersGetId,
  getLinks: _readersGetLinks,
  attach: _readersAttach,
  version: '3.1.0+1',
);

int _readersEstimateSize(
  Readers object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      AthleteManagementSchema.estimateSize(
          object.athleteManagement, allOffsets[AthleteManagement]!, allOffsets);
  bytesCount += 3 + object.chipEndNumber.length * 3;
  bytesCount += 3 + object.chipStartNumber.length * 3;
  bytesCount += 3 + object.eventCode.length * 3;
  return bytesCount;
}

void _readersSerialize(
  Readers object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<AthleteManagement>(
    offsets[0],
    allOffsets,
    AthleteManagementSchema.serialize,
    object.athleteManagement,
  );
  writer.writeString(offsets[1], object.chipEndNumber);
  writer.writeString(offsets[2], object.chipStartNumber);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeString(offsets[4], object.eventCode);
  writer.writeLong(offsets[5], object.isarId);
}

Readers _readersDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Readers(
    athleteManagement: reader.readObjectOrNull<AthleteManagement>(
          offsets[0],
          AthleteManagementSchema.deserialize,
          allOffsets,
        ) ??
        AthleteManagement(),
    chipEndNumber: reader.readStringOrNull(offsets[1]) ?? '00000',
    chipStartNumber: reader.readStringOrNull(offsets[2]) ?? '00000',
    createdAt: reader.readDateTime(offsets[3]),
    eventCode: reader.readStringOrNull(offsets[4]) ?? '00000',
    id: id,
  );
  return object;
}

P _readersDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<AthleteManagement>(
            offset,
            AthleteManagementSchema.deserialize,
            allOffsets,
          ) ??
          AthleteManagement()) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '00000') as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '00000') as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? '00000') as P;
    case 5:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _readersGetId(Readers object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _readersGetLinks(Readers object) {
  return [];
}

void _readersAttach(IsarCollection<dynamic> col, Id id, Readers object) {
  object.id = id;
}

extension ReadersQueryWhereSort on QueryBuilder<Readers, Readers, QWhere> {
  QueryBuilder<Readers, Readers, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ReadersQueryWhere on QueryBuilder<Readers, Readers, QWhereClause> {
  QueryBuilder<Readers, Readers, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Readers, Readers, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Readers, Readers, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Readers, Readers, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ReadersQueryFilter
    on QueryBuilder<Readers, Readers, QFilterCondition> {
  QueryBuilder<Readers, Readers, QAfterFilterCondition> chipEndNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chipEndNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition>
      chipEndNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chipEndNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> chipEndNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chipEndNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> chipEndNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chipEndNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> chipEndNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'chipEndNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> chipEndNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'chipEndNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> chipEndNumberContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'chipEndNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> chipEndNumberMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'chipEndNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> chipEndNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chipEndNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition>
      chipEndNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'chipEndNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> chipStartNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chipStartNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition>
      chipStartNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chipStartNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> chipStartNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chipStartNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> chipStartNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chipStartNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition>
      chipStartNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'chipStartNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> chipStartNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'chipStartNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> chipStartNumberContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'chipStartNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> chipStartNumberMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'chipStartNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition>
      chipStartNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chipStartNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition>
      chipStartNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'chipStartNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> eventCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eventCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> eventCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'eventCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> eventCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'eventCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> eventCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'eventCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> eventCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'eventCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> eventCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'eventCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> eventCodeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'eventCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> eventCodeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'eventCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> eventCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eventCode',
        value: '',
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> eventCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'eventCode',
        value: '',
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> isarIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> isarIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> isarIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<Readers, Readers, QAfterFilterCondition> isarIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ReadersQueryObject
    on QueryBuilder<Readers, Readers, QFilterCondition> {
  QueryBuilder<Readers, Readers, QAfterFilterCondition> athleteManagement(
      FilterQuery<AthleteManagement> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'athleteManagement');
    });
  }
}

extension ReadersQueryLinks
    on QueryBuilder<Readers, Readers, QFilterCondition> {}

extension ReadersQuerySortBy on QueryBuilder<Readers, Readers, QSortBy> {
  QueryBuilder<Readers, Readers, QAfterSortBy> sortByChipEndNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chipEndNumber', Sort.asc);
    });
  }

  QueryBuilder<Readers, Readers, QAfterSortBy> sortByChipEndNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chipEndNumber', Sort.desc);
    });
  }

  QueryBuilder<Readers, Readers, QAfterSortBy> sortByChipStartNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chipStartNumber', Sort.asc);
    });
  }

  QueryBuilder<Readers, Readers, QAfterSortBy> sortByChipStartNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chipStartNumber', Sort.desc);
    });
  }

  QueryBuilder<Readers, Readers, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Readers, Readers, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Readers, Readers, QAfterSortBy> sortByEventCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventCode', Sort.asc);
    });
  }

  QueryBuilder<Readers, Readers, QAfterSortBy> sortByEventCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventCode', Sort.desc);
    });
  }

  QueryBuilder<Readers, Readers, QAfterSortBy> sortByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<Readers, Readers, QAfterSortBy> sortByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }
}

extension ReadersQuerySortThenBy
    on QueryBuilder<Readers, Readers, QSortThenBy> {
  QueryBuilder<Readers, Readers, QAfterSortBy> thenByChipEndNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chipEndNumber', Sort.asc);
    });
  }

  QueryBuilder<Readers, Readers, QAfterSortBy> thenByChipEndNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chipEndNumber', Sort.desc);
    });
  }

  QueryBuilder<Readers, Readers, QAfterSortBy> thenByChipStartNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chipStartNumber', Sort.asc);
    });
  }

  QueryBuilder<Readers, Readers, QAfterSortBy> thenByChipStartNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chipStartNumber', Sort.desc);
    });
  }

  QueryBuilder<Readers, Readers, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Readers, Readers, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Readers, Readers, QAfterSortBy> thenByEventCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventCode', Sort.asc);
    });
  }

  QueryBuilder<Readers, Readers, QAfterSortBy> thenByEventCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventCode', Sort.desc);
    });
  }

  QueryBuilder<Readers, Readers, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Readers, Readers, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Readers, Readers, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<Readers, Readers, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }
}

extension ReadersQueryWhereDistinct
    on QueryBuilder<Readers, Readers, QDistinct> {
  QueryBuilder<Readers, Readers, QDistinct> distinctByChipEndNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chipEndNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Readers, Readers, QDistinct> distinctByChipStartNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chipStartNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Readers, Readers, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Readers, Readers, QDistinct> distinctByEventCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eventCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Readers, Readers, QDistinct> distinctByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isarId');
    });
  }
}

extension ReadersQueryProperty
    on QueryBuilder<Readers, Readers, QQueryProperty> {
  QueryBuilder<Readers, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Readers, AthleteManagement, QQueryOperations>
      athleteManagementProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'athleteManagement');
    });
  }

  QueryBuilder<Readers, String, QQueryOperations> chipEndNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chipEndNumber');
    });
  }

  QueryBuilder<Readers, String, QQueryOperations> chipStartNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chipStartNumber');
    });
  }

  QueryBuilder<Readers, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Readers, String, QQueryOperations> eventCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eventCode');
    });
  }

  QueryBuilder<Readers, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Readers _$ReadersFromJson(Map<String, dynamic> json) => Readers(
      id: json['id'] as int? ?? 92831962,
      createdAt: DateTime.parse(json['createdAt'] as String),
      athleteManagement: AthleteManagement.fromJson(
          json['athleteManagement'] as Map<String, dynamic>),
      eventCode: json['eventCode'] as String? ?? '00000',
      chipStartNumber: json['chipStartNumber'] as String? ?? '00000',
      chipEndNumber: json['chipEndNumber'] as String? ?? '00000',
    );

Map<String, dynamic> _$ReadersToJson(Readers instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'athleteManagement': instance.athleteManagement,
      'eventCode': instance.eventCode,
      'chipStartNumber': instance.chipStartNumber,
      'chipEndNumber': instance.chipEndNumber,
    };
