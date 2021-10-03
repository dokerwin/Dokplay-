import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.3
import QtWebView 1.1
import QtQuick 2.0
import "Buttons/"

MessageDialog {
    id: messageDialog
    title:"SETINGS"
    text: "It's so cool that you are using Qt Quick."
    contentItem: Rectangle {

        implicitWidth: 400
        implicitHeight: 400
        Row {
            spacing: 20




            MyIconButton {
                id: btn_add_folder
                img_src: "qrc:/image/folder.png";
                btn_txt: "Add folder"
                onClickedLeft: {

                    var component = Qt.createComponent("File.qml");
                    if (component.status === Component.Ready) {
                        var dialog = component.createObject(parent,{popupType: 1});
                        dialogConnection.target = dialog
                    }
                }
            }


            MyIconButton {
                id: btn_clear_playlist
                img_src: "qrc:/image/clear.png";
                btn_txt: "Clear playlist"
                onClickedLeft:appCore.clearPlaylist()
            }


        }
        Connections {
            id: dialogConnection
            onVisibleChanged: {
                if(!target.visible)
                    console.log(target.returnValue);
            }
        }


    }

    Component.onCompleted: visible = true



}
