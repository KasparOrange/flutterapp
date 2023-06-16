import 'package:flutter/material.dart';
import 'package:flutterapp/services/keyboard_service.dart';
import 'package:flutterapp/services/log_service.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'package:provider/provider.dart';
import 'package:simple_markdown_editor/simple_markdown_editor.dart';

class MarkdownEditorModule extends StatefulWidget {
  const MarkdownEditorModule({super.key});

  @override
  State<MarkdownEditorModule> createState() => _MarkdownEditorModuleState();
}

class _MarkdownEditorModuleState extends State<MarkdownEditorModule> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardService = Provider.of<KeyboardService>(context);
    return Container(
        height: 300,
        margin: EdgeInsets.all(100),
        // padding: EdgeInsets.all(100),
        decoration: BoxDecoration(
            border: Border.all(width: 10, style: BorderStyle.solid),
            gradient: LinearGradient(colors: [Colors.blue, Colors.yellow])),
        child: MarkdownTextInput(
          (value) {
            log(value);
          },
          'Initial Value',
          label: 'Description',
          maxLines: 10,
          actions: MarkdownType.values,
          controller: _controller,
          textStyle: TextStyle(fontSize: 16),
        )

        // child: MarkdownFormField(
        //   controller: _controller,
        //   // focusNode: keyboardService.textInputFocusNode,
        //   enableToolBar: true,
        //   emojiConvert: true,
        //   autoCloseAfterSelectEmoji: false,
        // ),
        );
  }
}
