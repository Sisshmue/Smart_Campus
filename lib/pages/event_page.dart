import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_campus_mobile_app/provider/event_button_provider.dart';

class Event extends StatefulWidget {
  final String name;
  final String about;
  final String detail;
  final bool isDone;
  final String img;
  final String img2;
  final bool hasButton;

  Event({
    required this.name,
    required this.about,
    required this.detail,
    required this.isDone,
    required this.img,
    required this.img2,
    required this.hasButton,
  });

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  @override
  Widget build(BuildContext context) {
    var eventButtonProvider = Provider.of<EventButtonProvider>(context);
    final bool isPressed = eventButtonProvider.isButtonPressed(widget.name);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Events and News",
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xFF7A060D),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.about,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF7A060D),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(widget.detail),
              SizedBox(
                height: 30,
              ),
              // Row(
              //   children: [
              //     widget.img.isNotEmpty
              //         ? Expanded(
              //             child: Image.network(
              //               widget.img,
              //               height: 200, // Adjust size as needed
              //               width: double.infinity,
              //               fit: BoxFit.cover,
              //             ),
              //           )
              //         : const SizedBox.shrink(),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     widget.img2.isNotEmpty
              //         ? Expanded(
              //             child: Image.network(
              //               widget.img2,
              //               height: 200, // Adjust size as needed
              //               width: double.infinity,
              //               fit: BoxFit.cover,
              //             ),
              //           )
              //         : const SizedBox.shrink(),
              //   ],
              // ),
              Showpopup(img: widget.img, img2: widget.img2),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: widget.hasButton == true
                    ? TextButton(
                        onPressed: widget.isDone == true || isPressed == true
                            ? null
                            : () {
                                eventButtonProvider.pressButton(widget.name);
                              },
                        child: Text(
                          'Join',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              widget.isDone == true || isPressed == true
                                  ? MaterialStateProperty.all(Colors.grey)
                                  : MaterialStateProperty.all(
                                      const Color(0xFF7A060D)),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              widget.isDone == true
                  ? const Text(
                      "The event was already Done!",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    )
                  : isPressed == true
                      ? const Text("You Have already registered for this event",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                          ))
                      : const Text(''),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Showpopup extends StatelessWidget {
  final String img;
  final String img2;

  Showpopup({required this.img, required this.img2});

  void showImgDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        img.isNotEmpty
            ? Expanded(
                child: GestureDetector(
                  onTap: () => showImgDialog(context, img),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Image.network(
                      img,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        img2.isNotEmpty
            ? Expanded(
                child: GestureDetector(
                  onTap: () => showImgDialog(context, img2),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Image.network(
                      img2,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
