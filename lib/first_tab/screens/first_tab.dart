import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FirstTab extends StatefulWidget {
  const FirstTab({Key? key}) : super(key: key);

  @override
  _FirstTabState createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  File? photoFile;
  late String? photoPath;
  bool alreadyTaken = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      alreadyTaken = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('FIRST TAB'),
        flexibleSpace: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xfff86d66),
                Color(0xffe0702a),
              ],
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xfff86d66),
                      Color(0xffe0702a),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ElevatedButton(
                  child: const Text('TOMAR FOTO'),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    getPhoto();
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: size.height * 0.6,
                width: size.width,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 0,
                      blurRadius: 3,
                    ),
                  ],
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: photoFile == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          alreadyTaken
                              ? const Icon(
                                  Icons.sentiment_satisfied_rounded,
                                  color: Colors.black,
                                  size: 50,
                                )
                              : const Icon(
                                  Icons.sentiment_dissatisfied_rounded,
                                  color: Colors.black,
                                  size: 50,
                                ),
                          const SizedBox(height: 20),
                          alreadyTaken
                              ? const Text(
                                  'Tomar\notra foto',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : const Text(
                                  'No has tomado\nninguna foto',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ],
                      )
                    : Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                              photoFile!,
                              height: size.height * 0.65,
                              width: size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: size.width / 3,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xfff86d66),
                                        Color(0xffe0702a),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ElevatedButton(
                                    child: const Text('DESCARTAR'),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      primary: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      onPrimary: Colors.white,
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        photoFile = null;
                                        alreadyTaken = true;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  width: size.width / 3,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xfff86d66),
                                        Color(0xffe0702a),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ElevatedButton(
                                    child: const Text('GUARDAR'),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      primary: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      onPrimary: Colors.white,
                                    ),
                                    onPressed: () async {
                                      if (photoFile != null) {
                                        await saveImage();
                                        setState(() {
                                          photoFile = null;
                                          alreadyTaken = true;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getPhoto() async {
    final picture = await ImagePicker().pickImage(source: ImageSource.camera);
    var directory = await getExternalStorageDirectory();
    if (picture != null) {
      setState(() {
        photoFile = File(picture.path);
        photoPath = directory!.path;
      });
    } else {
      return;
    }
  }

  Future saveImage() async {
    try {
      if (await _requestPermission(Permission.storage)) {
        var directory = await getExternalStorageDirectory();
        String time = DateTime.now()
            .toString()
            .replaceAll('-', '')
            .replaceAll(' ', '')
            .replaceAll(':', '');
        String newPath = '';
        List<String> folders = directory!.path.split('/');
        for (int x = 1; x < folders.length; x++) {
          String folder = folders[x];
          if (folder != 'Android') {
            newPath += '/' + folder;
          } else {
            break;
          }
        }
        newPath = newPath + '/DCIM';
        directory = Directory(newPath);
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        if (await directory.exists()) {
          setState(() {
            photoPath = directory!.path;
          });
          await photoFile!.copy('$photoPath/img_$time.jpg');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.grey,
              content: Text(
                'Se ha guardado la imagen',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }
      } else {
        return;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey,
          content: Text(
            e.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
