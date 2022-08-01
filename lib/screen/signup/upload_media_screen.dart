import 'dart:io';

import 'package:aflink/custom_widgets/app_button.dart';
import 'package:aflink/custom_widgets/signup_appbar.dart';
import 'package:aflink/resources/resources.dart';
import 'package:aflink/routes/routes.dart';
import 'package:aflink/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:logger/logger.dart' show Level;

class UploadMediaScreen extends StatefulWidget {
  const UploadMediaScreen({Key? key}) : super(key: key);

  @override
  State<UploadMediaScreen> createState() => _UploadMediaScreenState();
}

class _UploadMediaScreenState extends State<UploadMediaScreen> {
  bool isRecording = false;
  bool audioPlaying = false;
  String? audioRecordingPath;
  FlutterSoundPlayer? soundPlayer;
  FlutterSoundRecorder? recorder;
  VideoPlayerController? videoPlayerController;
  final ImagePicker _picker = ImagePicker();
  Map<int, Map<String, dynamic>> imagePickerProperties = {
    0: {'FILE': null, 'LOADING': false},
    1: {'FILE': null, 'LOADING': false},
    2: {'FILE': null, 'LOADING': false},
    3: {'FILE': null, 'LOADING': false},
  };

  @override
  void initState() {
    initializeAudioPlayer();
    initializeAudioRecorder();
    super.initState();
  }

  @override
  void dispose() {
    if (Utils.isNotNull(videoPlayerController)) {
      videoPlayerController?.dispose();
      videoPlayerController = null;
    }
    if (Utils.isNotNull(recorder)) {
      recorder?.closeRecorder();
      recorder = null;
    }
    if (Utils.isNotNull(soundPlayer)) {
      soundPlayer?.closePlayer();
      soundPlayer = null;
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
                        'Add at least 4 photos of yourself, 1 video and 1 voice note. ',
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
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .05,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        'Add Audio',
                        textScaleFactor: 1.2,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        'Hold button to record',
                        // textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .01,
                ),
                Row(
                  children: [
                    Expanded(
                      child: DottedBorder(
                          color: Colors.grey[400]!,
                          dashPattern: const [10, 4],
                          strokeWidth: 1,
                          child: _createAudioPlayer()),
                    )
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        isRecording = false;
                        setState(() {});
                      },
                      onDoubleTap: () {
                        isRecording = false;
                        setState(() {});
                      },
                      onLongPressDown: (details) async {
                        isRecording = true;
                        audioPlaying = false;
                        setState(() {});
                        await recorder?.stopRecorder();
                        await recorder?.startRecorder(
                          toFile: 'recording',
                        );

                      },
                      onLongPressEnd: (details) async {
                        isRecording = false;
                        setState(() {});
                        String? path = await recorder?.stopRecorder();
                        audioRecordingPath = path ?? '';
                        setState(() {});
                      },
                      child:
                          // isRecording
                          //     ? Lottie.asset('assets/animation/recording.json',
                          //         repeat: true, height: 120)
                          //     :
                          const CircleAvatar(
                        radius: 35,
                        backgroundColor: Resources.primaryColor,
                        child: Icon(
                          Icons.mic,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Utils.getScreen(context).height * .1,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.activateSneakyLinkScreen);
                        },
                        enabled: true,
                        label: 'CONTINUE',
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createAudioPlayer() {
    if (isRecording) {
      return Row(
        children: [
          Expanded(
            flex: 6,
            child: Lottie.asset('assets/animation/wave-grey.json',
                repeat: true, height: 100, animate: true),
          ),
        ],
      );
    }
    if ((!isRecording) && Utils.isNotNull(audioRecordingPath)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                if (audioPlaying) {
                  audioPlaying = false;
                  setState(() {});
                  await soundPlayer?.pausePlayer();
                } else {
                  audioPlaying = true;
                  setState(() {});
                  if (soundPlayer?.isPaused ?? false) {
                    await soundPlayer?.resumePlayer();
                  } else {
                    await soundPlayer?.startPlayer(
                      fromURI: audioRecordingPath,
                      whenFinished: () {
                        audioPlaying = false;
                        setState(() {});
                      },
                    );
                  }
                }
              },
              child: Icon(
                audioPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_fill,
                color: Resources.primaryColor,
                size: 50,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Lottie.asset(
              'assets/animation/wave.json',
              repeat: true,
              height: 100,
              animate: audioPlaying,
            ),
          ),
        ],
      );
    }
    return const SizedBox(
      height: 100,
      child: Center(
        child: Text(
          'No Audio',
          style: TextStyle(color: Colors.grey),
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

  void initializeAudioRecorder() async {
    recorder =
        await FlutterSoundRecorder(logLevel: Level.nothing).openRecorder();
  }

  void initializeAudioPlayer() async {
    soundPlayer =
        await FlutterSoundPlayer(logLevel: Level.nothing).openPlayer();
  }
}
