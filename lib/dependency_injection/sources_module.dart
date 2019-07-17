import 'package:borsellino/source/sources.dart';
import 'package:dependencies/dependencies.dart';

class SourcesModule implements Module {
  @override
  void configure(Binder binder) {
    binder

      ..bindLazySingleton((injector, p) => ValidatorSource(
            endpoints: injector.get(),
            httpClient: injector.get(),
          ));
  }
}