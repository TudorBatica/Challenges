import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'dependencies_configuration.config.dart';

/// Service locator
final getIt = GetIt.instance;

/// Service locator initializer
@injectableInit
void configureDependencies() => $initGetIt(getIt);
