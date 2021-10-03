import QtQuick 2.0

  //Implementation of the Button control.
  Item {
      id: button
      width: 47
      height: 47
      property alias text: innerText.text
      signal clicked

      Image {
          id: backgroundImage
          anchors.fill: parent
          source: (button.enabled ? "qrc:/image/setting.png" : "qrc:/image/setting_1.png")
      }

      Text {
          id: innerText
          anchors.centerIn: parent
          color: "white"
          font.bold: true
      }





      //Mouse area to react on click events
      MouseArea {
          anchors.fill: button
          onClicked: {

                  var component = Qt.createComponent("Setting.qml");
                  if (component.status === Component.Ready) {
                      var dialog = component.createObject(parent,{popupType: 1});
                      dialogConnection.target = dialog



                  }}
          onPressed: {
              backgroundImage.source = "qrc:/image/setting_pressed.png"

          }
          onReleased: {
              backgroundImage.source = (button.enabled ? "qrc:/image/setting_1" : "qrc:/image/setting.png")
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
