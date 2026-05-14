import 'package:flutter/widgets.dart';

class Task329Button extends StatelessWidget {
  final VoidCallback? onPressed;
  const Task329Button({this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onPressed,
        child: const Text('Task 3.29 Button'),
      );
}
