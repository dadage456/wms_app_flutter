import 'package:flutter/material.dart';

class TodoPlaceholderPage extends StatelessWidget {
  const TodoPlaceholderPage({super.key, required this.title, this.message});

  final String title;
  final String? message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            message ?? '$title\n功能开发中，请参考 TODO 文档获取进度。',
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
