import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_appbar.dart';
import 'package:nub_book_sharing/src/presentation/view/pages/audio_to_text/text_to_audio.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';
import 'package:nub_book_sharing/src/utils/constants/m_custom_string_helper.dart';
import 'package:nub_book_sharing/src/utils/constants/m_dimensions.dart';
import 'package:nub_book_sharing/src/utils/constants/m_styles.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:screenshot/screenshot.dart';

class PdfViewerDetails extends StatefulWidget {
  final String link;
  const PdfViewerDetails({Key? key, required this.link}) : super(key: key);


  @override
  State<PdfViewerDetails> createState() => _PdfViewerDetailsState();
}

class _PdfViewerDetailsState extends State<PdfViewerDetails> {
  String urlPDFPath = "";
  bool exists = true;
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  bool loaded = false;

  Future<File> getFileFromUrl(String url, {name}) async {
    var fileName = 'nub_book';
    if (name != null) {
      fileName = name;
    }
    try {
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$fileName.pdf");
      debugPrint(dir.path);
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }


  ScreenshotController screenshotController = ScreenshotController();
  final textRecognizer = TextRecognizer();

  @override
  void initState() {
    getFileFromUrl(widget.link).then((value){
      setState(() {
        if (value.path.isNotEmpty) {
          urlPDFPath = value.path;
          loaded = true;
          exists = true;
        } else {
          exists = false;
        }
      });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.getBackgroundColor(),
      appBar: const CustomAppBar(title: "PDF Viewer",),
      body: Stack(
        children: [
          if(loaded)...[
            Screenshot(
              controller: screenshotController,
              child: PDFView(
                filePath: urlPDFPath,
                onPageChanged: (int? page, int? total) {
                  setState(() {
                    _currentPage = page ?? 0;
                    _totalPages = total ?? 0;
                  });
                },
                onViewCreated: (PDFViewController pdfViewController) {
                  setState(() {});
                },
              ),
            ),
            Positioned(
              bottom: 8.0,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Page ${_currentPage + 1} of $_totalPages',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ]else if(exists)...[
            Center(
              child: LoadingAnimationWidget.beat(
                color: MyColor.getPrimaryColor(),
                size: 50,
              ),
            ),
          ]else...[
             Center(
              child: Text(
                "PDF Not Available",
                style: robotoRegular.copyWith(color: MyColor.getTextColor(), fontSize: MySizes.fontSizeOverLarge),
              ),
            )
          ]
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          screenshotController.capture(delay: const Duration(milliseconds: 10)).then((capturedImage) async {
            if (capturedImage != null) {
              DialogHelper.showLoading();
              final directory = await getApplicationDocumentsDirectory();
              final imagePath = await File('${directory.path}/image.png').create();
              await imagePath.writeAsBytes(capturedImage);
              _scanImage(imagePath);
            }
          }).catchError((onError) {
            DialogHelper.hideLoading();
            print(onError);
          });
         /* DialogHelper.showLoading();
          await extractTextFromPDF(urlPDFPath, _currentPage).then((value){
            DialogHelper.hideLoading();
            if(value == "\n"){
              myToast('Something wrong to convert pdf');
            }else{
              Get.to(MyHomePage(title: value));
            }
          });
          //_pdfViewController.setPage(_currentPage + 1);*/
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }

  Future<void> _scanImage(File capturedImage) async {
    try {
      final inputImage = InputImage.fromFilePath(capturedImage.path);
      final recognizedText = await textRecognizer.processImage(inputImage);
      DialogHelper.hideLoading();
      Get.to(TextToAudio(inputText: recognizedText.text,));
    } catch (e) {
      DialogHelper.hideLoading();
      debugPrint(e.toString());
    }
  }

  Future<String> extractTextFromPDF(String pdfPath, int pageNumber) async {
    try {

      print('--------------:::::::::::::::$pdfPath');
      PDFDoc pdfDoc = await PDFDoc.fromFile(File(pdfPath));
      PDFPage page =  pdfDoc.pageAt(pageNumber+1);
      return await page.text;
    } catch (e) {
      debugPrint('Error: $e');
      return '';
    }
  }
  /*Future<void> _scanImage() async {
    final navigator = Navigator.of(context);

    try {


      final file = File(pictureFile.path);

      final inputImage = InputImage.fromFile(file);
      final recognizedText = await textRecognizer.processImage(inputImage);

      await navigator.push(
        MaterialPageRoute(
          builder: (BuildContext context) => TextToAudio(inputText: recognizedText.text),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred when scanning text'),
        ),
      );
    }
  }*/


}