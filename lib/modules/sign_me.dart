import 'dart:math';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/services/database_service.dart';
import 'package:flutterapp/services/logging_service.dart';
import 'package:signature/signature.dart';

class SignMe extends StatefulWidget {
  const SignMe({super.key});

  @override
  State<SignMe> createState() => _SignMeState();
}

class _SignMeState extends State<SignMe> {
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.red,
    exportBackgroundColor: Colors.transparent,
    exportPenColor: Colors.black,
    onDrawStart: () => log('onDrawStart called!'),
    onDrawEnd: () => log('onDrawEnd called!'),
  );

  @override
  void initState() {
    super.initState();
    _signatureController.addListener(() => log('Value changed'));
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(fit: FlexFit.tight, flex: 4, child: Signature(controller: _signatureController)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            //SHOW EXPORTED IMAGE IN NEW ROUTE
            IconButton(
              key: const Key('exportPNG'),
              icon: const Icon(Icons.image),
              color: Colors.blue,
              onPressed: () async {
                if (_signatureController.isEmpty) return;
                await _signatureController
                    .toPngBytes(height: 1000, width: 1000)
                    .then((value) async {
                  await DatabaseService.uploadImageToFBStorage(
                          '${Random().nextInt(1000).toString()}.png', value!)
                      .then((value) {
                    FlutterClipboard.copy(value).then((_) {
                      log('Copied to clipboard');
                      });
                  });
                });
              },
              tooltip: 'Export Image',
            ),
            IconButton(
              key: const Key('exportSVG'),
              icon: const Icon(Icons.share),
              color: Colors.blue,
              onPressed: () {},
              tooltip: 'Export SVG',
            ),
            IconButton(
              icon: const Icon(Icons.undo),
              color: Colors.blue,
              onPressed: () {
                setState(() => _signatureController.undo());
              },
              tooltip: 'Undo',
            ),
            IconButton(
              icon: const Icon(Icons.redo),
              color: Colors.blue,
              onPressed: () {
                setState(() => _signatureController.redo());
              },
              tooltip: 'Redo',
            ),
            //CLEAR CANVAS
            IconButton(
              key: const Key('clear'),
              icon: const Icon(Icons.clear),
              color: Colors.blue,
              onPressed: () {
                setState(() => _signatureController.clear());
              },
              tooltip: 'Clear',
            ),
            // STOP Edit
            IconButton(
              key: const Key('stop'),
              icon: Icon(
                _signatureController.disabled ? Icons.pause : Icons.play_arrow,
              ),
              color: Colors.blue,
              onPressed: () {
                setState(() => _signatureController.disabled = !_signatureController.disabled);
              },
              tooltip: _signatureController.disabled ? 'Pause' : 'Play',
            ),
          ],
        ),
      ],
    );
  }
}
