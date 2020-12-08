import 'package:flutter/material.dart';

class ActivitiesItemCard extends StatelessWidget {
  const ActivitiesItemCard({
    @required this.index,
    Key key,
  }) : super(key: key);

  final int index;

  /* Builders */

  Widget _ratingStarBuilder(int rating) {
    String stars = '';

    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    return Text(stars.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        // color: Colors.blue,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (_, constraints) => Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              width: constraints.maxWidth * .9,
              height: constraints.maxHeight,
              padding: EdgeInsets.only(
                left: constraints.maxWidth * .2 + 10,
                top: 10,
                right: 10,
                bottom: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Activity name',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              softWrap: true,
                            ),
                            Text(
                              'Activity Description',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$ 32.99',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          Text(
                            'per pax',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  _ratingStarBuilder(4),
                  SizedBox(height: 10.0),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 30.0,
                        width: 70.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          '8:00 AM',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        alignment: Alignment.center,
                        height: 30.0,
                        width: 70.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          '6:00 PM',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              child: Container(
                width: constraints.maxWidth * .3,
                height: constraints.maxHeight * .95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/activity$index.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
