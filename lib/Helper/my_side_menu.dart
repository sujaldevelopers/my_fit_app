import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_fit_app/BMI/bmipage.dart';
import 'package:my_fit_app/First_home.dart';
import 'package:my_fit_app/Helper/My_color.dart';
import 'package:my_fit_app/Helper/my_share_prf.dart';
import 'package:my_fit_app/audio/my_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../audio/my_audioservice_widget.dart';
import '../my_run_page.dart';

class NavigationDrawers extends StatelessWidget {
  const NavigationDrawers({super.key});

//MyHome(),//
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(),
            buildMenuItems(),
            Divider(),
            //BmiPage()
          ],
        ),
      ),
    );
  }
}

class buildHeader extends StatelessWidget {
  const buildHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final fontProvider = Provider.of<AudioProvider>(context);
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FirstList(),
          ));
        },
        child: Container(
          color: CustomColor.Side2,
          padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top,
            bottom: 24,
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 52,
                backgroundImage: AssetImage('assert/image/music.gif'),
              ),
              SizedBox(
                height: 12,
              ),
              MyAudioPlayerWidget(),
              // Text(
              //   "The Rock",
              //   style: TextStyle(fontSize: 28, color: Colors.white,fontFamily: fontProvider.selectedFont),
              // ),
              // Text(
              //   "theRock@abc.com",
              //   style: TextStyle(fontSize: 16, color: Colors.white,fontFamily: fontProvider.selectedFont),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class buildMenuItems extends StatefulWidget {
  const buildMenuItems({super.key});

  @override
  State<buildMenuItems> createState() => _buildMenuItemsState();
}

class _buildMenuItemsState extends State<buildMenuItems> {
  @override
  Widget build(BuildContext context) {
    final fontProvider = Provider.of<AudioProvider>(context);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(24),
      child: Wrap(
        children: [
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                height: 40,
                image: AssetImage(
                  "assert/icon/home.gif",
                ),
              ),
            ),
            title: Text("Home",
                style: TextStyle(fontFamily: fontProvider.selectedFonts)),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => FirstList(),
              ));
            },
          ),
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                height: 40,
                image: AssetImage("assert/icon/share .gif",),
              ),
            ),
            title: Text("Share",
                style: TextStyle(fontFamily: fontProvider.selectedFonts)),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => FirstList(),
              ));
            },
          ),
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                height: 40,
                image: AssetImage("assert/icon/rate.gif",),
              ),
            ),
            title: Text("Rating",
                style: TextStyle(fontFamily: fontProvider.selectedFonts)),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => FirstList(),
              ));
            },
          ),
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const Image(
                height: 40,
                image: AssetImage("assert/icon/font-size.gif",),
              ),
            ),
            title: Text(
              "Font",
              style: TextStyle(fontFamily: fontProvider.selectedFonts),
            ),
          ),
          DropdownMenu<String>(
            width: 250,
            menuHeight: 240,
            inputDecorationTheme: InputDecorationTheme(
                isDense: true,
                border: OutlineInputBorder(),
                isCollapsed: false),
            menuStyle: MenuStyle(
                backgroundColor:
                MaterialStatePropertyAll(CustomColor.side)),
            textStyle: TextStyle(
              color: Colors.black,
            ),
            initialSelection: fontProvider.selectedFonts,
            onSelected: (String? value) async {
              //This is called when the user selects an item.
              setState(() {
                for (int i = 0; i < fontProvider.fontList.length; i++) {
                  if (fontProvider.fontList[i] == value) {
                     //print("index==------------------------------------> ${fontProvider.fontList[i]}");
                  }
                }
              });
              final SharedPreferences prefs =
              await SharedPreferences.getInstance();
              await prefs.setString('font', '${value}');
              fontProvider.changeFont(value!);
               //print("${fontProvider.selectedFonts}///////////////////////////////////////////////////////////////");
              // sheredPref.fonts = newFont;
            },
            dropdownMenuEntries: fontProvider.fontList
                .map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
/*   Column(BmiPage
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButton<String>(
                  value: 'f1',
                  elevation: 100,
                  items: fontProvider.fontList.map((String font) {
                    return DropdownMenuItem<String>(
                      value: font,
                      child: Text(font),
                    );
                  }).toList(),

                  onChanged: (newFont)async {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setString('font', '${fontProvider.selectedFonts}');
                    print("${fontProvider.selectedFonts}///////////////////////////////////////////////////////////////");
                   // sheredPref.fonts = newFont;
                    fontProvider.changeFont(newFont!);
                  },
                ),
              ],
            ),*/
