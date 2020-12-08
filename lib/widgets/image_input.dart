import 'dart:io';

/* Packages */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  const ImageInput({
    Key key,
    @required this.passFiletoForm,
  }) : super(key: key);

  final Function passFiletoForm;
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

  Future<void> _takePicture(bool _fromGalery) async {
    final _picker = ImagePicker();
    final PickedFile imageFile = await _picker.getImage(
      source: (_fromGalery) ? ImageSource.gallery : ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile != null) {
      setState(() {
        _storedImage = File(imageFile.path);
      });

      // find out first where we are allowed to save data in the hard drive
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      // final fileName = path.basename(imageFile.path); // the filename/basename of the taken image
      final fileName = path.basename(_storedImage.path); // the filename/basename of the taken image
      final savedImage = await _storedImage.copy('${appDir.path}/$fileName'); //copy the taken/chosen image to app directory
      widget.passFiletoForm(savedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  _takePicture(false);
                } else if (option == 'gallery') {
                  _takePicture(true);
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
    );
  }
}
