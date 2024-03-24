import 'package:flutter/material.dart';

import '../../presentation/presentation.dart';
import '../widget/widget.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorViewModel _viewModel = CalculatorViewModel(
    FetchCalculatorUseCase(),
    SaveCalculatorUseCase(),
    Calculator(),
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _viewModel.load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Calculator'),
      ),
      body: ValueListenableBuilder<Calculator>(
        valueListenable: _viewModel,
        builder: (context, calculator, child) {
          return Column(
            children: [
              CalculatorBoard(
                number: _viewModel.value.result,
              ),
              Row(
                children: [
                  Expanded(
                    child: CalculatorButton.complex(
                      text: 'AC',
                      onTap: (text) => _perform(text),
                    ),
                  ),
                  Expanded(
                    child: CalculatorButton.complex(
                        text: '+/-', onTap: (text) => _perform(text)),
                  ),
                  Expanded(
                    child: CalculatorButton.complex(
                        text: '<', onTap: (text) => _perform(text)),
                  ),
                  Expanded(
                    child: CalculatorButton.operator(
                        text: '/', onTap: (text) => _perform(text)),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CalculatorButton.simple(
                        text: '7', onTap: (text) => _perform(text)),
                  ),
                  Expanded(
                    child: CalculatorButton.simple(
                        text: '8', onTap: (text) => _perform(text)),
                  ),
                  Expanded(
                    child: CalculatorButton.simple(
                        text: '9', onTap: (text) => _perform(text)),
                  ),
                  Expanded(
                    child: CalculatorButton.operator(
                        text: 'X', onTap: (text) => _perform(text)),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CalculatorButton.simple(
                        text: '4', onTap: (text) => _perform(text)),
                  ),
                  Expanded(
                    child: CalculatorButton.simple(
                        text: '5', onTap: (text) => _perform(text)),
                  ),
                  Expanded(
                    child: CalculatorButton.simple(
                        text: '6', onTap: (text) => _perform(text)),
                  ),
                  Expanded(
                    child: CalculatorButton.operator(
                        text: '-', onTap: (text) => _perform(text)),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CalculatorButton.simple(
                        text: '1', onTap: (text) => _perform(text)),
                  ),
                  Expanded(
                    child: CalculatorButton.simple(
                        text: '2', onTap: (text) => _perform(text)),
                  ),
                  Expanded(
                    child: CalculatorButton.simple(
                        text: '3', onTap: (text) => _perform(text)),
                  ),
                  Expanded(
                    child: CalculatorButton.operator(
                        text: '+', onTap: (text) => _perform(text)),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CalculatorButton.simple(
                        text: '0', onTap: (text) => _perform(text)),
                  ),
                  Expanded(
                    child: CalculatorButton.simple(
                        text: '.', onTap: (text) => _perform(text)),
                  ),
                  Expanded(
                    child: CalculatorButton.operator(
                        text: '=', onTap: (text) => _perform(text, save: true)),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void _perform(String buttonText, {bool save = false}) async {
    _viewModel.calculate(buttonText);

    if (save) {
      await _viewModel.save();
    }
  }
}

abstract class ICalculatorLocalDataSource {
  String get key;

  Future<void> setString(String value);

  Future<String?> getString();
}
