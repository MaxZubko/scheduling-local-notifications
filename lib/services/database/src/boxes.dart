import 'package:hive/hive.dart';
import 'package:scheduling_local_notifications_app/models/models.dart';

import '../../services.dart';

class Boxes {
  static Box<UserModel> getUser() => Hive.box<UserModel>(Database.user);
}
