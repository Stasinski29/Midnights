import 'package:midnights/models/shared/user.model.dart';
import 'package:midnights/providers/records.provider.dart';
import 'package:midnights/stores/user.store.dart';

class MainController {
  MainController(UserStore uStore, RecordesRepository rep) {
    _uStore = uStore;
    _recordesRepository = rep;
  }

  late UserStore _uStore;
  late RecordesRepository _recordesRepository;
  late UserModel _user;
  bool loading = true;

  Future<void> fetchUser() async {
    _recordesRepository.loadRecordes();
  }

  void setUser() {
    _uStore.setUser(_user);
  }
}
