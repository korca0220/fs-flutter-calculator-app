import 'package:flutter/material.dart';

import '../../data/data_source/data_source.dart';
import '../../data/repository/repository.dart';

class CalculatorViewModel extends ValueNotifier<CalculatorEntity> {
  CalculatorViewModel(
    this.fetchCalculatorUseCase,
    this.saveCalculatorUseCase,
    super.calculator,
  );
  final FetchCalculatorUseCase fetchCalculatorUseCase;
  final SaveCalculatorUseCase saveCalculatorUseCase;

  Future<void> load() async {
    value = await fetchCalculatorUseCase.execute();
  }

  Future<void> save() async {
    await saveCalculatorUseCase.execute(value);
  }

  void calculate(String buttonText) {
    value.calculate(buttonText);
    notifyListeners();
  }
}

class FetchCalculatorUseCase {
  Future<CalculatorEntity> execute() async {
    return CalculatorRepository(
      CalculatorDataSource(
        CalculatorLocalDataSource(),
      ),
    ).fetch();
  }
}

class SaveCalculatorUseCase {
  Future<void> execute(CalculatorEntity value) async {
    CalculatorRepository(
      CalculatorDataSource(
        CalculatorLocalDataSource(),
      ),
    ).save(value);
  }
}
