import 'package:get_it/get_it.dart';
import 'package:homeassignment/services/saving_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> setup() async {
  final prefs = await SharedPreferences.getInstance();
  locator.registerSingleton<SavingService>(SavingService(prefs: prefs));
}
