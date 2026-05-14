import 'package:flutter/widgets.dart';

class Task336Card extends StatelessWidget {
  final Widget child;
  const Task336Card({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.all(8.0), child: child);
}
