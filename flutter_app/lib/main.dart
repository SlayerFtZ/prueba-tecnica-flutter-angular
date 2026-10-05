import 'package:flutter/material.dart';
import 'package:flutter_app/features/shared/widgets/footer.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            const Expanded(child: Center(child: Text('Hello World!'))),
            AppFooter(),
          ],
        ),
      ),
    );
  }
}
