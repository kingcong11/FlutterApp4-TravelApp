import 'dart:io';

/* Packages */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({
    Key key,
  }) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  /* Properties */
  File _storedImage;

  /* Methods */
  Future<String> _showOptions() async {
    try {
      var option = await showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: Text('Choose from Photos'),
              onPressed: () {
                Navigator.of(context).pop('gallery');
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Use Camera'),
              onPressed: () {
                Navigator.of(context).pop('camera');
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      );
      return option;
    } catch (e) {
      // do something
    }
    return null;
  }

  Future<void> _takePicture() async {
    final _picker = ImagePicker();
    final PickedFile imageFile = await _picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile != null) {
      setState(() {
        _storedImage = File(imageFile.path);
      });
    }
  }

  Future<void> _choosePicture() async {
    final _picker = ImagePicker();
    final PickedFile imageFile = await _picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (imageFile != null) {
      setState(() {
        _storedImage = File(imageFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120,
          width: 120,
          alignment: Alignment.center,
          child: (_storedImage == null)
              ? GestureDetector(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Icon(
                      Boxicons.bx_image_add,
                      size: 35,
                      color: Colors.grey[700],
                    ),
                  ),
                  onTap: () async {
                    var option = await _showOptions();
                    if (option == 'camera') {
                      _takePicture();
                    } else if (option == 'gallery') {
                      _choosePicture();
                    } else {
                      return;
                    }
                  },
                )
              : Stack(
                  alignment: Alignment.center,
                  overflow: Overflow.visible,
                  children: [
                    Image.file(
                      _storedImage,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      isAntiAlias: true,
                    ),
                    Positioned(
                      bottom: -8,
                      right: -8,
                      child: GestureDetector(
                        child: Container(
                          height: 35,
                          width: 35,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(bottom: 3, right: 1),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(17.5),
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: Icon(
                            FontAwesomeIcons.camera,
                            size: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                        onTap: _showOptions,
                      ),
                    ),
                  ],
                ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Say something about this post.',
                hintStyle: TextStyle(fontSize: 14),
                contentPadding: const EdgeInsets.all(5.0),
              ),
              style: TextStyle(fontSize: 14),
              keyboardType: TextInputType.text,
              maxLines: 6,
              maxLength: 150,
              validator: (val) {
                if (val.isEmpty) {
                  return 'Please enter some text.';
                }
                return null;
              },
            ),
          ),
        )
      ],
    );
  }
}
