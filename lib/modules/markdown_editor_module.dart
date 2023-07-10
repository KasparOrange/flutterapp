// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:html' as html;
import 'dart:io' as io;
import 'dart:js_interop';
import 'dart:math';
import 'dart:typed_data';

import 'package:mime_type/mime_type.dart';
import 'package:path/path.dart' as path;
import 'package:cross_file/cross_file.dart';
import 'package:flutterapp/models/image_model.dart';
import 'package:flutterapp/services/database_service.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';
import 'package:markdown/markdown.dart' as markdown;
import 'package:flutterapp/services/keyboard_service.dart';
import 'package:flutterapp/services/logging_service.dart';
import 'package:flutterapp/services/theme_service.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'package:provider/provider.dart';
import 'package:simple_markdown_editor/simple_markdown_editor.dart';

class MarkdownEditorModule extends StatefulWidget {
  const MarkdownEditorModule({super.key});

  @override
  State<MarkdownEditorModule> createState() => _MarkdownEditorModuleState();
}

class _MarkdownEditorModuleState extends State<MarkdownEditorModule> with TickerProviderStateMixin {
  late final TextEditingController _textEditingController;
  late final TabController _tabController;
  String text = '';

  ImageModel? image;
  Uint8List? imageBytes;
  String? imageName;

  html.File? imageFile;

  String? imagePath;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        if (_tabController.index == 1) {
          _textEditingController.text = text;
        }
      });
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _textEditingController.dispose();
  }

  final String exampleMD = '''
# H1
*BOLD* \n
_Italic_

''';

  Future selectImageForUpload() async {
    return await ImagePickerWeb.getImageAsBytes().then((value) {
      setState(() {
        imageBytes = value;
      });

      if (value == null) return Future.error('Error while selecting an image!');

      return Future.value('Successful seleced an image!');
    }).onError((e, __) => log(e.toString()));

    // var result = await ImagePickerWeb.getImageAsBytes();

    // if (result == null) return Future.error('Error while selecting an image!');

    // setState(() {
    //   imageBytes = Uint8List(result.length);
    //   imageBytes = result;
    // });

    // return Future.value('Successful seleced and image!');
  }

  Future pickImageAndUpload() async {
    MediaInfo mediaInfo;
    await ImagePickerWeb.getImageInfo.then((value) async {
      if (value == null) {
        log('Value was null!');
        return;
      } else {
        log('Value looks like this: $value');
        mediaInfo = value;
        await DatabaseService.uploadImageToFBStorage(mediaInfo.fileName!, mediaInfo.data!)
            .then((value) => log(value.toString()))
            .catchError((error) => log(error.toString()));
      }
    }).catchError((e) {
      log('ERROR: $e');
    });
  }

  Future<String> getImagePath() async {
    final imageInfo = await ImagePickerWeb.getImageInfo;
    if (imageInfo == null) return Future.error('Error getting the image info!');
    if (imageInfo.fileName == null) return Future.error('Error getting the image name!');

    final mimeType = mime(path.basename(imageInfo.fileName!));

    // if (imageInfo.data == null) return Future.error('Error! Image data was null!');
    // html.File imageFile = html.File(imageInfo.data!, imageInfo.fileName!, {'type': mimeType});
    return imageInfo.fileName!;
    // return mimeType!;
  }

  void pickImageAndSaveAsBytes() async {
    await ImagePickerWeb.getImageAsBytes().then((value) {
      if (value == null) {
        log('Value was null!');
        return;
      } else {
        log('Value looks like this: $value');
      }
      // DatabaseService.uploadImageToDB();
      // DatabaseService.uploadImage(value);

      setState(() {
        imageBytes = Uint8List(value.length);
        log('imageBytes lenght: ${imageBytes!.length}');
        log('imageBytes lenghtInBytes: ${imageBytes!.lengthInBytes}');
        imageBytes = value;
        log('imageBytes looks like this: $imageBytes');
      });
    }).catchError((e) {
      log('ERROR: $e');
    }).whenComplete(() => null);
  }

  void pickImageAndGetPath() async {
    await ImagePickerWeb.getImageAsBytes().then((value) {
      setState(() {});
    }).catchError((e) {
      log(e);
    });
  }

  Uint8List convertToUint8List(List list) => Uint8List.fromList(List<int>.from(list));

  @override
  Widget build(BuildContext context) {
    final keyboardService = Provider.of<KeyboardService>(context);
    return Center(
      child: Container(
          height: 1000,
          width: 1000,
          margin: const EdgeInsets.all(40),
          decoration: BoxDecoration(
              border: Border.all(width: 10, style: BorderStyle.solid),
              gradient: const LinearGradient(colors: [Colors.blue, Colors.yellow])),
          child: Column(children: [
            TabBar(controller: _tabController, tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.abc)),
            ]),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                Container(
                  color: Colors.green,
                  child: TextField(
                    controller: _textEditingController,
                    onChanged: (value) {
                      setState(() {
                        text = value;
                      });
                    },
                    onSubmitted: (value) {
                      setState(() {
                        text = value;
                      });
                      _tabController.animateTo(1);
                    },
                    autofocus: true,
                    expands: true,
                    minLines: null,
                    maxLines: null,
                  ),
                ),
                Container(
                  color: Colors.red,
                  child: Markdown(
                    data: text,
                    extensionSet: markdown.ExtensionSet.gitHubFlavored,
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Container(
                          color: Colors.red,
                          child: TextButton(
                            onPressed: () async {
                              await selectImageForUpload().then((value) {
                                if (value != null) return log(value);
                              }).onError((error, _) => log(error.toString()));
                              // DatabaseService.fetchTest().then((value) {
                              //   log(value);
                              //   setState(() {
                              //     imageBytes = convertToUint8List(value);
                              //   });
                              // });
                              // await ImagePickerPlugin().pickMultiImage().then((value) {
                              //   log((value?[0] as XFile).path);
                              // });
                            },
                            child: Text('DOWNLOAD'),
                          )),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 3,
                      child: Builder(builder: (context) {
                        if (imageBytes == null) {
                          return Container(
                              color: Colors.red,
                              child: TextButton(
                                onPressed: () {
                                  // pickImageAndSaveAsBytes();
                                  // getImagePath().then((value) => log(value));
                                  pickImageAndUpload();
                                },
                                child: Text('UPLOAD'),
                              ));
                        } else {
                          return Column(children: [
                            Flexible(fit: FlexFit.tight, flex: 3, child: Image.memory(imageBytes!)),
                            Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: TextFormField(onChanged: (value) {
                                  setState(() => imageName = value);
                                })),
                            Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: ElevatedButton(
                                  child: Text('Upload Image with Name'),
                                  onPressed: () {
                                    setState(() async {
                                      image = ImageModel(name: imageName!, bytes: imageBytes!);
                                      await DatabaseService.uploadImageToDB(image!).then((value) {
                                        log('Uploaded $value');
                                      }).onError((error, _) {
                                        if (error != null) log(error);
                                      });
                                    });
                                  },
                                ))
                          ]);
                        }
                      }),
                    )
                  ],
                ),
              ]),
            )
          ])),
    );
  }
}
// NOTE: Markdown Form Field
// Container(
//           height: 200,
//           child: MarkdownFormField(
//             controller: _controller,
//             focusNode: keyboardService
//                 .textInputFocusNode, // NOTE: This node tells the KeyboardService to not act on hotkeys when it has focus.
//             enableToolBar: true,
//             emojiConvert: true,
//             autoCloseAfterSelectEmoji: false,
//           ) )])

