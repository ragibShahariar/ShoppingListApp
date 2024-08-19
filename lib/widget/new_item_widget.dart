import 'package:flutter/material.dart';
import 'package:myapp/model/shoping_item_model.dart';

class Newitem extends StatefulWidget {
  const Newitem({super.key});

  @override
  State<Newitem> createState() => _NewitemState();
}

class _NewitemState extends State<Newitem> {
  final _formKey = GlobalKey<FormState>();
  var _newItemName = '';
  var _newItemPrice = 0.0;
  var _newItemQuantity = 1;
  var _isCustomQuantity = false;
  DateTime? _selectedUserDate = DateTime.now();

  void _saveItem() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      // Handle the saved item here
      Navigator.of(context).pop<ShopingItemModel>(
        ShopingItemModel(
          _newItemName,
          _newItemPrice,
          _selectedUserDate!,
          _newItemQuantity,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    void selectedDate() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now().add(const Duration(days: 365)),
      ).then((value) {
        if (value != null) {
          setState(() {
            _selectedUserDate = value;
          });
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Item'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Shopping item name'),
                  ),
                  initialValue: _newItemName,
                  maxLength: 50,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length < 2 ||
                        value.trim().length > 50) {
                      return 'Please enter a valid name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _newItemName = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Price'),
                        ),
                        keyboardType: TextInputType.number,
                        initialValue: _newItemPrice.toString(),
                        onChanged: (value) {
                          setState(() {
                            try {
                              _newItemPrice = double.parse(value);
                            } catch (e) {
                              _newItemPrice = 0.0;
                            }
                          });
                        },
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              double.tryParse(value) == null ||
                              double.parse(value) <= 0) {
                            return 'Please enter a valid amount';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: Color(0xFF29323A),
                        ),
                        child: Column(
                          children: [
                            DropdownButtonFormField<String>(
                              value: _newItemQuantity.toString(),
                              items: [
                                for (final qty in [
                                  1,
                                  2,
                                  3,
                                  5,
                                  10,
                                  20,
                                  50,
                                  100,
                                  'custom'
                                ])
                                  DropdownMenuItem(
                                    value: qty.toString(),
                                    child: Text((qty == 'custom')? 'custom' : '${qty.toString()} kg'),
                                  )
                              ],
                              decoration: const InputDecoration(
                                label: Text('Quantity'),
                              ),
                              onChanged: (value) {
                                if (value == 'custom') {
                                  setState(() {
                                    _isCustomQuantity = true;
                                  });
                                } else {
                                  setState(() {
                                    _newItemQuantity = int.parse(value!);
                                    _isCustomQuantity = false;
                                  });
                                }
                              },
                            ),
                            if (_isCustomQuantity)
                              TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    _newItemQuantity = int.tryParse(value) ?? 1;
                                  });
                                },
                                decoration: const InputDecoration(
                                  label: Text('Your quantity'),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (_isCustomQuantity &&
                                      (value == null ||
                                          value.isEmpty ||
                                          int.parse(value) <= 0)) {
                                    return 'Please enter a custom quantity';
                                  }
                                  return null;
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                MaterialButton(
                  padding: const EdgeInsets.all(10),
                  color: const Color(0xFF29323A),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: selectedDate,
                  child: Text(
                    'Pick a Date: ${_selectedUserDate!.day}/${_selectedUserDate!.month}/${_selectedUserDate!.year}',
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _formKey.currentState!.reset();
                      },
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                          color: Color.fromARGB(255, 238, 74, 129),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF29323A),
                      ),
                      onPressed: _saveItem,
                      child: const Text('Save Item'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
