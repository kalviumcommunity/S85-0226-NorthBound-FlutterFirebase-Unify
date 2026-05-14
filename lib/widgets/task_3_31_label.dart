import 'package:flutter/widgets.dart';

class Task331Label extends StatelessWidget {
  final String text;
  const Task331Label(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text('Task 3.31: $text');
}