// NOTE: This is the Markdown Toolbar
// MarkdownToolbar(onPreviewChanged: () {},
// controller: _controller,
// focusNode: keyboardService.textInputFocusNode,
// isEditorFocused: (hasFocus) {})

//           // NOTE: This just breaks outright. Validation errors. Not null-safety compatible?
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

//           // NOTE: This does not throw any errors, but its buttons don't do anything jet. Focus? Container size?

// NOTE: That's the original example code from simple_markdown_editor. Shows the same "Loos focus when click toolbar" behavior as my implementation.
// import 'package:flutter/material.dart';
// import 'package:simple_markdown_editor/simple_markdown_editor.dart';

// class MarkdownEditorModule extends StatelessWidget {
//   const MarkdownEditorModule({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Home Screen"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             MaterialButton(
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (_) => const EditorScreen()));
//               },
//               color: Colors.blue,
//               child: const Text(
//                 "Editor Screen 1",
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             MaterialButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (_) => const EditorTestPreviewUnfocused()));
//               },
//               color: Colors.blue,
//               child: const Text(
//                 "Editor Screen 2",
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // HomeScreen Editor
// class EditorScreen extends StatefulWidget {
//   const EditorScreen({Key? key}) : super(key: key);

//   @override
//   _EditorScreenState createState() => _EditorScreenState();
// }

// class _EditorScreenState extends State<EditorScreen> {
//   final TextEditingController _controller = TextEditingController();

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Markdown Editor"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => SecondScreen(
//                     data: _controller.text,
//                   ),
//                 ),
//               );
//             },
//             icon: const Icon(Icons.view_compact),
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: MarkdownFormField(
//                 controller: _controller,
//                 enableToolBar: true,
//                 emojiConvert: true,
//                 autoCloseAfterSelectEmoji: false,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SecondScreen extends StatelessWidget {
//   const SecondScreen({Key? key, required this.data}) : super(key: key);

//   final String data;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Markdown Parse"),
//       ),
//       body: MarkdownParse(
//         data: data,
//         onTapHastag: (String name, String match) {
//           // example : #hashtag
//           // name => hashtag
//           // match => #hashtag
//         },
//         onTapMention: (String name, String match) {
//           // example : @mention
//           // name => mention
//           // match => #mention
//         },
//       ),
//     );
//   }
// }

// // HomeScreen Editor
// class EditorTestPreviewUnfocused extends StatefulWidget {
//   const EditorTestPreviewUnfocused({Key? key}) : super(key: key);

//   @override
//   _EditorTestPreviewUnfocusedState createState() =>
//       _EditorTestPreviewUnfocusedState();
// }

// class _EditorTestPreviewUnfocusedState
//     extends State<EditorTestPreviewUnfocused> {
//   final TextEditingController _controller = TextEditingController();

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Markdown Editor"),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               height: 300,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: MarkdownFormField(
//                 controller: _controller,
//                 enableToolBar: true,
//                 emojiConvert: true,
//                 autoCloseAfterSelectEmoji: false,
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextFormField(),
//           ],
//         ),
//       ),
//     );
//   }
// }
