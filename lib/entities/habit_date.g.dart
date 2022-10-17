// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_date.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetHabitDateCollection on Isar {
  IsarCollection<HabitDate> get habitDates => this.collection();
}

const HabitDateSchema = CollectionSchema(
  name: r'HabitDate',
  id: -5694996587843293287,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.string,
    ),
    r'habit_id': PropertySchema(
      id: 1,
      name: r'habit_id',
      type: IsarType.long,
    ),
    r'value': PropertySchema(
      id: 2,
      name: r'value',
      type: IsarType.long,
    )
  },
  estimateSize: _habitDateEstimateSize,
  serialize: _habitDateSerialize,
  deserialize: _habitDateDeserialize,
  deserializeProp: _habitDateDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _habitDateGetId,
  getLinks: _habitDateGetLinks,
  attach: _habitDateAttach,
  version: '3.0.0',
);

int _habitDateEstimateSize(
  HabitDate object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.date.length * 3;
  return bytesCount;
}

void _habitDateSerialize(
  HabitDate object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.date);
  writer.writeLong(offsets[1], object.habit_id);
  writer.writeLong(offsets[2], object.value);
}

HabitDate _habitDateDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HabitDate();
  object.date = reader.readString(offsets[0]);
  object.habit_id = reader.readLong(offsets[1]);
  object.id = id;
  object.value = reader.readLong(offsets[2]);
  return object;
}

P _habitDateDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _habitDateGetId(HabitDate object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _habitDateGetLinks(HabitDate object) {
  return [];
}

void _habitDateAttach(IsarCollection<dynamic> col, Id id, HabitDate object) {
  object.id = id;
}

extension HabitDateQueryWhereSort
    on QueryBuilder<HabitDate, HabitDate, QWhere> {
  QueryBuilder<HabitDate, HabitDate, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HabitDateQueryWhere
    on QueryBuilder<HabitDate, HabitDate, QWhereClause> {
  QueryBuilder<HabitDate, HabitDate, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<HabitDate, HabitDate, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterWhereClause> idBetween(
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

extension HabitDateQueryFilter
    on QueryBuilder<HabitDate, HabitDate, QFilterCondition> {
  QueryBuilder<HabitDate, HabitDate, QAfterFilterCondition> dateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterFilterCondition> dateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterFilterCondition> dateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterFilterCondition> dateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterFilterCondition> dateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterFilterCondition> dateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterFilterCondition> dateContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterFilterCondition> dateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'date',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterFilterCondition> dateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: '',
      ));
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterFilterCondition> dateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'date',
        value: '',
      ));
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterFilterCondition> habit_idEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'habit_id',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterFilterCondition> habit_idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'habit_id',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterFilterCondition> habit_idLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'habit_id',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterFilterCondition> habit_idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'habit_id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<HabitDate, HabitDate, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<HabitDate, HabitDate, QAfterFilterCondition> idBetween(
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

  QueryBuilder<HabitDate, HabitDate, QAfterFilterCondition> valueEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterFilterCondition> valueGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'value',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterFilterCondition> valueLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'value',
        value: value,
      ));
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterFilterCondition> valueBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'value',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension HabitDateQueryObject
    on QueryBuilder<HabitDate, HabitDate, QFilterCondition> {}

extension HabitDateQueryLinks
    on QueryBuilder<HabitDate, HabitDate, QFilterCondition> {}

extension HabitDateQuerySortBy on QueryBuilder<HabitDate, HabitDate, QSortBy> {
  QueryBuilder<HabitDate, HabitDate, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterSortBy> sortByHabit_id() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habit_id', Sort.asc);
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterSortBy> sortByHabit_idDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habit_id', Sort.desc);
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterSortBy> sortByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterSortBy> sortByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }
}

extension HabitDateQuerySortThenBy
    on QueryBuilder<HabitDate, HabitDate, QSortThenBy> {
  QueryBuilder<HabitDate, HabitDate, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterSortBy> thenByHabit_id() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habit_id', Sort.asc);
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterSortBy> thenByHabit_idDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'habit_id', Sort.desc);
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterSortBy> thenByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.asc);
    });
  }

  QueryBuilder<HabitDate, HabitDate, QAfterSortBy> thenByValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'value', Sort.desc);
    });
  }
}

extension HabitDateQueryWhereDistinct
    on QueryBuilder<HabitDate, HabitDate, QDistinct> {
  QueryBuilder<HabitDate, HabitDate, QDistinct> distinctByDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HabitDate, HabitDate, QDistinct> distinctByHabit_id() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'habit_id');
    });
  }

  QueryBuilder<HabitDate, HabitDate, QDistinct> distinctByValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'value');
    });
  }
}

extension HabitDateQueryProperty
    on QueryBuilder<HabitDate, HabitDate, QQueryProperty> {
  QueryBuilder<HabitDate, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HabitDate, String, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<HabitDate, int, QQueryOperations> habit_idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'habit_id');
    });
  }

  QueryBuilder<HabitDate, int, QQueryOperations> valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'value');
    });
  }
}
