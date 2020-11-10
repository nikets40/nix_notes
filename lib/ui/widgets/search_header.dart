import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchHeader extends StatefulWidget {
  final TextEditingController searchController;
  final Function(int) gridCount;
  final VoidCallback onMenuClick;

  SearchHeader({@required this.searchController, this.gridCount, this.onMenuClick});

  @override
  _SearchHeaderState createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeader> {

  var crossFadeState = CrossFadeState.showSecond;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Card(
        elevation: 10,
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.menu), onPressed: widget.onMenuClick),
            Expanded(
              child: InkWell(
                onTap: (){},
                child: Container(
                  height: kToolbarHeight * 0.8,
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextField(
                      controller: widget.searchController,
                      decoration: InputDecoration.collapsed(
                          hintText: "Search your Notes"),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            // InkWell(
            //   onTap: (){
            //     setState(() {
            //       if(crossFadeState==CrossFadeState.showFirst){
            //         crossFadeState = CrossFadeState.showSecond;
            //         widget.gridCount(2);
            //       }
            //       else {
            //         widget.gridCount(1);
            //         crossFadeState = CrossFadeState.showFirst;}
            //     });
            //
            //   },
            //   child: Container(
            //     height: kToolbarHeight*0.8,
            //     width: kToolbarHeight*0.8,
            //     child: Center(
            //       child: AnimatedCrossFade(
            //         firstChild: Icon(Icons.grid_view),
            //         secondChild: Icon(Icons.view_agenda_outlined),
            //         duration: Duration(milliseconds: 200),
            //         crossFadeState: crossFadeState,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
