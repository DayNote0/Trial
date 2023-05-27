import 'package:date_chat/livevideo/LivePage.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/video_payment_widget.dart';
import '/flutter_flow/chat/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'chat_model.dart';
export 'chat_model.dart';
import 'dart:math';

final liveTextCtrl =
    TextEditingController(text: Random().nextInt(10000).toString());

class ChatWidget extends StatefulWidget {
 ChatWidget({
    Key? key,
    this.chatUser,
    this.chatRef,
  }) : super(key: key);

  final UsersRecord? chatUser;
  final DocumentReference? chatRef;
  

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late ChatModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  FFChatInfo? _chatInfo;
  bool isGroupChat() {
    if (widget.chatUser == null) {
      return true;
    }
    if (widget.chatRef == null) {
      return false;
    }
    return _chatInfo?.isGroupChat ?? false;
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatModel());

    FFChatManager.instance
        .getChatInfo(
      otherUserRecord: widget.chatUser,
      chatReference: widget.chatRef,
    )
        .listen((info) {
      if (mounted) {
        setState(() => _chatInfo = info);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            StreamBuilder<FFChatInfo>(
              stream: FFChatManager.instance.getChatInfo(
                otherUserRecord: widget.chatUser,
                chatReference: widget.chatRef,
              ),
              builder: (context, snapshot) => snapshot.hasData
                  ? FFChatPage(
                      chatInfo: snapshot.data!,
                      allowImages: true,
                      backgroundColor: Color(0xFFF4F0F0),
                      timeDisplaySetting: TimeDisplaySetting.visibleOnTap,
                      currentUserBoxDecoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      otherUsersBoxDecoration: BoxDecoration(
                        color: Color(0xFFFF83DB),
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      currentUserTextStyle: GoogleFonts.getFont(
                        'DM Sans',
                        color: Color(0xFF1E2429),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        fontStyle: FontStyle.normal,
                      ),
                      otherUsersTextStyle: GoogleFonts.getFont(
                        'DM Sans',
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                      inputHintTextStyle: GoogleFonts.getFont(
                        'DM Sans',
                        color: Color(0xFF95A1AC),
                        fontWeight: FontWeight.normal,
                        fontSize: 14.0,
                      ),
                      inputTextStyle: GoogleFonts.getFont(
                        'DM Sans',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 14.0,
                      ),
                      emptyChatWidget: Image.asset(
                        'assets/images/messagesEmpty@2x.png',
                        width: MediaQuery.of(context).size.width * 0.76,
                      ),
                    )
                  : Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: SpinKitPumpingHeart(
                          color: Color(0xFFE304B5),
                          size: 50.0,
                        ),
                      ),
                    ),
            ),
            Material(
              color: Colors.transparent,
              elevation: 1.0,
              child: Container(
                width: 393.0,
                height: 65.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30.0,
                          borderWidth: 1.0,
                          buttonSize: 60.0,
                          icon: Icon(
                            Icons.chevron_left_rounded,
                            color: Colors.black,
                            size: 45.0,
                          ),
                          onPressed: () async {
                            context.safePop();
                          },
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(
                              'userprofilenew1Copy',
                              queryParams: {
                                'userprofile': serializeParam(
                                  widget.chatUser,
                                  ParamType.Document,
                                ),
                              }.withoutNulls,
                              extra: <String, dynamic>{
                                'userprofile': widget.chatUser,
                              },
                            );
                          },
                          child: Container(
                            width: 50.0,
                            height: 50.0,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              widget.chatUser!.photoUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 90.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                'userprofilenew1Copy',
                                queryParams: {
                                  'userprofile': serializeParam(
                                    widget.chatUser,
                                    ParamType.Document,
                                  ),
                                }.withoutNulls,
                                extra: <String, dynamic>{
                                  'userprofile': widget.chatUser,
                                },
                              );
                            },
                            child: Text(
                              widget.chatUser!.displayName,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Builder(
                      builder: (context) => StreamBuilder<UsersRecord>(
                        stream:
                            UsersRecord.getDocument(widget.chatUser!.reference),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 60.0,
                                height: 60.0,
                                child: CircularProgressIndicator(
                                  color: Color(0x004B39EF),
                                ),
                              ),
                            );
                          }
                          final iconButtonUsersRecord = snapshot.data!;
                          return FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30.0,
                            borderWidth: 1.0,
                            buttonSize: 60.0,
                            icon: FaIcon(
                              FontAwesomeIcons.video,
                              color: valueOrDefault<Color>(
                                iconButtonUsersRecord.liveOnline == true
                                    ? FlutterFlowTheme.of(context).alternate
                                    : Colors.black,
                                Colors.black,
                              ),
                              size: 20.0,
                            ),
                            onPressed: () async {
                              final usersUpdateData1 = {
                                'want_video': FieldValue.arrayRemove(['0']),
                              };
                              await currentUserReference!
                                  .update(usersUpdateData1);

                              final usersUpdateData2 = {
                                'want_video': FieldValue.arrayUnion(
                                    [iconButtonUsersRecord.uid]),
                              };
                              await currentUserReference!
                                  .update(usersUpdateData2);
                              if (iconButtonUsersRecord.liveOnline == true) {
                                await showAlignedDialog(
                                  context: context,
                                  isGlobal: true,
                                  avoidOverflow: false,
                                  targetAnchor: Alignment(0.0, 0.0),
                                  followerAnchor: Alignment(0.0, 0.0),
                                  builder: (dialogContext) {
                                    return Material(
                                      color: Colors.transparent,
                                      child: VideoPaymentWidget(
                                        useronline: true,
                                        videopath:
                                            iconButtonUsersRecord.liveVideo,
                                      ),
                                    );
                                  },
                                ).then((value) => setState(() {}));
                              } else {
                                context.pushNamed('LivePage');
                                liveID: liveTextCtrl.text,
                                isHost: true,
                              }

                              await Future.delayed(
                                  const Duration(milliseconds: 6000));

                              final usersUpdateData3 = {
                                'want_video': FieldValue.arrayRemove(
                                    [iconButtonUsersRecord.uid]),
                              };
                              await currentUserReference!
                                  .update(usersUpdateData3);

                              final usersUpdateData4 = {
                                'want_video': FieldValue.arrayUnion(['0']),
                              };
                              await currentUserReference!
                                  .update(usersUpdateData4);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
    void jumpToLivePage(BuildContext context,
      {required String liveID, required bool isHost}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LivePage(liveID: liveID, isHost: isHost),
      ),
    );
  }
}
