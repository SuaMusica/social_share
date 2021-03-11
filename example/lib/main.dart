import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';
import 'package:path/path.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Screenshot(
          controller: screenshotController,
          child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Running on: $_platformVersion\n',
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final _picker = ImagePicker();

                    PickedFile? file =
                        await _picker.getImage(source: ImageSource.gallery);
                    SocialShare.shareInstagramStory(file!.path, "#ffffff",
                            "#000000", "https://deep-link-url")
                        .then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share On Instagram Story"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final directory = await getTemporaryDirectory();
                    final fileName =
                        DateTime.now().microsecondsSinceEpoch.toString();

                    await screenshotController.captureAndSave(
                      directory.path,
                      pixelRatio: 2.0,
                      fileName: fileName,
                    );
                    final imgPath = join(directory.path, "shareImg.png");

                    SocialShare.shareInstagramStorywithBackground(imgPath,
                            "#ffffff", "#000000", "https://deep-link-url",
                            backgroundImagePath: imgPath)
                        .then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share On Instagram Story with background"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final directory = await getTemporaryDirectory();
                    final fileName =
                        DateTime.now().microsecondsSinceEpoch.toString();

                    await screenshotController.captureAndSave(
                      directory.path,
                      pixelRatio: 2.0,
                      fileName: fileName,
                    );
                    final imgPath = join(directory.path, "shareImg.png");

                    Platform.isAndroid
                        ? SocialShare.shareFacebookStory(imgPath, "#ffffff",
                                "#000000", "https://google.com",
                                appId: "xxxxxxxxxxxxx")
                            .then((data) {
                            print(data);
                          })
                        : SocialShare.shareFacebookStory(imgPath, "#ffffff",
                                "#000000", "https://google.com")
                            .then((data) {
                            print(data);
                          });
                  },
                  child: Text("Share On Facebook Story"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    SocialShare.copyToClipboard(
                      "This is Social Share plugin",
                    ).then((data) {
                      print(data);
                    });
                  },
                  child: Text("Copy to clipboard"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    SocialShare.shareTwitter(
                            "This is Social Share twitter example",
                            hashtags: ["hello", "world", "foo", "bar"],
                            url: "https://google.com/#/hello",
                            trailingText: "\nhello")
                        .then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share on twitter"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    SocialShare.shareSms("This is Social Share Sms example",
                            url: "\nhttps://google.com/",
                            trailingText: "\nhello")
                        .then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share on Sms"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final directory = await getTemporaryDirectory();
                    final fileName =
                        DateTime.now().microsecondsSinceEpoch.toString();

                    await screenshotController.captureAndSave(
                      directory.path,
                      pixelRatio: 2.0,
                      fileName: fileName,
                    );
                    final imgPath = join(directory.path, "shareImg.png");

                    SocialShare.shareOptions("Hello world", imagePath: imgPath)
                        .then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share Options"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    SocialShare.shareWhatsapp(
                            "Hello World \n https://google.com")
                        .then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share on Whatsapp"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    SocialShare.shareTelegram(
                            "Hello World \n https://google.com")
                        .then((data) {
                      print(data);
                    });
                  },
                  child: Text("Share on Telegram"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    SocialShare.checkInstalledAppsForShare().then((data) {
                      print(data.toString());
                    });
                  },
                  child: Text("Get all Apps"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
