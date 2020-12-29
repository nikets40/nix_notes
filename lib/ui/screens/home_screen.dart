import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nix_notes/core/models/notes_model.dart';
import 'package:nix_notes/core/services/db_service.dart';
import 'package:nix_notes/ui/widgets/add_note_button.dart';
import 'package:nix_notes/ui/widgets/drawer_menu.dart';
import 'package:nix_notes/ui/widgets/notes_list_view.dart';
import 'package:nix_notes/ui/widgets/selection_options_header.dart';

class HomeScreen extends StatefulWidget {
  final String location;

  HomeScreen({this.location = "Notes"});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchTextController = new TextEditingController();
    searchTextController
      ..addListener(() {
        setState(() {
          print("updating list");
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<NotesModel>>(
          stream: DBService.instance.fetchNotes(widget.location),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var notes = snapshot.data;
              notes.retainWhere((element) =>
                  element.title
                      .toLowerCase()
                      .contains(searchTextController.text.toLowerCase()) ||
                  element.body
                      .toLowerCase()
                      .contains(searchTextController.text.toLowerCase()));
              return HomeView(
                notes: notes,
                location: widget.location,
                searchController: searchTextController,
              );
            }
            return Container();
          }),
    );
  }
}

class HomeView extends StatefulWidget {
  final List<NotesModel> notes;
  final String location;
  final TextEditingController searchController;

  HomeView({this.notes, @required this.location, this.searchController});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  List<String> selectedNotesIDs = [];
  List<NotesModel> notes;
  bool showSearch = false;

  @override
  void didUpdateWidget(covariant HomeView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (notes != widget.notes)
      setState(() {
        notes = widget.notes;
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notes = widget.notes;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: selectedNotesIDs.length > 0?
         SelectionOptions(selectedNotesIDs: selectedNotesIDs,location: widget.location,onCancel: (){
           setState(() {
             selectedNotesIDs = [];
           });
         },)
          : null,
      appBar: AppBar(
        centerTitle: false,
        title: AnimatedCrossFade(
          firstChild: Text(widget.location),
          secondChild: Theme(
            data: ThemeData.dark(),
            child: TextField(
              autofocus: false,
              controller: widget.searchController,
              decoration:
                  InputDecoration.collapsed(hintText: "Search Notes..."),
            ),
          ),
          crossFadeState:
              showSearch ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: Duration(milliseconds: 300),
        ),
        actions: [
          if(notes.length>0)
          IconButton(
            disabledColor: Colors.white.withOpacity(0.3),
            icon:
                Icon(showSearch ? Icons.close_rounded : Icons.search_outlined),
            onPressed:  (){
              setState(() {
                showSearch = !showSearch;
                if (!showSearch) widget.searchController.clear();
              });
            }
          ),
        ],
      ),
      drawer: DrawerMenu(),
      floatingActionButton: widget.location == "Notes" ? AddNoteButton() : null,
      extendBodyBehindAppBar:(notes.length==0)?true:false,
      body: (notes.length==0)?
     Center(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/images/box.svg",height: 200,),
            SizedBox(height: 30,),
            Text(showSearch?"No results Found!":"Your ${widget.location} tab is Empty!",style: TextStyle(fontSize: 30, color: Colors.white,fontWeight: FontWeight.w600),)
          ],
        ),
      ),
    ):

      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: NotesListView(
            notes: notes,
            isSelectionModeActive: selectedNotesIDs.length > 0,
            onSelected: (index) {
              if (selectedNotesIDs.contains(notes[index].id))
                selectedNotesIDs.remove(notes[index].id);
              else
                selectedNotesIDs.add(notes[index].id);
              setState(() {
                notes[index].isSelected = !notes[index].isSelected;
              });
            },
          ),
        ),
      ),
    );
  }
}
