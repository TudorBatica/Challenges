import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'dependencies_configuration.config.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies() => $initGetIt(getIt);
