import 'package:flutter/material.dart';
import 'package:medcomp/constants/custom_appbar.dart';
import 'package:medcomp/constants/toast.dart';
import 'package:medcomp/utils/colortheme.dart';
import 'package:medcomp/utils/my_url.dart';
import 'package:medcomp/utils/styles.dart';

class RequestMedicine extends StatefulWidget {
  final String text;
  RequestMedicine({@required this.text});
  @override
  _RequestMedicineState createState() => _RequestMedicineState();
}

class _RequestMedicineState extends State<RequestMedicine> {
  String medicine;

  Widget textfield(label, initialValue, onChange) => Container(
        child: TextFormField(
          maxLines: 1,
          initialValue: initialValue,
          onChanged: onChange,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            fillColor: Colors.black,
            prefixIcon: Icon(
              Icons.medical_services_rounded,
              color: Colors.grey,
              size: 16,
            ),
            labelText: label,
            hintText: 'Enter here',
            labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var container = Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 20),
          textfield('Name of the Medicine', widget.text, (val) {
            setState(() {
              medicine = val;
            });
          }),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              FocusScope.of(context).unfocus();
              try {
                var res = await MyHttp.post('user/add-med', {"name": medicine ?? widget.text});
                if (res.statusCode == 200) {
                  ToastPreset.successful(str: 'Submitted', context: context);
                } else {
                  ToastPreset.err(str: '${res.statusCode} ${res.body}', context: context);
                }
              } catch (e) {
                ToastPreset.err(str: 'Error $e', context: context);
              }
              // print(data);
            },
            child: Text('Submit '),
          ),
        ],
      ),
    );
    return Styles.responsiveBuilder(
      GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: ColorTheme.fontWhite,
          appBar: CustomAppBar.def(context: context, title: 'Request Form'),
          body: container,
        ),
      ),
    );
  }
}
