import 'package:calculator_domain_starter_domain/domain.dart';
import 'package:flutter/foundation.dart';

class CalculatorViewModel extends ValueNotifier<CalculatorEntity> {
  final FetchCalculatorUseCase _fetchCalculatorUseCase;
  final SaveCalculatorUseCase _saveCalculatorUseCase;

  CalculatorViewModel(
    this._fetchCalculatorUseCase,
    this._saveCalculatorUseCase,
    super.calculator,
  );

  Future<void> load() async {
    value = await _fetchCalculatorUseCase.execute();
  }

  Future<void> save() async {
    final params = SaveCalculatorUseCaseParams(entity: value);

    await _saveCalculatorUseCase.execute(params);
  }

  void calculate(String buttonText) {
    value.calculate(buttonText);
    notifyListeners();
  }
}
