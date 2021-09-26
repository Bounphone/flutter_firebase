import 'package:flutter/material.dart';
import 'package:flutter_learn_firebase/models/student.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  Student myStudent = new Student();
  // Prepare firebase
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _studentCollection =
      FirebaseFirestore.instance.collection("students");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Error'),
              ),
              body: Center(
                child: Text('${snapshot.error}'),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Save score form'),
              ),
              body: Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Student Name',
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: RequiredValidator(
                              errorText: 'Please enter Student Name'),
                          keyboardType: TextInputType.name,
                          onSaved: (fName) {
                            setState(() {
                              myStudent.fName = fName;
                            });
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Student LastName',
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          validator: RequiredValidator(
                              errorText: 'Please enter Student LastName'),
                          onSaved: (lName) {
                            setState(() {
                              myStudent.lName = lName;
                            });
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Email',
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          validator: MultiValidator([
                            EmailValidator(
                                errorText: 'Email pattern is incorrect'),
                            RequiredValidator(
                                errorText: 'Please enter Student Email')
                          ]),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (email) {
                            setState(() {
                              myStudent.email = email;
                            });
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Exam Score',
                          style: TextStyle(fontSize: 20),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          validator: RequiredValidator(
                              errorText: 'Please enter Student Score'),
                          onSaved: (score) {
                            setState(() {
                              myStudent.score = score;
                            });
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async{
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                await _studentCollection.add({
                                  "fName": myStudent.fName,
                                  "lName": myStudent.lName,
                                  "email": myStudent.email,
                                  "score": myStudent.score
                                });
                                formKey.currentState!.reset();
                              }
                            },
                            child: Text(
                              'Save Data',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
    //
  }
}
