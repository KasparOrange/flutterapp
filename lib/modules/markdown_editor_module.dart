import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutterapp/services/keyboard_service.dart';
import 'package:flutterapp/services/logging_service.dart';
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

  final String exampleMD = ''' 
# H1
*BOLD* \n
_Italic_

''';

  @override
  Widget build(BuildContext context) {
    final keyboardService = Provider.of<KeyboardService>(context);
    return Container(
      height: 1000,
      margin: EdgeInsets.all(100),
      // padding: EdgeInsets.all(100),
      decoration: BoxDecoration(
          border: Border.all(width: 10, style: BorderStyle.solid),
          gradient: LinearGradient(colors: [Colors.blue, Colors.yellow])),
      child:

          // NOTE: This displays Markdown fine, but one would have to input every linebreak by hand.
          // Markdown(data: exampleMD,)

          // NOTE: This just breaks outright. Validation errors. Not null-safty compatible?
          // MarkdownTextInput(
          //   (value) {
          //     log(value);
          //   },
          //   'Initial Value',
          //   label: 'Description',
          //   maxLines: 10,
          //   actions: MarkdownType.values,
          //   controller: _controller,
          //   textStyle: TextStyle(fontSize: 16),
          // )

          // NOTE: This does not throw any errors, but its buttons don't do anything jet. Focus? Containter size?
          MarkdownFormField(
        controller: _controller,
        // focusNode: keyboardService.textInputFocusNode, // NOTE: This node tells the KeyboardService to not act on hotkeys when it has focus.
        enableToolBar: true,
        emojiConvert: true,
        autoCloseAfterSelectEmoji: false,
      ),
    );
  }
}
