import 'package:midnights/stores/user.store.dart';

class HomeController {
  HomeController(UserStore uStore) {
    _uStore = uStore;
  }

  late UserStore _uStore;

  String getInitialMessage() {
    String result = '';
    int hour = DateTime.now().hour;
    if (hour >= 6 && hour <= 12) {
      result = 'Bom dia';
    } else if (hour >= 13 && hour <= 18) {
      result = 'Boa tarde';
    } else {
      result = 'Boa noite';
    }

    return '$result, ${_uStore.user!.name}! Bora mostrar que conhece bem a Taylor?';
  }
}
