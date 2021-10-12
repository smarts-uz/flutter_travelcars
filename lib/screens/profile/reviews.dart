import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Reviews extends StatefulWidget {
  const Reviews({Key? key}) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  List<Map<String, dynamic>> reviews = [
    {
      'overallrate': '10',
      'rate': [
        {
          'Punctuality': '10',
          'Car driving': '10',
          'knowledge': '10',
          'Terrain orientation': '10',
          'language': '10',
          'Cleanliness / odor in the cabin': '10',
          'Amenities in the salon': '10',
          'Driver professionalism': '10',
          'Price-quality ratio': '10',
        }
      ],

    'info':[
      {
        'avatar': '',
        'name': 'Nazira',
        'flag': '',
        'nationality': 'Uzbekistan',
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
      }

    ],

  },];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (context,index) => Container(
            padding: EdgeInsets.only(left: 16,top: 24),
            child: Column(
              children: [
                Text('Customer Reviews',
                  style: TextStyle(
                  fontSize: 25,
                ),)
              ],
            ),
          )
      ),
    );
  }
}
