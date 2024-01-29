import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/bloc_pattern/imc_bloc_pattern_controller.dart';
import 'package:flutter_default_state_manager/bloc_pattern/imc_state.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge.dart';
import 'package:intl/intl.dart';

class ImcBlocPatternPage extends StatefulWidget {
  const ImcBlocPatternPage({super.key});

  @override
  State<ImcBlocPatternPage> createState() => _ImcBlocPatternPageState();
}

class _ImcBlocPatternPageState extends State<ImcBlocPatternPage> {
  final controller = ImcBlocPatternController();
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ImcBlocPatternPage'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: Column(
              children: [
                StreamBuilder<ImcState>(
                  stream: controller.imcOut,
                  builder: (context, snapshot) {
                    var imc = snapshot.data?.imc ?? 0;
                    return ImcGauge(imc: imc);
                  },
                ),
                const SizedBox(height: 20),
                StreamBuilder<ImcState>(
                  stream: controller.imcOut,
                  builder: (context, snapshot) {
                    final dataValue = snapshot.data;
                    if (dataValue is ImcStateLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (dataValue is ImcStateError) {
                      return Text(dataValue.message);
                    }
                    return const SizedBox.shrink();
                  },
                ),
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
