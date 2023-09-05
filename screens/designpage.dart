import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';





class DesignPageState extends StatefulWidget {
  const DesignPageState({super.key});

  @override
  State<DesignPageState> createState() => _DesignPageState();
}

class _DesignPageState extends State<DesignPageState> {


  String tool="";
  int dx=0;
  int dy=0;
  bool cropping = false;
  int selectedPageIndex = 3;
  late Rect rect = Rect.fromCenter(
    center: Offset(300, 300),
    width: 50,
    height: 50,
  );

  late Rect cropRect = rect;

  List<String> ImageList = [];

  List<String> images = [
    'assets/images/넣고싶은이미지',
  ];



  String? selectedImage;
  @override
  void initState(){
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu,color: Colors.black,)),
        title: Text("happycat",style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search,color: Colors.black,)),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none,color: Colors.black,)),
          IconButton(onPressed: () {Navigator.pushNamed(context, '/home_screen');}, icon: Icon(Icons.home_outlined,color: Colors.black,)),
          IconButton(onPressed: () {Navigator.pushNamed(context, '/Login');}, icon: Icon(Icons.login_rounded,color: Colors.black,)),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[

            _DragClothes(),
            // DesignBox
            if (ImageList.isNotEmpty) // ImageList가 비어있지 않으면 아래 코드를 실행
              _createTransformableBoxes(),
            // Image List
            _backgroundWidgetList(),
            ResetButton(),
            _Save(),
            isResize(),

          ],
        ),
      ),
    );
  }

  Widget ResetButton(){
    return Transform.scale(  scale: 3,
      // 위치 설정
      child: Transform.translate(
        offset: const Offset(20, 20),

        child: GestureDetector(
          onTap: () {
            setState(() {
              ImageList.clear();

            });
          },
          child: Container(
            color: Colors.black,
            width: 25,
            height: 15,
            child: Center(
              child: Text('초기화',style: TextStyle(color: Colors.white,fontSize: 8),),
            ),
          ),
        ),
      ),
    );
  }
  Widget isResize(){
    return Transform.scale(  scale: 3,
      // 위치 설정
      child: Transform.translate(
        offset: const Offset(100, 20),

        child: GestureDetector(
          onTap: () {
            setState(() {
              if(cropping != true)
                cropping = true;
              else
                cropping = false;
            });
          },
          child: Container(
            color: Colors.black,
            width: 25,
            height: 15,
            child: Center(
              child: Text(cropping ?'보임':'안보임',
                style: TextStyle(color: Colors.white,fontSize: 7),),
            ),
          ),
        ),
      ),
    );
  }
  Widget _createTransformableBoxes() {

    // Create a list of TransformableBoxes using ImageList
    return Stack(
      children: <Widget> [
        // Add the _DragClothes() widget here if you want it to be a part of the TransformableBoxes stack

        if (ImageList.isNotEmpty)
          for (var index = 0; index < ImageList.length; index++)
            _createTransformableBox(index, rect),
      ],
    );
  }

  Widget _createTransformableBox(int index, Rect rect) {
    late Rect rect = Rect.fromCenter(
      center: Offset(200+(index*10), 300+(index*10)),
      width: 50,
      height: 50,
    );
    // Check if ImageList is empty
    if (ImageList.isEmpty) {
      // If empty, use default image
      return Container();
    } else {
      // If not empty, use the selected image at the given index
      return TransformableBox(
        key: ValueKey('TransformableBox_$index'),
        rect: rect,
        onChanged: (result, event) {
          setState(() {
            rect = result.rect;
            print(selectedPageIndex.toString());
            result.position.dx;
            result.position.dy;
          });

        },
        contentBuilder: (BuildContext context, Rect rect, Flip flip) {
          return DecoratedBox(
            decoration: BoxDecoration(
              
              image: ImageList.isNotEmpty
                  ? DecorationImage(
                image: AssetImage(ImageList[index]),
                fit: BoxFit.fill,
              )
                  : null,
            ),
          );
        },
        enabledHandles: {
          if(!cropping)
            ...HandlePosition.values

        } ,
        visibleHandles: {
          if (!cropping) // Returns an empty set when in cropping mode.
            ...HandlePosition.corners,
        },

        /*resize corner*/
        cornerHandleBuilder: (context, handle) => DefaultCornerHandle(
          handle: handle,
          decoration: BoxDecoration(
            color: Colors.pink,
            border: Border.all(
              color: Colors.pink,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(180)
          ),
        ),
      );
    }
  }

  Widget _backgroundWidgetList() {
    return Align(
      alignment: Alignment.bottomLeft, // Adjust alignment to bottom-left
      child: Container(
        height: 100,
        color: Colors.white,
        child: PageView.builder(
          controller: PageController(viewportFraction: 0.2, initialPage: selectedPageIndex),
          scrollDirection: Axis.horizontal, // Set the scroll direction to horizontal
          onPageChanged: (index) {
            setState(() {
              selectedPageIndex = index; // Update the selected image index
              selectedImage = images[index];
            });
          },
          itemCount: images.length,
          itemBuilder: (context, index) {
            final image = images[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedPageIndex = index;
                  selectedImage = image;
                  ImageList.add(image);// Store the selected image index
                });
              },
              child: SizedBox(
                width: 40,
                height: 40,
                child: Image.asset(image),
              ),
            );
          },
        ),
      ),
    );
  }
  Widget _DragClothes(){
    return Container(
      height: MediaQuery.of(context).size.height*0.65,

      decoration: BoxDecoration(
        border: Border.all(color: Colors.black,width: 2),

        image: DecorationImage(image: AssetImage("assets/images/clothes.png"))
      ),
    );
  }
  Widget _Save(){
    return Transform.scale(  scale: 3,
      // 위치 설정
      child: Transform.translate(
        offset: const Offset(40, 20),

        child: GestureDetector(
          onTap: () {
            setState(() {
            });
          },
          child: Container(
            color: Colors.black,
            width: 25,
            height: 15,
            child: Center(
              child: Text('저장',style: TextStyle(color: Colors.white,fontSize: 8),),
            ),
          ),
        ),
      ),
    );
  }
}