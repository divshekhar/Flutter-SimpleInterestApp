import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Interest Calculator App',
      home: SIForm(),
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.green,
        accentColor: Colors.greenAccent,
      )));
}

class SIForm extends StatefulWidget {
  @override
  _SIFormState createState() => _SIFormState();
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();
  var _curriencies = ['Rupees', 'Dollars', 'Pound', 'Other'];
  final double _minPadding = 5.0;
  var _currentItemSelected = '';

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _curriencies[0];
  }

  var displayResult = '';
  TextEditingController principalCont = new TextEditingController();
  TextEditingController rateCont = new TextEditingController();
  TextEditingController termCont = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Simple Interest Calculator')),
      body: Form(
        key: _formKey,
        // margin: EdgeInsets.all(_minPadding * 2),
        child: Padding(
          padding: EdgeInsets.all(_minPadding * 2),
          child: ListView(
            children: <Widget>[
              getImgAsset(),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: TextFormField(
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  controller: principalCont,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please Enter Principal Amount!';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Principal',
                    labelStyle: textStyle,
                    hintText: 'Principal e.g ₹ 20,000',
                    errorStyle: TextStyle(
                      color: Colors.yellow,
                      fontSize: 15.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: TextFormField(
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  controller: rateCont,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please Enter Rate!';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Rate of Interest',
                      labelStyle: textStyle,
                      hintText: 'Rate e.g 5%, 10% etc.',
                      errorStyle: TextStyle(
                        color: Colors.yellow,
                        fontSize: 15.0,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7, bottom: 7),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        style: textStyle,
                        keyboardType: TextInputType.number,
                        controller: termCont,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter Terms!';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Term',
                          labelStyle: textStyle,
                          hintText: 'Time in Years',
                          errorStyle: TextStyle(
                            color: Colors.yellow,
                            fontSize: 15.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: _minPadding * 5,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _curriencies.map((String value) {
                          return DropdownMenuItem<String>(
                              child: Text(value), value: value);
                        }).toList(),
                        value: _currentItemSelected,
                        onChanged: (String newValue) {
                          // Code
                          _onSelectDropDown(newValue);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 7, bottom: 7),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.black,
                        child: Text(
                          'Calculate',
                          style: textStyle,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              if (_formKey.currentState.validate()) {
                                this.displayResult = _calculateSI();
                              }
                            },
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Reset',
                          style: textStyle,
                        ),
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(this.displayResult),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImgAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(image: assetImage, width: 175.0, height: 175.0);

    return Container(
      child: image,
      margin: EdgeInsets.all(_minPadding * 10),
    );
  }

  void _onSelectDropDown(String nV) {
    setState(() {
      this._currentItemSelected = nV;
    });
  }

  String _calculateSI() {
    double principal = double.parse(principalCont.text);
    double rate = double.parse(rateCont.text);
    double term = double.parse(termCont.text);

    double total = principal + (principal * rate * term) / 100;

    return 'Your Investement will be worth $total $_currentItemSelected, after $term Years.';
  }

  void _reset() {
    principalCont.text = '';
    rateCont.text = '';
    termCont.text = '';
    displayResult = '';
    _currentItemSelected = _curriencies[0];
  }
}
