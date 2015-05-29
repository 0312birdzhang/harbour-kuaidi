import QtQuick 2.0
import Sailfish.Silica 1.0

Column {
    width: parent.width
    spacing: -Theme.paddingSmall
    Button {
        id: wizard

        property string selection

        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("Add comment&Rate")
        onClicked: pageStack.push(firstWizardPage)
    }

    Label {
        anchors.horizontalCenter: parent.horizontalCenter
        text: wizard.selection
        color: Theme.highlightColor
    }



}
