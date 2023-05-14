// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:my_lingua/helpers/custom_color.dart';
import 'package:my_lingua/helpers/error_msg.dart';
import 'package:my_lingua/helpers/page_navigation.dart';
import 'package:my_lingua/models/custom_input.dart';
import 'package:my_lingua/providers/auth.dart';
import 'package:my_lingua/screens/language.dart';
import 'package:my_lingua/screens/loading.dart';
import 'package:my_lingua/widgets/custom_btn.dart';
import 'package:my_lingua/widgets/custom_text.dart';
import 'package:my_lingua/widgets/custom_text_input.dart';
import 'package:provider/provider.dart';

class PreferenceScreen extends StatefulWidget {
  @override
  _PreferenceScreenState createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  // String _fileName;
  // List<PlatformFile> _paths;
  // String _directoryPath;
  // String _extenstion;
  // bool _loadingPath = false;
  // bool _multiPick = false;
  // FileType _pickingType = FileType.any;
  // TextEditingController _controller = TextEditingController();
  var data;
  String buttonselected = 'Silver';
  var resp = [];

  // @override
  // void initState() {
  //   super.initState();
  //   _controller.addListener(() => _extenstion = _controller.text);
  // }

  // void _openFileExplorer() async {
  //   setState(() {
  //     _loadingPath = true;
  //   });
  //   try {
  //     _directoryPath = null;
  //     _paths = (await FilePicker.platform.pickFiles(
  //       type: _pickingType,
  //       allowMultiple: _multiPick,
  //       allowedExtensions: (_extenstion?.isNotEmpty ?? false)
  //           ? _extenstion?.replaceAll(" ", "")?.split(",")
  //           : null,
  //     ))
  //         ?.files;
  //   } on PlatformException catch (e) {
  //     print("Unsupported operation" + e.toString());
  //   } catch (ex) {
  //     print(ex);
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _loadingPath = false;
  //     _fileName = _paths != null ? _paths.map((e) => e.name).toString() : "...";
  //   });
  // }

  // void _clearCatchedFiles() {
  //   FilePicker.platform.clearTemporaryFiles().then((value) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text((value
  //           ? 'Temporary files removed with success.'
  //           : 'Failed to clean temporary files')),
  //     ));
  //   });
  // }

