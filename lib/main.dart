import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import 'app/app_widget.dart';
import 'app/core/shared/consts/file_consts.dart';
import 'app/core/shared/inject/inject.dart';
import 'app/core/shared/services/local/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: FileConst.env);
  await Inject.initialize();
  await GetIt.I.get<IHiveService>().initialize();

  runApp(const AppWidget());
}
