import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: puzzle(),
  ));
}

class puzzle extends StatefulWidget {
  const puzzle({Key? key}) : super(key: key);

  @override
  State<puzzle> createState() => _puzzleState();
}

class _puzzleState extends State<puzzle> {
  List photo = [
    "apple.png",
    "kiwi.png",
    "Mango.png",
    "orangepng.png",
    "pineapple.png",
    "strawberry.png",
    "apple.png",
    "kiwi.png",
    "Mango.png",
    "orangepng.png",
    "pineapple.png",
    "strawberry.png"
  ];
  List visiblelist=List.filled(12, true);
  String img1="",img2="";
  int pos1=0,pos2=0;
  int t=1;


  @override
  void initState() {
    photo.shuffle();
    Future.delayed(Duration(seconds: 4)).then((value) {
      setState(() {
        visiblelist=List.filled(12, false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("picture puzzle")),
      body: GridView.builder(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                if(t==1)
                  {
                    visiblelist[index]=true;
                    img1=photo[index];
                    pos1=index;
                    t=2;
                  }
                else if(t==2)
                  {
                    visiblelist[index]=true;
                    img2=photo[index];
                    pos2=index;
                    t=1;
                    if(img1==img2)
                      {
                        print("match");
                        if(!visiblelist.contains(false))
                          {
                            print("win");
                            showDialog(builder: (context) {
                              return AlertDialog(title: Text("you are win"),);
                            },context: context);
                          }
                      }
                    else
                    {
                      Future.delayed(Duration(milliseconds: 500)).then((value) {
                        setState(() {
                          visiblelist[pos1]=false;
                          visiblelist[pos2]=false;
                          print("nomatch");
                        });
                      });
                    }
                  }
              });
            },
            child: Visibility(
              visible: visiblelist[index],
                child: Image.asset(
              "photos/${photo[index]}",
              height: 100,
              width: 100,
            ),
              replacement: Container(height: 100,width: 100,color: Colors.red,),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: photo.length,
      ),
    );
  }
}
