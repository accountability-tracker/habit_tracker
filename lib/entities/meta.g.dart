// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAppMetaInfoCollection on Isar {
  IsarCollection<AppMetaInfo> get appMetaInfos => this.collection();
}

const AppMetaInfoSchema = CollectionSchema(
  name: r'AppMetaInfo',
  id: -6244452097842981940,
  properties: {
    r'appVersion': PropertySchema(
      id: 0,
      name: r'appVersion',
      type: IsarType.string,
    )
  },
  estimateSize: _appMetaInfoEstimateSize,
  serialize: _appMetaInfoSerialize,
  deserialize: _appMetaInfoDeserialize,
  deserializeProp: _appMetaInfoDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _appMetaInfoGetId,
  getLinks: _appMetaInfoGetLinks,
  attach: _appMetaInfoAttach,
  version: '3.1.0+1',
);

int _appMetaInfoEstimateSize(
  AppMetaInfo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.appVersion.length * 3;
  return bytesCount;
}

void _appMetaInfoSerialize(
  AppMetaInfo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.appVersion);
}

AppMetaInfo _appMetaInfoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AppMetaInfo();
  object.appVersion = reader.readString(offsets[0]);
  object.id = id;
  return object;
}

P _appMetaInfoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _appMetaInfoGetId(AppMetaInfo object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _appMetaInfoGetLinks(AppMetaInfo object) {
  return [];
}

void _appMetaInfoAttach(
    IsarCollection<dynamic> col, Id id, AppMetaInfo object) {
  object.id = id;
}

extension AppMetaInfoQueryWhereSort
    on QueryBuilder<AppMetaInfo, AppMetaInfo, QWhere> {
  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AppMetaInfoQueryWhere
    on QueryBuilder<AppMetaInfo, AppMetaInfo, QWhereClause> {
  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterWhereClause> idBetween(
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

extension AppMetaInfoQueryFilter
    on QueryBuilder<AppMetaInfo, AppMetaInfo, QFilterCondition> {
  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterFilterCondition>
      appVersionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterFilterCondition>
      appVersionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'appVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterFilterCondition>
      appVersionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'appVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterFilterCondition>
      appVersionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'appVersion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterFilterCondition>
      appVersionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'appVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterFilterCondition>
      appVersionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'appVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterFilterCondition>
      appVersionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'appVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterFilterCondition>
      appVersionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'appVersion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterFilterCondition>
      appVersionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appVersion',
        value: '',
      ));
    });
  }

  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterFilterCondition>
      appVersionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'appVersion',
        value: '',
      ));
    });
  }

  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterFilterCondition> idBetween(
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
}

extension AppMetaInfoQueryObject
    on QueryBuilder<AppMetaInfo, AppMetaInfo, QFilterCondition> {}

extension AppMetaInfoQueryLinks
    on QueryBuilder<AppMetaInfo, AppMetaInfo, QFilterCondition> {}

extension AppMetaInfoQuerySortBy
    on QueryBuilder<AppMetaInfo, AppMetaInfo, QSortBy> {
  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterSortBy> sortByAppVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appVersion', Sort.asc);
    });
  }

  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterSortBy> sortByAppVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appVersion', Sort.desc);
    });
  }
}

extension AppMetaInfoQuerySortThenBy
    on QueryBuilder<AppMetaInfo, AppMetaInfo, QSortThenBy> {
  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterSortBy> thenByAppVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appVersion', Sort.asc);
    });
  }

  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterSortBy> thenByAppVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appVersion', Sort.desc);
    });
  }

  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AppMetaInfo, AppMetaInfo, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension AppMetaInfoQueryWhereDistinct
    on QueryBuilder<AppMetaInfo, AppMetaInfo, QDistinct> {
  QueryBuilder<AppMetaInfo, AppMetaInfo, QDistinct> distinctByAppVersion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'appVersion', caseSensitive: caseSensitive);
    });
  }
}

extension AppMetaInfoQueryProperty
    on QueryBuilder<AppMetaInfo, AppMetaInfo, QQueryProperty> {
  QueryBuilder<AppMetaInfo, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AppMetaInfo, String, QQueryOperations> appVersionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appVersion');
    });
  }
}
