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

class Items {
  int id;
  String name, cost;
  Items(this.id, this.name, this.cost);

  static List<Items> getitem() {
    return <Items>[
      Items(1, 'ถัง', '10'),
      Items(2, '600ml (สกรีน)', '45'),
      Items(3, '600ml (ฉลาก)', '45'),
      Items(4, '800ml (สกรีน)', '35'),
      Items(5, '800ml (ฉลาก)', '45'),
      Items(6, '250ml', '45'),
      Items(7, '1500ml', '45'),
    ];
  }
}

List<Items> _companies = Items.getitem();
List<DropdownMenuItem<Items>> _dropdownMenuItems;
Items _selectedCompany;

List<DropdownMenuItem<Items>> buildDropdownMenuItems(List companies) {
  List<DropdownMenuItem<Items>> items = List();
  for (Items company in companies) {
    items.add(
      DropdownMenuItem(
        value: company,
        child: Text(company.name),
      ),
    );
  }
  return items;
}

class _UserFormState extends State<UserForm> {
  final form = GlobalKey<FormState>();
  String valuechoos;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    super.initState();
  }

  onChangeDropdownItem(Items selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }

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
                            value: _selectedCompany,
                            onChanged: onChangeDropdownItem,
                            items: _dropdownMenuItems)),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: TextFormField(
                        onSaved: (newValue) => widget.useproduct.type =
                            newValue = _selectedCompany.name,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                      child: TextFormField(
                        initialValue: widget.useproduct.cost,
                        onSaved: (val) => widget.useproduct.cost =
                            val = _selectedCompany.cost,
                        decoration: InputDecoration(
                          labelText: 'ราคา/โหล : ${_selectedCompany.cost}',
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
