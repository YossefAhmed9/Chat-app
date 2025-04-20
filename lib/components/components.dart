import 'package:flutter/material.dart';

class DefaultTextFormField {
  final Key? key;
  final TextInputType keyboard;
  final TextEditingController controller;
  Function? submit;
  Function? change;
  Function? tap;
  final String label;
  final OutlinedBorder border;

  //final Icon prefix;
  final Function(String?)? validate;

  DefaultTextFormField(
    this.key,
    this.submit,
    this.change,
    this.tap,
    this.validate, {
    required this.keyboard,
    required this.controller,
    required this.label,
    required this.border,
    // required this.prefix,
  });
}

Widget defaultTextFormField(
  final Key? key,
  final TextInputType keyboard,
  final TextEditingController controller,
  final Function(String?) submit,
  final Function(String?) change,
  final GestureTapCallback? tap,
  final String label,
  final InputBorder border,
  final Icon prefix,
  final FormFieldValidator<String>? validate,
) =>
    TextFormField(
      key: key,
      keyboardType: keyboard,
      controller: controller,
      onFieldSubmitted: submit,
      onChanged: change,
      onTap: tap,
      validator: validate,
      scrollPhysics: BouncingScrollPhysics(),

      decoration: InputDecoration(
        labelText: label,
        border: border,
        prefixIcon: prefix
      ),
    );

//Default Button
class DefaultButton {
  final double width;
  final double height;
  final Color buttonColor;
  final Function function;
  final String text;
  final Color textColor;
  final double? fontSize;

  //Constructor
  DefaultButton(
      {required this.width,
      required this.height,
      required this.buttonColor,
      required this.function,
      required this.text,
      required this.textColor,
      required this.fontSize});
}

Widget defaultButton(
  final double width,
  final double height,
  final Color buttonColor,
  final Function,
  final String text,
  final Color textColor,
  final double? fontSize,
) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: buttonColor,
      ),
      child: MaterialButton(
        onPressed: Function,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
          ),
        ),
      ),
    );

void navigateAndDelPast(context, screen) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => screen), (route) {
    return false;
  });
}

void navigateTo(
  context,
  screen,
) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

/*
class Product {
  Widget newCard(
      {required ProductModel model, required BuildContext context}) =>
      GestureDetector(
        onTap: () {
          navigateTo(
              context,
              UpdateProduct(
                  title: model.title,
                  price: model.price,
                  description: model.description,
                  image: model.image));
        },
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 70,
                            ),
                            Text(
                              model.title.substring(0, 18),
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.black,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${model.price} \$',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 50,
                  bottom: 100,
                  child: Image.network(
                    model.image,
                    width: 105,
                    height: 105,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}

*/

void showSnackBar(
    BuildContext context, String message, int duration, Color? color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: duration),
      backgroundColor: color,
    ),
  );
}

Widget ChatBubble(int index, List data) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              bottom: 8.0, left: 8.0, right: 55.0, top: 8.0),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                '${data[index].message}',
                style: TextStyle(fontSize: 15, color: Colors.white),
                softWrap: true,
                maxLines: 5,
              ),
            ),
          ),
        ),
      ],
    );
Widget SenderChatBubble(int index, List data) => Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              bottom: 8.0, right: 8.0, left: 55.0, top: 8.0),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                '${data[index].message}',
                style: TextStyle(fontSize: 15, color: Colors.white),
                softWrap: true,
                maxLines: 5,
              ),
            ),
          ),
        ),
      ],
    );
