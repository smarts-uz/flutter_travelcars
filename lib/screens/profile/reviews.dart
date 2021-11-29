import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelcars/screens/feedback/feedback.dart';
class Reviews extends StatefulWidget {
  const Reviews({Key? key}) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  Map<String, dynamic> reviews = {
    'overallrate': '10',
    'rateN': '6',
    'rate': [
      {
        'title': 'Punctuality',
        "score": 8.0
      },
      {
        'title': 'Car driving',
        "score": 3.0
      },
      {
        'title': 'Knowledge',
        "score": 7.0
      },
      {
        'title': 'Punctuality',
        "score": 6.0
      },
      {
        'title': 'Car driving',
        "score": 9.0
      },
      {
        'title': 'Knowledge',
        "score": 9.0
      },
      {
        'title': 'Knowledge',
        "score": 5.0
      },
      {
        'title': 'Punctuality',
        "score": 8.0
      },
      {
        'title': 'Car driving',
        "score": 3.0
      },
      {
        'title': 'Knowledge',
        "score": 7.0
      },
      {
        'title': 'Punctuality',
        "score": 6.0
      },
      {
        'title': 'Car driving',
        "score": 9.0
      },
      {
        'title': 'Knowledge',
        "score": 5.0
      },
      {
        'title': 'Knowledge',
        "score": 10.0
      },
    ],
    "reviews": [
      {
        'avatar': '',
          'name': 'Nazira',
          'flag': '',
          'nationality': 'Uzbekistan',
          'p_rate':10,
          'location': 'Family garden, Хумсон',
          'date': '31-08-2021',
          'reviewtime': '30 Aug 2021 15:08:52',
          'fine': 'I would like to note that we have already contacted you more than once.'
              ' The trip went well. The minibus is comfortable, '
              'clean, without foreign odors (there was even a bakhur for aromatization). '
              'The driver was extremely polite (he opened the doors, arrived at the agreed time,'
              ' immediately offered to connect to bluetooth (if you need musical accompaniment on the road). '
              'He orients himself perfectly in the area.'
              ' We arrived comfortably, quickly and without any outside chatter from the driver. Thank you.'
              ' We will be contact again!'
        },
      {
          'avatar': '',
          'name': 'Salima',
          'flag': '',
          'nationality': 'USA',
          'p_rate':10,
          'location': 'Family garden, Хумсон',
          'date': '31-08-2021',
          'reviewtime': '30 Aug 2021 15:08:52',
          'fine': 'I would like to note that we have already contacted you more than once.'
              ' The trip went well. The minibus is comfortable, '
              'clean, without foreign odors (there was even a bakhur for aromatization). '
              'The driver was extremely polite (he opened the doors, arrived at the agreed time,'
              ' immediately offered to connect to bluetooth (if you need musical accompaniment on the road). '
              'He orients himself perfectly in the area.'
              ' We arrived comfortably, quickly and without any outside chatter from the driver. Thank you.'
              ' We will be contact again!'
        },
      {
        'avatar': '',
        'name': 'Salima',
        'flag': '',
        'nationality': 'USA',
        'p_rate':10,
        'location': 'Family garden, Хумсон',
        'date': '31-08-2021',
        'reviewtime': '30 Aug 2021 15:08:52',
        'fine': 'I would like to note that we have already contacted you more than once.\ n'
            ' The trip went well. The minibus is comfortable, \n'
            'clean, without foreign odors (there was even a bakhur for aromatization). \n'
            'The driver was extremely polite (he opened the doors, arrived at the agreed time,\n'
            ' immediately offered to connect to bluetooth (if you need musical accompaniment on the road). \n'
            'He orients himself perfectly in the area.\n'
            ' We arrived comfortably, quickly and without any outside chatter from the driver. Thank you.\n'
            ' We will be contact again!'
      },
      {
        'avatar': '',
        'name': 'Salima',
        'flag': '',
        'nationality': 'USA',
        'p_rate':10,
        'location': 'Family garden, Хумсон',
        'date': '31-08-2021',
        'reviewtime': '30 Aug 2021 15:08:52',
        'fine': 'I would like to note that we have already contacted you more than once.'
            ' The trip went well. The minibus is comfortable, '
            'clean, without foreign odors (there was even a bakhur for aromatization). '
            'The driver was extremely polite (he opened the doors, arrived at the agreed time,'
            ' immediately offered to connect to bluetooth (if you need musical accompaniment on the road). '
            'He orients himself perfectly in the area.'
            ' We arrived comfortably, quickly and without any outside chatter from the driver. Thank you.'
            ' We will be contact again!'
      },




  ]
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text(
          'Reviews',
          style: TextStyle(
              color: Colors.white,
              fontSize: 25
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
              padding: EdgeInsets.only(left: 16,top: 24, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Customer Reviews',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),),
                  Divider(
                    endIndent: 220,
                    thickness: 2,
                    color: Colors.orange,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 24,right: 24),
                        height: MediaQuery.of(context).size.height*.15,
                        width: MediaQuery.of(context).size.width*.45,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Text(
                            reviews["overallrate"],
                            style: TextStyle(
                              fontSize: 65,
                              color: Colors.white
                          ),),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 24,left: 14),
                        height: MediaQuery.of(context).size.height*.15,
                        width: MediaQuery.of(context).size.width*.35,
                        child: Column(
                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Fine',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22
                            ),),
                            Spacer(),
                            Text("${reviews['rateN']}  reviews",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),),
                            Spacer(),
                            Container(
                              height: MediaQuery.of(context).size.height*.045,
                              width: MediaQuery.of(context).size.width*.45,
                              child: RaisedButton(
                                color: Colors.white,
                                child:Text('write a feedback',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.orange
                                ),
                                ),
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => FeedbackScreen()),
                                  );
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: BorderSide(
                                        color: Colors.orange
                                    )
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 50),
                    height: 1100,//MediaQuery.of(context).size.height*.7,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: reviews['rate'].length,
                        itemBuilder: (context,index) {
                          List<String> titles = [
                            "Driver",
                            "Car",
                            "Overall rating"
                          ];
                          String text_t = index == 0 ? titles[0] : index == 5 ? titles[1] : index == 7 ? titles[2] : " ";
                          double h_cal =  index == 4 || index == 6 ? 110 : 62;
                          double rate = (reviews['rate'][index]["score"])/10;
                          return Container(
                            height: h_cal,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                text_t != " " ? Container(
                                  padding: EdgeInsets.only(bottom: 3),
                                  child: Text(
                                   text_t,
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ) : Text(''),
                                Text("${reviews['rate'][index]["title"]}"),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey, width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 10,
                                      width: MediaQuery.of(context).size.width*.85,
                                      child: FractionallySizedBox(
                                        widthFactor: rate,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text("${reviews['rate'][index]["score"].toInt()}"),

                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                        ),

                  ),
                  Text('Guest reviews:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),),
                  Divider(
                    endIndent: 250,
                    thickness: 2,
                    color: Colors.orange,
                  ),
                  Container(
                    height: reviews["reviews"].length * 250.0,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:reviews["reviews"].length,
                      itemBuilder: (context,index1) => Container(
                        height: 350,
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ListTile(
                              leading:CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage("assets/Image.png"),
                              ),
                              title: Text(' ${reviews["reviews"][index1]["name"]},'),
                              subtitle: Text('${reviews['reviews'][index1]['nationality']}'),
                             trailing: Container(
                               height: 24,
                               width: 24,
                               decoration: BoxDecoration(
                                 color: Colors.orange,
                                 borderRadius: BorderRadius.circular(4.0),
                               ),
                                child: Center(
                                  child: Text('${reviews['reviews'][index1]["p_rate"]}'),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.orange,
                                ),

                                Text('${reviews['reviews'][index1]["location"]}',
                                  style: TextStyle(fontWeight: FontWeight.bold),),

                                Icon(
                                    Icons.calendar_today_outlined,
                                  color: Colors.orange,

                                ),

                                Text('${reviews['reviews'][index1]["date"]}',
                                  style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            Container(
                              padding: EdgeInsets.only(left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${reviews["reviews"][index1]["reviewtime"]}",
                                      textAlign: TextAlign.start
                                  ),

                                  SizedBox(
                                    height: 10,
                                  ),

                                  Text("${reviews["reviews"][index1]["fine"]}",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),


                          ],
                        ),

                      ),
                    )
                  ),


                ]
              )
        )
      )
    );
  }
}
