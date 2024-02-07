import 'package:hive/hive.dart';

import '../../../models/notify_model/notify_model.dart';
import '../../services.dart';

class Boxes {
  static Box<NotifyModel> getUser() =>
      Hive.box<NotifyModel>(Database.notifyKey);
}
