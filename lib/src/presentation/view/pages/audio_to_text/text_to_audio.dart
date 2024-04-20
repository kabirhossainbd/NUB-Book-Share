import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_appbar.dart';
import 'package:nub_book_sharing/src/presentation/view/component/m_toast.dart';
import 'package:nub_book_sharing/src/utils/constants/m_colors.dart';

class TextToAudio extends StatefulWidget {
  final String inputText;
  const TextToAudio({Key? key, this.inputText = ''}) : super(key: key);

  @override
  State<TextToAudio> createState() => _TextToAudioState();
}

class _TextToAudioState extends State<TextToAudio> {
  final ScrollController _controller = ScrollController();
  final double _scrollSpeed = .9;
  bool isPlaying = false;
  bool isScrollingStop = false;
  Timer? _timer;

  FlutterTts flutterTts = FlutterTts();
  
  Map? _currentVoiceData;
  List<Map> voices = [];


 // String inputText = "Where does it come from? Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, Lorem ipsum dolor sit amet.., comes from a line in section 1.10.32."
 //  "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. END END END";

 int? _currentWordStart, _currentWordEnd;


  @override
  void initState() {
    initTTS();
    super.initState();
  }

  initTTS(){
    flutterTts.setProgressHandler((text, start, end, word) async{
      setState(() {
        _currentWordStart = start;
        _currentWordEnd = end;
      });
    });
    flutterTts.getVoices.then((data){
      try{
        voices =  List<Map>.from(data);
        voices = voices.where((voice) => voice["name"].toString().contains("en")).toList();
        setState(() {
          _currentVoiceData = voices.first;
        });
        setVoice(_currentVoiceData!);
      }catch(e){
        debugPrint(e.toString());
      }
    });


    flutterTts.setStartHandler(() {
      setState(() {
        isPlaying = true;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
        isScrollingStop = false;
      });
    });

    flutterTts.setErrorHandler((err) {
      setState(() {
       myToast(err.toString());
        isPlaying = false;
      });
    });
    _speak(widget.inputText);
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if(_controller.position.pixels >= _controller.position.maxScrollExtent){
        _timer?.cancel();
        setState(() {
          isScrollingStop = true;
        });
      }else{
        _controller.animateTo(
          _controller.position.pixels + _scrollSpeed,
          duration: const Duration(milliseconds: 90),
          curve: Curves.linear,
        );
      }
    });
  }

  void _stopAutoScroll() {
    _timer?.cancel();
    setState(() {
      isScrollingStop = true;
    });
  }

  void setVoice(Map voice){
    flutterTts.setVoice({"name" : voice["name"], "local" : voice['local']});
  }

  Future _speak(String? text) async {
    if (text != null && text.isNotEmpty) {
     if(_controller.hasClients){
       _controller.jumpTo(0);
     }
      _startAutoScroll();
      var result = await flutterTts.speak(text);
      if (result == 1) {
        setState(() {
          isPlaying = true;
        });
      }
    }
  }

  Future _stop() async {
    _stopAutoScroll();
    var result = await flutterTts.stop();
    if (result == 1) {
      setState(() {
        isPlaying = false;
      });
    }
  }

  @override
  void dispose() {
    flutterTts.stop();
    _timer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.getBackgroundColor(),
      appBar: const CustomAppBar(title: 'Audio Reading',),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                controller: _controller,
                physics: (isScrollingStop || isPlaying) ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
                children: [
                 // _spekerSelector(),
                 // Text(widget.inputText.length.toString()),
                  RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: Colors.black
                        ),
                        children: [
                          TextSpan(
                            text: widget.inputText.substring(0, _currentWordStart),
                          ),
                          if(_currentWordStart != null)...[
                            TextSpan(
                                text: widget.inputText.substring(_currentWordStart!, _currentWordEnd),
                              style: const TextStyle(
                                color: Colors.red,
                               // backgroundColor: Colors.red
                              )
                            )
                          ],

                          if(_currentWordEnd != null)...[
                            TextSpan(
                              style: const TextStyle(color: Colors.black38),
                                text: widget.inputText.substring(_currentWordEnd!),
                            )
                          ]
                        ]
                      ))
                ],
              ),
            ),

            Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min,
              children: [
                playButton(context)
              ],
            )
          ],
        ),
      ),
    );
  }


  Widget playButton(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding:
          const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
          margin: const EdgeInsets.only(
              top: 30, left: 30.0, right: 30.0, bottom: 20.0),
          child: TextButton(
            onPressed: () {
              //fetch another image
              setState(() {
                //speechSettings1();
                isPlaying ? _stop() : _speak(widget.inputText);
              });
            },
            child: isPlaying
                ? const Icon(
              Icons.stop,
              size: 60,
              color: Colors.red,
            )
                : const Icon(
              Icons.play_arrow,
              size: 60,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }
}