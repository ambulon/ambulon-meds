import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcomp/bloc/home.bloc.dart';
import 'package:medcomp/constants/custom_appbar.dart';
import 'package:medcomp/states/home.state.dart';
import 'package:medcomp/utils/colortheme.dart';

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
    Widget bloc = BlocConsumer<HomeBloc, HomeState>(
      listener: (ctx, state) {},
      builder: (ctx, HomeState state) {
        if (state is HomeStateLoading) {
          return Text('loading');
        }
        if (state is HomeStateError) {
          return Text('some error try later');
        }
        if (state is HomeStateLoaded) {
          return Container(
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
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    var data = {
                      "name": state.userModel.name,
                      "email": state.userModel.email,
                      "fid": state.userModel.fid,
                      "medicine": medicine ?? widget.text,
                    };
                    print(data);
                  },
                  child: Text('Submit '),
                ),
              ],
            ),
          );
        }
        return SizedBox();
      },
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorTheme.fontWhite,
        appBar: CustomAppBar.def(context: context, title: 'Request Form'),
        body: bloc,
      ),
    );
  }
}
