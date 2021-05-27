import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../common/button_with_border.dart';

class ImageSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ButtonWithBorder(
            text: 'SELECT IMAGE',
            borderColor: Theme.of(context).primaryColor,
            textColor: Theme.of(context).primaryColor,
            onPressed: () async {
              await _selectFile();
              () => print('da');
            },
          )
        ],
      ),
    );
  }

  _selectFile() async {
    final selectedFile = await FilePicker.platform
        .pickFiles(allowCompression: true, allowMultiple: false);
    if (selectedFile == null) print('nada');
    print(selectedFile?.names[0]);
    print(selectedFile?.files.first.path);
    print(selectedFile?.files.first.bytes);
    //print(selectedFile);
  }
}
