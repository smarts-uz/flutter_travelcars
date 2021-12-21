import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Announcement #10101",
          style: TextStyle(
              color: Colors.white,
              fontSize: 25
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.95,
              margin: EdgeInsets.all(15),
              child: Image.asset("assets/images/lacetti.png", fit: BoxFit.cover,),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 20),
              child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 19,
                      height: 1.7,
                      color: Colors.black
                    ),
                    children: [
                      TextSpan(text: "From: ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "Tashkent\n"),
                      TextSpan(text: "To: ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "Samarkand\n"),
                      TextSpan(text: "Date: ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "21.09.2021\n"),
                      TextSpan(text: "Time: ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "10:00\n"),
                      TextSpan(text: "Car type: ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "Chevrolet Lacetti\n"),
                      TextSpan(text: "Quantity (without cargo): ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "4\n"),
                      TextSpan(text: "Quantity (with cargo): ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "3\n"),
                      TextSpan(text: "Contacts of driver\n", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "\t\tName: ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "Sobirov Ibrohim\n"),
                      TextSpan(text: "\t\tPhone: ", style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "+998 94 659 08 50\n"),
                      TextSpan(text: "Comment:", style: TextStyle(fontWeight: FontWeight.bold)),
                    ]
                  )
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mi maecenas etiam sed viverra elementum volutpat in. Mi vitae sem faucibus sagittis facilisis netus vel. Elementum quam dignissim ac, tortor felis iaculis posuere risus, tempus. Scelerisque cras tristique dignissim duis pellentesque. Nisl, nunc aliquet erat et, sit fermentum, luctus ac. Viverra senectus velit, nunc neque egestas varius amet diam. Ornare pellentesque in massa, amet. Cras fringilla pretium, sociis nullam lacus ultrices pulvinar vitae. Tristique pellentesque cursus ut sed amet.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 17,
                  height: 1.3,
                ),
              ),

            )
          ],
        ),
      ),
    );

  }
}
