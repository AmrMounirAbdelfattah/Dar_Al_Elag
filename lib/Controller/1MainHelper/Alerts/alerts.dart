import 'package:flutter/material.dart';

Future<dynamic> showAlertNoAction(
    {BuildContext context, String message, String returnMessage}) async {
  return await showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 4,
              ),
              child: Text(
                message,
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "LePatinMagicien",
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    color: Color(0xFF416D6D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 4,
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(returnMessage);
                        },
                        child: Text(
                          'حسناً',
                          textAlign: TextAlign.left,
                          textScaleFactor: 1,
                          style: TextStyle(
                            fontFamily: 'LePatinMagicien',
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future<dynamic> showAlertYesOrNo({
  BuildContext context,
  String title,
}) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 4,
            ),
            child: Text(
              title,
              textScaleFactor: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "LePatinMagicien",
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                color: Color(0xFF416D6D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, "no"),
                    child: Text(
                      'لا',
                      textScaleFactor: 1,
                      style: TextStyle(
                        fontFamily: 'LePatinMagicien',
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                color: Color(0xFF416D6D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, "yes"),
                    child: Text(
                      'نعم',
                      textScaleFactor: 1,
                      style: TextStyle(
                        fontFamily: 'LePatinMagicien',
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
