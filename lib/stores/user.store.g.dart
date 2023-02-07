// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStore, Store {
  late final _$userAtom = Atom(name: '_UserStore.user', context: context);

  @override
  UserModel? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$_UserStoreActionController =
      ActionController(name: '_UserStore', context: context);

  @override
  dynamic loadUserData() {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.loadUserData');
    try {
      return super.loadUserData();
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateUsericon(UserIcon pIcon) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.updateUsericon');
    try {
      return super.updateUsericon(pIcon);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateUserName(String pName) {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.updateUserName');
    try {
      return super.updateUserName(pName);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUser(UserModel pUser) {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.setUser');
    try {
      return super.setUser(pUser);
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void unsetUser() {
    final _$actionInfo =
        _$_UserStoreActionController.startAction(name: '_UserStore.unsetUser');
    try {
      return super.unsetUser();
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadAchievements() {
    final _$actionInfo = _$_UserStoreActionController.startAction(
        name: '_UserStore.loadAchievements');
    try {
      return super.loadAchievements();
    } finally {
      _$_UserStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user}
    ''';
  }
}
