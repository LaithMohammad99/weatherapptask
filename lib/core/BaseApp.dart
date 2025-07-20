import 'package:flutter/cupertino.dart';
import 'package:weatherapptask/injection_container.dart';

import 'base_app_client.dart';

class BaseApp with ChangeNotifier{

  final BaseAppClient apiClient = di<BaseAppClient>();

  void changeState(){
    notifyListeners();
  }


}