import 'package:calculator_domain_starter/domain/domain.dart';
import 'package:calculator_domain_starter/util/use_case.dart';

class SaveCalculatorUseCase
    implements IUseCase<void, SaveCalculatorUseCaseParams> {
  SaveCalculatorUseCase(
    this._calculatorRepository,
  );
  final ICalculatorRepository _calculatorRepository;

  @override
  Future<void> execute([SaveCalculatorUseCaseParams? params]) async {
    if (params == null) return;
    await _calculatorRepository.save(params.entity);
  }
}

class SaveCalculatorUseCaseParams {
  SaveCalculatorUseCaseParams({required this.entity});
  final CalculatorEntity entity;
}
