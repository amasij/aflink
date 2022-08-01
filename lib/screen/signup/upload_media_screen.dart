import 'dart:io';

import 'package:aflink/custom_widgets/signup_appbar.dart';
import 'package:aflink/resources/resources.dart';
import 'package:aflink/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class UploadMediaScreen extends StatefulWidget {
  const UploadMediaScreen({Key? key}) : super(key: key);

  @override
  State<UploadMediaScreen> createState() => _UploadMediaScreenState();
}

class _UploadMediaScreenState extends State<UploadMediaScreen> {
  VideoPlayerController? videoPlayerController;
  final ImagePicker _picker = ImagePicker();
  Map<int, Map<String, dynamic>> imagePickerProperties = {
    0: {'FILE': null, 'LOADING': false},
    1: {'FILE': null, 'LOADING': false},
    2: {'FILE': null, 'LOADING': false},
    3: {'FILE': null, 'LOADING': false},
  };

  @override
  void dispose() {
    if (Utils.isNotNull(videoPlayerController)) {
      videoPlayerController?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: signUpAppBar(canGoBack: true, step: 6, context: context),
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: true,
        top: false,
        child: SingleChildScrollView(
          child: Container(
            padding: Resources.contentPadding,
            child: Column(
              children: [
                SizedBox(
                  height: Utils.getScreen(context).height * .03,
                ),
                Row(
                  children: const [
                    Expanded(
                      child: AutoSizeText(
                        'Upload media files to instantly activate account',
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .04,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        'Add at least 4 photos of yourself, 1 video and voice note. ',
                        textScaleFactor: 1.1,
                        style: TextStyle(color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .05,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        'Add photos',
                        textScaleFactor: 1.2,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: _createPhotoPicker(0),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: _createPhotoPicker(1),
                    ),
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: _createPhotoPicker(2),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: _createPhotoPicker(3),
                    ),
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .05,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        'Add Video',
                        textScaleFactor: 1.2,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .02,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _createVideoPicker(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createVideoPicker() {
    return GestureDetector(
      onTap: () async {
        if (Utils.isNotNull(videoPlayerController)) {
          return;
        }
        XFile? video = await _picker.pickVideo(
          source: ImageSource.gallery,
          maxDuration: const Duration(seconds: 30),
        );
        if (Utils.isNotNull(video)) {
          videoPlayerController =
              VideoPlayerController.file(File(video?.path ?? ''));
          await videoPlayerController?.initialize();
          videoPlayerController?.addListener(() {
            print('Listebing');
          });
        } else {
          if (Utils.isNotNull(videoPlayerController)) {
            await videoPlayerController?.dispose();
          }
          videoPlayerController = null;
        }
        setState(() {});
      },
      child: Utils.isNull(videoPlayerController)
          ? DottedBorder(
              color: Colors.grey[400]!,
              dashPattern: const [10, 4],
              strokeWidth: 1,
              child: Container(
                height: 400,
                width: 200,
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: const Center(
                  child: false
                      ? CircularProgressIndicator(
                          color: Resources.primaryColor,
                        )
                      : Icon(
                          Icons.add_circle,
                          color: Resources.primaryColor,
                          size: 40,
                        ),
                ),
              ),
            )
          : Stack(
              children: [
                SizedBox(
                  height: 400,
                  child: AspectRatio(
                    aspectRatio: videoPlayerController?.value.aspectRatio ?? 1,
                    child: VideoPlayer(videoPlayerController!),
                  ),
                ),
                Positioned(
                  top: 180,
                  left: 90,
                  child: GestureDetector(
                    onTap: () async {
                      if (videoPlayerController?.value.isPlaying ?? false) {
                        await videoPlayerController?.pause();
                      } else {
                        await videoPlayerController?.play();
                      }

                      setState(() {});
                    },
                    child: Icon(
                      videoPlayerController?.value.isPlaying ?? false
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                      size: 45,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      videoPlayerController?.dispose();
                      videoPlayerController = null;
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.cancel_outlined,
                      color: Colors.white,
                      size: 45,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _createPhotoPicker(int index) {
    return GestureDetector(
      onTap: () async {
        imagePickerProperties[index]!['LOADING'] = true;
        setState(() {});
        XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        if (Utils.isNotNull(image)) {
          imagePickerProperties[index]!['FILE'] = File(image?.path ?? '');
        }
        imagePickerProperties[index]!['LOADING'] = false;
        setState(() {});
      },
      child: Utils.isNull(imagePickerProperties[index]?['FILE'])
          ? DottedBorder(
              color: Colors.grey[400]!,
              dashPattern: const [10, 4],
              strokeWidth: 1,
              child: Container(
                height: 224,
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: Center(
                  child: (imagePickerProperties[index]?['LOADING'] as bool)
                      ? const CircularProgressIndicator(
                          color: Resources.primaryColor,
                        )
                      : const Icon(
                          Icons.add_circle,
                          color: Resources.primaryColor,
                          size: 40,
                        ),
                ),
              ),
            )
          : Stack(
              children: [
                Container(
                  height: 224,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(
                          imagePickerProperties[index]?['FILE'],
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      imagePickerProperties[index]?['FILE'] = null;
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.cancel_outlined,
                      color: Colors.white,
                      size: 45,
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
