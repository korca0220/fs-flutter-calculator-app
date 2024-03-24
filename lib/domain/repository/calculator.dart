import 'package:calculator_domain_starter/domain/entity/calculator.dart';

abstract interface class ICalculatorRepository {
  Future<CalculatorEntity> fetch();
  Future<void> save(CalculatorEntity entity);
}
