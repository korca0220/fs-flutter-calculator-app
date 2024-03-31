import 'package:calculator_domain_starter_di/di.dart';
import 'package:flutter/material.dart';

import '../../ui.dart';

abstract class ICalculatorRouteTo {
  static Future<void> calculator(BuildContext context) {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const CalculatorProvider(
        child: CalculatorScreen(),
      ),
    ));
  }
}
