import 'package:borsellino/repository/repositories.dart';
import 'package:dependencies/dependencies.dart';

class RepositoryModule implements Module {
  @override
  void configure(Binder binder) {
    binder
      ..bindLazySingleton((injector, p) => ChainsRepository(injector.get()))
      ..bindLazySingleton((injector, p) => ValidatorsRepository(injector.get()))..bindLazySingleton((
        injector, p) => MnemonicRepository(injector.get()))..bindLazySingleton((
        injector, p) => AccountRepository(injector.get()))..bindLazySingleton((
        injector, p) => TransactionsRepository());
  }
}