  // void _selectFolder() {
  //   FilePicker.platform.getDirectoryPath().then((value) {
  //     setState(() {
  //       _directoryPath = value;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    var userName = CustomTextInp(
      hintText: "Username",
      icon: Icon(
        Icons.person,
        color: black,
      ),
    );
    var password = CustomTextInp(
      hintText: "Password",
      icon: Icon(Icons.lock, color: black),
      secured: true,
    );
    var email = CustomTextInp(
      hintText: "Email",
      pervious: data != null ? data[0] : "",
      icon: Icon(
        Icons.message,
        color: black,
      ),
    );
    var languagePreference = CustomTextInp(
      hintText: "Language preference",
      pervious: data != null ? data[2] : "",
      icon: Icon(
        Icons.translate,
        color: black,
      ),
    );

    final formKey = GlobalKey<FormState>();
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(),
      drawer: Drawer(),
      body: auth.status == Status.Authentcating
          ? LoadingScreen()
          : ListView(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  child: auth.status != Status.Failed
                      ? Container()
                      : Container(
                          alignment: Alignment.center,
                          child: ErrorMessage(
                            check: resp.length == 0
                                ? Status.Uninitialized
                                : auth.status,
                            response: resp.length > 1 ? resp[1]["email"] : [""],
                          ),
                        ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextInput(
                        textInp: userName,
                      ),
                      CustomTextInput(textInp: password),
                      ErrorMessage(
                        check: resp.length == 0
                            ? Status.Uninitialized
                            : auth.status,
                        response: resp.length > 1 ? resp[1]["password"] : [""],
                      ),
                      CustomTextInput(textInp: email),
                      ErrorMessage(
                        check: resp.length == 0
                            ? Status.Uninitialized
                            : auth.status,
                        response: resp.length > 1 ? resp[1]["email"] : [""],
                      ),
                      CustomTextInput(textInp: languagePreference),
                      ErrorMessage(
                        check: resp.length == 0
                            ? Status.Uninitialized
                            : auth.status,
                        response: resp.length > 1 ? resp[1]["username"] : [""],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: DropdownButton(
                          value: buttonselected,
                          onChanged: (String newValue) {
                            setState(() {
                              buttonselected = newValue;
                            });
                          },
                          items: [
                            DropdownMenuItem(
                              value: 'Silver',
                              child: CustomText(text: "Silver Account"),
                            ),
                            DropdownMenuItem(
                              value: 'Gold',
                              child: CustomText(text: "Gold Account"),
                            ),
                            DropdownMenuItem(
                              value: 'Platinum',
                              child: CustomText(text: "Platinum Account"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          text: "Submit",
                          onPressed: () async {
                            final form = formKey.currentState;
                            form.save();
                            resp = await auth.preferenceInput(userName.value,
                                email.value, password.value, buttonselected);
                            if (resp[0]) {
                              return changeScreen(context, LanguageScreen());
                            }
                          },
                        ),
                      ]),
                ),
                SizedBox(
                  height: 50,
                // ),
                // Padding(
                //                   padding: const EdgeInsets.only(top: 20.0),
                //   child: DropdownButton(
                //       hint: const Text('LOAD PATH FROM'),
                //       value: _pickingType,
                //       items: <DropdownMenuItem>[
                //         DropdownMenuItem(
                //           child: const Text('FROM AUDIO'),
                //           value: FileType.audio,
                //         ),
                //         DropdownMenuItem(
                //           child: const Text('FROM IMAGE'),
                //           value: FileType.image,
                //         ),
                //         DropdownMenuItem(
                //           child: const Text('FROM VIDEO'),
                //           value: FileType.video,
                //         ),
                //         DropdownMenuItem(
                //           child: const Text('FROM MEDIA'),
                //           value: FileType.media,
                //         ),
                //         DropdownMenuItem(
                //           child: const Text('FROM ANY'),
                //           value: FileType.any,
                //         ),
                //         DropdownMenuItem(
                //           child: const Text('CUSTOM FORMAT'),
                //           value: FileType.custom,
                //         ),
                //       ],
                //       onChanged: (value) => setState(() {
                //             _pickingType = value;
                //             if (_pickingType != FileType.custom) {
                //               _controller.text = _extenstion = '';
                //             }
                //           })),
                // ),
                // ConstrainedBox(
                //   constraints: const BoxConstraints.tightFor(width: 100.0),
                //   child: _pickingType == FileType.custom
                //       ? TextFormField(
                //           maxLength: 15,
                //           autovalidateMode: AutovalidateMode.always,
                //           controller: _controller,
                //           decoration:
                //               InputDecoration(labelText: 'File extension'),
                //           keyboardType: TextInputType.text,
                //           textCapitalization: TextCapitalization.none,
                //         )
                //       : const SizedBox(),
                // ),
                // ConstrainedBox(
                //   constraints: const BoxConstraints.tightFor(width: 200.0),
                //   child: SwitchListTile.adaptive(
                //     title:
                //         Text('Pick multiple files', textAlign: TextAlign.right),
                //     onChanged: (bool value) =>
                //         setState(() => _multiPick = value),
                //     value: _multiPick,
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                //   child: Column(
                //     children: <Widget>[
                //       ElevatedButton(
                //         onPressed: () => _openFileExplorer(),
                //         child: const Text("Open file picker"),
                //       ),
                //       ElevatedButton(
                //         onPressed: () => _selectFolder(),
                //         child: const Text("Pick folder"),
                //       ),
                //       ElevatedButton(
                //         onPressed: () => _clearCatchedFiles(),
                //         child: const Text("Clear temporary files"),
                //       ),
                //     ],
                //   ),
                // ),
                // Builder(
                //   builder: (BuildContext context) => _loadingPath
                //       ? Padding(
                //           padding: const EdgeInsets.only(bottom: 10.0),
                //           child: const CircularProgressIndicator(),
                //         )
                //       : _directoryPath != null
                //           ? ListTile(
                //               title: const Text('Directory path'),
                //               subtitle: Text(_directoryPath),
                //             )
                //           : _paths != null
                //               ? Container(
                //                   padding: const EdgeInsets.only(bottom: 30.0),
                //                   height:
                //                       MediaQuery.of(context).size.height * 0.50,
                //                   child: Scrollbar(
                //                       child: ListView.separated(
                //                     itemCount:
                //                         _paths != null && _paths.isNotEmpty
                //                             ? _paths.length
                //                             : 1,
                //                     itemBuilder:
                //                         (BuildContext context, int index) {
                //                       final bool isMultiPath =
                //                           _paths != null && _paths.isNotEmpty;
                //                       final String name = 'File $index: ' +
                //                           (isMultiPath
                //                               ? _paths
                //                                   .map((e) => e.name)
                //                                   .toList()[index]
                //                               : _fileName ?? '...');
                //                       final path = _paths
                //                           .map((e) => e.path)
                //                           .toList()[index]
                //                           .toString();


                //                       return ListTile(
                //                         title: Text(
                //                           name,
                //                         ),
                //                         subtitle: Text(path),
                //                       );
                //                     },
                //                     separatorBuilder:
                //                         (BuildContext context, int index) =>
                //                             const Divider(),
                //                   )),
                //                 )
                //               : const SizedBox(),
                // ),
                )],
            ),);
            
    
  }
}
