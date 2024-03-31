import '../../domain.dart';
import '../util/use_case.dart';

class FetchCalculatorUseCase implements IUseCase<CalculatorEntity, void> {
  FetchCalculatorUseCase(
    this._calculatorRepository,
  );
  final ICalculatorRepository _calculatorRepository;

  @override
  Future<CalculatorEntity> execute([void params]) {
    return _calculatorRepository.fetch();
  }
}
