import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/change_notifier.dart/imc_change_notifier_controller.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge.dart';
import 'package:intl/intl.dart';

class ImcChangeNotifierPage extends StatefulWidget {
  const ImcChangeNotifierPage({super.key});

  @override
  State<ImcChangeNotifierPage> createState() => _ImcChangeNotifierPageState();
}

class _ImcChangeNotifierPageState extends State<ImcChangeNotifierPage> {
  final controller = ImcChangeNotifierController();
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('BUILD TELA');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Notifier'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: Column(
              children: [
                AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      return ImcGauge(imc: controller.imc);
                    }),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Peso obrigatório";
                    }
                    return null;
                  },
                  controller: pesoEC,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Peso'),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt-_BR',
                      symbol: '',
                      turnOffGrouping: true,
                      decimalDigits: 2,
                    )
                  ],
                ),
                TextFormField(
                  controller: alturaEC,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Altura obrigatória";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Altura'),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt-_BR',
                      symbol: '',
                      turnOffGrouping: true,
                      decimalDigits: 2,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      var formatter = NumberFormat.simpleCurrency(
                        locale: 'pt_BR',
                        decimalDigits: 2,
                      );
                      double peso = formatter.parse(pesoEC.text) as double;
                      double altura = formatter.parse(alturaEC.text) as double;
                      controller.calcularImc(peso: peso, altura: altura);
                    },
                    child: const Text('Calcular IMC')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
