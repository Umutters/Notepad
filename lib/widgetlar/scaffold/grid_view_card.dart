import 'package:flutter/material.dart';


import 'package:umuttersnotlar/classlar/grid_yapisi.dart';
class GridViewCard extends StatefulWidget {
  const GridViewCard({super.key, required this.grids});
  final List<GridYapisi> grids;
  @override
  State<GridViewCard> createState() => _GridViewCardState();
}

class _GridViewCardState extends State<GridViewCard> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1), itemBuilder:(context,deger) {
            return Card(             
              elevation: 2,
              child: Center(
                child: Column(                  
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text('${widget.grids[deger].title}')),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${widget.grids[deger].description}'),
                          IconButton(onPressed: () {}, icon: Icon(Icons.edit))
                        ],
                      )
                  ],
                ),
              ),
            );
          }, itemCount: widget.grids.length, shrinkWrap: true, physics: NeverScrollableScrollPhysics());
  }
}