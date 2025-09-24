import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CollectionInputWidget extends StatefulWidget {
  final String placeholder;
  final bool focus;
  final Function(String) onSubmitted;

  const CollectionInputWidget({
    Key? key,
    required this.placeholder,
    required this.focus,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  State<CollectionInputWidget> createState() => _CollectionInputWidgetState();
}

class _CollectionInputWidgetState extends State<CollectionInputWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.focus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();
      });
    }
  }

  @override
  void didUpdateWidget(CollectionInputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focus && !oldWidget.focus) {
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z@$\.\-_]')),
        ],
        decoration: InputDecoration(
          hintText: widget.placeholder,
          border: const OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _controller.clear();
            },
          ),
        ),
        onSubmitted: (value) {
          widget.onSubmitted(value);
          _controller.clear();
        },
      ),
    );
  }
}