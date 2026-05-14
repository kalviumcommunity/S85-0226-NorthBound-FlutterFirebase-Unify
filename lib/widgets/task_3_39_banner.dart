import 'package:flutter/widgets.dart';

class Task339Banner extends StatelessWidget {
  final String message;
  const Task339Banner(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Text('Banner: $message');
}
