import 'package:calculator_domain_starter/data/data.dart';
import 'package:calculator_domain_starter/domain/entity/calculator.dart';
import 'package:calculator_domain_starter/domain/repository/repository.dart';
import 'package:calculator_domain_starter/domain/use_case/fetch_calculator.dart';
import 'package:calculator_domain_starter/domain/use_case/save_calculator.dart';
import 'package:calculator_domain_starter/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorProvider extends StatelessWidget {
  const CalculatorProvider({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ICalculatorLocalDataSource>(
          create: (context) => CalculatorLocalDataSource(),
        ),
      ],
      child: MultiProvider(
        providers: [
          Provider<CalculatorDataSource>(
            create: (context) => CalculatorDataSource(
              context.read(),
            ),
          ),
        ],
        child: MultiProvider(
          providers: [
            Provider<ICalculatorRepository>(
              create: (context) => CalculatorRepository(
                context.read(),
              ),
            ),
          ],
          child: MultiProvider(
            providers: [
              Provider<FetchCalculatorUseCase>(
                create: (context) => FetchCalculatorUseCase(
                  context.read(),
                ),
              ),
              Provider<SaveCalculatorUseCase>(
                create: (context) => SaveCalculatorUseCase(
                  context.read(),
                ),
              ),
            ],
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider<CalculatorViewModel>(
                  create: (context) => CalculatorViewModel(
                    context.read<FetchCalculatorUseCase>(),
                    context.read<SaveCalculatorUseCase>(),
                    CalculatorEntity(),
                  ),
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
