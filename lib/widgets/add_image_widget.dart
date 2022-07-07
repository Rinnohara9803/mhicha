import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mhicha/utilities/themes.dart';
import 'package:path/path.dart' as path;

class AddImageWidget extends StatefulWidget {
  final Function getUserProfilePhoto;
  const AddImageWidget({required this.getUserProfilePhoto, Key? key})
      : super(key: key);

  @override
  State<AddImageWidget> createState() => _AddImageWidgetState();
}

class _AddImageWidgetState extends State<AddImageWidget> {
  File? _selectedImage;
  Future<void> _getUserPicture(ImageSource imageSource) async {
    ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(
      source: imageSource,
    );
    if (image == null) {
      return;
    }
    final _imageName = path.basename(image.path);

    setState(() {
      _selectedImage = File(image.path);
    });

    widget.getUserProfilePhoto(
      _selectedImage,
      _imageName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: MediaQuery.of(context).devicePixelRatio * 24,
          child: CircleAvatar(
            radius: MediaQuery.of(context).devicePixelRatio * 23,
            backgroundImage: const AssetImage(
              'images/profile_avatar.png',
            ),
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).devicePixelRatio,
          right: MediaQuery.of(context).devicePixelRatio,
          child: InkWell(
            onTap: () {
              // showDialog(
              //   context: context,
              //   builder: (context) {
              //     return Dialog(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //       elevation: 10,
              //       backgroundColor: Colors.white,
              //       child: Container(
              //         height: MediaQuery.of(context).size.height * 0.18,
              //         padding: const EdgeInsets.symmetric(
              //           vertical: 20,
              //           horizontal: 10,
              //         ),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Expanded(
              //               child: InkWell(
              //                 onTap: () async {
              //                   await _getUserPicture(
              //                     ImageSource.camera,
              //                   ).then((value) {
              //                     if (_selectedImage != null) {
              //                       Navigator.of(context).pop();
              //                     }
              //                   });
              //                 },
              //                 child: Container(
              //                   padding: const EdgeInsets.symmetric(
              //                       horizontal: 10, vertical: 15),
              //                   decoration: BoxDecoration(
              //                     color: const Color.fromRGBO(
              //                       239,
              //                       236,
              //                       236,
              //                       1,
              //                     ),
              //                     borderRadius: BorderRadius.circular(5),
              //                   ),
              //                   child: Row(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: const [
              //                       Icon(
              //                         Icons.camera_alt_outlined,
              //                         size: 15,
              //                         color: Color.fromRGBO(81, 81, 81, 1),
              //                       ),
              //                       SizedBox(
              //                         width: 5,
              //                       ),
              //                       Text(
              //                         "Open Camera",
              //                         style: TextStyle(
              //                           color: Color.fromRGBO(81, 81, 81, 1),
              //                           fontFamily: "circularstd-book",
              //                           fontWeight: FontWeight.w400,
              //                           fontSize: 14,
              //                         ),
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             const SizedBox(
              //               width: 10,
              //             ),
              //             Expanded(
              //               child: InkWell(
              //                 onTap: () async {
              //                   await _getUserPicture(
              //                     ImageSource.gallery,
              //                   ).then((value) {
              //                     if (_selectedImage != null) {
              //                       Navigator.of(context).pop();
              //                     }
              //                   });
              //                 },
              //                 child: Container(
              //                   padding: const EdgeInsets.symmetric(
              //                     horizontal: 10,
              //                     vertical: 15,
              //                   ),
              //                   decoration: BoxDecoration(
              //                     color: Colors.blueGrey,
              //                     borderRadius: BorderRadius.circular(5),
              //                   ),
              //                   child: Row(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: const [
              //                       Icon(
              //                         Icons.upload_outlined,
              //                         size: 15,
              //                         color: Colors.white,
              //                       ),
              //                       SizedBox(
              //                         width: 5,
              //                       ),
              //                       Text(
              //                         "Upload",
              //                         style: TextStyle(
              //                           color: Colors.white,
              //                           fontFamily: "circularstd-book",
              //                           fontWeight: FontWeight.w400,
              //                           fontSize: 14,
              //                         ),
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // );
            },
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: ThemeClass.primaryColor,
                  width: 0.5,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: ThemeClass.primaryColor,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
