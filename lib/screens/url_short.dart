import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shortly/constant/app_constant.dart';
import 'package:shortly/constant/text_constant.dart';
import 'package:shortly/provider/url_provider.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  var formKey = GlobalKey<FormState>();
  final _text = TextEditingController();
  // ignore: unused_field
  bool _validate = false;
  String baseUrl = 'https://api.shrtco.de/v2/shorten?url=';
  String url = '';
  String hintText = 'Shorten a link here..';
  var hintTextStyle = TextStyle(fontSize: 15, color: Color(0xff89B0AE));
  Color colorBorder = Colors.transparent;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UrlProvider urlProvider = Provider.of<UrlProvider>(context);
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 10,
            ),
            urlProvider.urlShortList.isEmpty
                ? Column(
                    children: [
                      titleTopWidget(),
                      svgWidget(),
                      centerTextWidget(),
                    ],
                  )
                : Container(
                    height: 470,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Your Link History',
                          style: inputPageTitle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 410,
                          child: ListView.builder(
                            itemCount: urlProvider.urlShortList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, top: 10, bottom: 10),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 150,
                                  width: 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              urlProvider.urlLongList[index],
                                              style: inputPageShortUrl,
                                            ),
                                            SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: GestureDetector(
                                                onTap: () {
                                                  urlProvider.removeItem(index);
                                                },
                                                child: SvgPicture.asset(
                                                  svgAssetsPath[0],
                                                  alignment:
                                                      Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              urlProvider.urlShortList[index],
                                              style: inputPageLongUrl,
                                            ),
                                            SizedBox(
                                              width: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                      copyButtonWidget(index)
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
            Container(
                height: 145,
                color: Color(0xFF302B41),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: SvgPicture.asset(
                        svgAssetsPath[3],
                        alignment: Alignment.centerRight,
                        height: 300,
                      ),
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Form(
                            key: formKey,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 35.0,
                                right: 35,
                                bottom: 5,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  autocorrect: false,
                                  textAlign: TextAlign.center,
                                  controller: _text,
                                  //autofocus: false,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: _text.text == ''
                                              ? colorBorder
                                              : Colors.transparent,
                                          width: 5.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    hintText:
                                        hintText, //"Shorten a link here..",
                                    hintStyle: hintTextStyle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          buttonWidget(),
                          SizedBox(
                            height: MediaQuery.of(context).viewInsets.bottom,
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    ));
  }

  Padding copyButtonWidget(index) {
    UrlProvider urlProvider = Provider.of<UrlProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: SizedBox(
        width: 220,
        child: ElevatedButton(
            style: urlProvider.copyList.contains(index)
                ? urlProvider.copyButtonStyleLast
                : urlProvider.copyButtonStyleFirst,
            onPressed: () {
              urlProvider.copyURL(index);
              setState(() {});
            },
            child: Text(
                urlProvider.copyList.contains(index) ? 'COPIED!' : 'COPY')),
      ),
    );
  }

  Column centerTextWidget() {
    return Column(
      children: [
        Text(
          'Let\'s get started!',
          style: welcomeTitleCenter,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Paste your first link into\nthe field to shorten it',
          style: onboardingText,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Column titleTopWidget() {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Text(
          'Shortly',
          style: welcomeTitleUp,
        ),
      ],
    );
  }

  Row svgWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(),
        SizedBox(
          height: 300,
          child: SvgPicture.asset(
            svgAssetsPath[1],
            alignment: Alignment.centerRight,
          ),
        ),
      ],
    );
  }

  Padding buttonWidget() {
    UrlProvider urlProvider = Provider.of<UrlProvider>(context);
    bool validUrl = _text.text.contains('.');
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, right: 35, top: 10, bottom: 5),
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Color(0xff2BD0D0),
              textStyle: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () {
            //print(colorBorder);
            setState(() {
              if (_text.text == '') {
                hintText = 'Please add a link here';
                colorBorder = Color(0xFFDF1111);
                hintTextStyle =
                    TextStyle(fontSize: 15, color: Color(0xFFF81D1D));
              }
              //print(colorBorder);
              url = _text.text;
              _text.text.isEmpty ? _validate = true : _validate = false;
            });
            if (_text.text != '') {
              if (validUrl) {
                urlProvider.getShortUrl(_text.text);
                //getShortUrl();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Entered url is not valid"),
                ));
              }
            }
          },
          child: urlProvider.buttonTitle != 'Load'
              ? Text(
                  urlProvider.buttonTitle,
                  style: welcomeButton,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator()),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Loading..'),
                  ],
                ),
        ),
      ),
    );
  }
}
