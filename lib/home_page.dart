import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/bloc_pattern/imc_bloc_pattern_page.dart';
import 'package:flutter_default_state_manager/change_notifier.dart/imc_change_notifier_page.dart';
import 'package:flutter_default_state_manager/setState/imc_set_state_page.dart';
import 'package:flutter_default_state_manager/value_notifier/value_notifier_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _goToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => page,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () => _goToPage(context, const ImcSetStatePage()),
                child: const Text('SetState')),
            ElevatedButton(
                onPressed: () => _goToPage(context, const ValueNotifierPage()),
                child: const Text('ValueNotifier')),
            ElevatedButton(
                onPressed: () =>
                    _goToPage(context, const ImcChangeNotifierPage()),
                child: const Text('ChangeNotifier')),
            ElevatedButton(
                onPressed: () => _goToPage(context, const ImcBlocPatternPage()),
                child: const Text('Bloc Pattern (Streams)')),
          ],
        ),
      ),
    );
  }
}
