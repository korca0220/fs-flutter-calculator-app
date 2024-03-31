import '../../domain.dart';

abstract interface class ICalculatorRepository {
  Future<CalculatorEntity> fetch();
  Future<void> save(CalculatorEntity entity);
}
