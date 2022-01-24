import 'package:flutter/material.dart';
import 'package:helo/Form/Useproduct.dart';

typedef OnDelete();

class UserForm extends StatefulWidget {
  final Useproduct useproduct;
  final state = _UserFormState();
  final OnDelete onDelete;

  UserForm({Key key, this.useproduct, this.onDelete}) : super(key: key);
  @override
  _UserFormState createState() => state;

  bool isValid() => state.validate();
}

class _UserFormState extends State<UserForm> {
  final form = GlobalKey<FormState>();
  String valuechoos;

  List listitem = [
    "ถัง",
    "250ml",
    "600ml (สกรีน)",
    "600ml (ฉลาก)",
    "800ml (สกรีน)",
    "800ml (ฉลาก)",
    "1500ml"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                leading: Icon(
                  Icons.verified_user,
                  color: Colors.green,
                ),
                elevation: 0,
                title: Text('Product Details'),
                backgroundColor: Colors.blue[900],
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: widget.onDelete,
                  )
                ],
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                        child: DropdownButton(
                          //dropdownColor: Colors.white,

                          hint: Text(
                            "ชนิดสินค้า",
                          ),
                          value: valuechoos,
                          onChanged: (newValue) {
                            setState(() {
                              widget.useproduct.type = valuechoos = newValue;
                            });
                          },
                          items: listitem.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                      child: TextFormField(
                        initialValue: widget.useproduct.cost,
                        onSaved: (val) => widget.useproduct.cost = val,
                        validator: (val) =>
                            val.length > 0 ? null : 'โปรดระบุ ราคา/โหล',
                        decoration: InputDecoration(
                          labelText: 'ราคา / โหล',
                          hintText: 'โปรดกรอกข้อมูล',
                          icon: Icon(Icons.email),
                          isDense: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                      child: TextFormField(
                        initialValue: widget.useproduct.unit,
                        onSaved: (val) => widget.useproduct.unit = val,
                        validator: (val) =>
                            val.length > 0 ? null : 'โปรดระบุจำนวนที่ส่ง',
                        decoration: InputDecoration(
                          labelText: 'จำนาน',
                          hintText: 'โปรดกรอกข้อมูล',
                          icon: Icon(Icons.email),
                          isDense: true,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }
}
