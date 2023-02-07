// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'records.provider.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RecordesRepository on RecordesRepositoryBase, Store {
  late final _$conquistaMidAtom =
      Atom(name: 'RecordesRepositoryBase.conquistaMid', context: context);

  @override
  AchievementAlbumModel get conquistaMid {
    _$conquistaMidAtom.reportRead();
    return super.conquistaMid;
  }

  @override
  set conquistaMid(AchievementAlbumModel value) {
    _$conquistaMidAtom.reportWrite(value, super.conquistaMid, () {
      super.conquistaMid = value;
    });
  }

  late final _$RecordesRepositoryBaseActionController =
      ActionController(name: 'RecordesRepositoryBase', context: context);

  @override
  dynamic loadRecordes() {
    final _$actionInfo = _$RecordesRepositoryBaseActionController.startAction(
        name: 'RecordesRepositoryBase.loadRecordes');
    try {
      return super.loadRecordes();
    } finally {
      _$RecordesRepositoryBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateRecordes(
      {required Album album, required GameType type, required int score}) {
    final _$actionInfo = _$RecordesRepositoryBaseActionController.startAction(
        name: 'RecordesRepositoryBase.updateRecordes');
    try {
      return super.updateRecordes(album: album, type: type, score: score);
    } finally {
      _$RecordesRepositoryBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
conquistaMid: ${conquistaMid}
    ''';
  }
}
