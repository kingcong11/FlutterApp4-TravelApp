import 'package:flutter/material.dart';

class HotelCarouselItem extends StatelessWidget {

  final int index;
  HotelCarouselItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.orange,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      width: 260,
      child: LayoutBuilder(
        builder: (_, constraints) => Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                // info container
                height: constraints.maxHeight * .4,
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hotel Name',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        'Address',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 3.0),
                      Text('\$ 89.99 / Night'),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: constraints.maxWidth * 0.95,
              width: constraints.maxWidth * 0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 3.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      'assets/images/hotel$index.jpg',
                      height: constraints.maxWidth * 0.95,
                      width: constraints.maxWidth * 0.95,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    // this is the overlay
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.grey[900].withOpacity(0.9),
                        ],
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
