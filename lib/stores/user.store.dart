import 'package:hive/hive.dart';
import 'package:midnights/models/shared/user.model.dart';
import 'package:mobx/mobx.dart';

part 'user.store.g.dart';

// ignore: library_private_types_in_public_api
class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  late final Box _userDB;

  @observable
  UserModel? user;

  _UserStore() {
    _initRepository();
  }

  _initRepository() async {
    await _initDatabase();
    await loadUserData();
  }

  _initDatabase() async {
    _userDB = await Hive.openBox('user');
  }

  @action
  loadUserData() {
    UserModel pUser = UserModel();
    if (_userDB.isNotEmpty) {
      pUser.name = _userDB.get('userName') ?? 'swiftie';
      pUser.icon = UserIcon.values[_userDB.get('userIcon')];
      setUser(pUser);
    }
  }

  @action
  void updateUsericon(UserIcon pIcon) {
    user!.icon = pIcon;
    _userDB.put('userIcon', pIcon.index);
  }

  @action
  void updateUserName(String pName) {
    user!.name = pName;
    _userDB.put('userName', pName);
  }

  @action
  void setUser(UserModel pUser) {
    _userDB.put('userName', pUser.name);
    _userDB.put('userIcon', pUser.icon!.index);
    user = pUser;
  }

  @action
  void unsetUser() {
    user = null;
    _userDB.deleteAll(['userName', 'userIcon']);
  }

  @action
  void loadAchievements() {}
}
