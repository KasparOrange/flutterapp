// import 'package:flutter/material.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:flutterapp/services/keyboard_service.dart';
// import 'package:flutterapp/services/logging_service.dart';
// import 'package:markdown_editable_textinput/format_markdown.dart';
// import 'package:markdown_editable_textinput/markdown_text_input.dart';
// import 'package:provider/provider.dart';
// import 'package:simple_markdown_editor/simple_markdown_editor.dart';

// class MarkdownEditorModule extends StatefulWidget {
//   const MarkdownEditorModule({super.key});

//   @override
//   State<MarkdownEditorModule> createState() => _MarkdownEditorModuleState();
// }

// class _MarkdownEditorModuleState extends State<MarkdownEditorModule> {
//   late final TextEditingController _controller;
//   late final GlobalKey

//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }

//   final String exampleMD = '''
// # H1
// *BOLD* \n
// _Italic_

// ''';

//   @override
//   Widget build(BuildContext context) {
//     final keyboardService = Provider.of<KeyboardService>(context);
//     return Container(
//       height: 1000,
//       margin: EdgeInsets.all(40),
//       // padding: EdgeInsets.all(100),
//       decoration: BoxDecoration(
//           border: Border.all(width: 10, style: BorderStyle.solid),
//           gradient: LinearGradient(colors: [Colors.blue, Colors.yellow])),
//       child:

//           // NOTE: This displays Markdown fine, but one would have to input every linebreak by hand.
//           Column(
//             children: [
//               Container(
//                 height: 200,
//                 child: MarkdownFormField(
//                 controller: _controller,
//                 focusNode: keyboardService.textInputFocusNode, // NOTE: This node tells the KeyboardService to not act on hotkeys when it has focus.
//                 enableToolBar: true,
//                 emojiConvert: true,
//                 autoCloseAfterSelectEmoji: false,
//               ),
//                 // child: Markdown(data: exampleMD,)
//                 ),
//                 // MarkdownToolbar(onPreviewChanged: () {},
//                 // controller: _controller,
//                 // focusNode: keyboardService.textInputFocusNode,
//                 // isEditorFocused: (hasFocus) {})
//             ],
//           )

//           // NOTE: This just breaks outright. Validation errors. Not null-safty compatible?
//           // MarkdownTextInput(
//           //   (value) {
//           //     log(value);
//           //   },
//           //   'Initial Value',
//           //   label: 'Description',
//           //   maxLines: 10,
//           //   actions: MarkdownType.values,
//           //   controller: _controller,
//           //   textStyle: TextStyle(fontSize: 16),
//           // )

//           // NOTE: This does not throw any errors, but its buttons don't do anything jet. Focus? Containter size?

//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:simple_markdown_editor/simple_markdown_editor.dart';

class MarkdownEditorModule extends StatelessWidget {
  const MarkdownEditorModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const EditorScreen()));
              },
              color: Colors.blue,
              child: const Text(
                "Editor Screen 1",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const EditorTestPreviewUnfocused()));
              },
              color: Colors.blue,
              child: const Text(
                "Editor Screen 2",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// HomeScreen Editor
class EditorScreen extends StatefulWidget {
  const EditorScreen({Key? key}) : super(key: key);

  @override
  _EditorScreenState createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Markdown Editor"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SecondScreen(
                    data: _controller.text,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.view_compact),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: MarkdownFormField(
                controller: _controller,
                enableToolBar: true,
                emojiConvert: true,
                autoCloseAfterSelectEmoji: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key, required this.data}) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Markdown Parse"),
      ),
      body: MarkdownParse(
        data: data,
        onTapHastag: (String name, String match) {
          // example : #hashtag
          // name => hashtag
          // match => #hashtag
        },
        onTapMention: (String name, String match) {
          // example : @mention
          // name => mention
          // match => #mention
        },
      ),
    );
  }
}

// HomeScreen Editor
class EditorTestPreviewUnfocused extends StatefulWidget {
  const EditorTestPreviewUnfocused({Key? key}) : super(key: key);

  @override
  _EditorTestPreviewUnfocusedState createState() =>
      _EditorTestPreviewUnfocusedState();
}

class _EditorTestPreviewUnfocusedState
    extends State<EditorTestPreviewUnfocused> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Markdown Editor"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              child: MarkdownFormField(
                controller: _controller,
                enableToolBar: true,
                emojiConvert: true,
                autoCloseAfterSelectEmoji: false,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(),
          ],
        ),
      ),
    );
  }
}
