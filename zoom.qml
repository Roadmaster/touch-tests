/* This file is part of Checkbox.

   Copyright 2014 Canonical Ltd.
   Written by:
     Daniel Manrique <roadmr@ubuntu.com>

   Checkbox is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License version 3,
   as published by the Free Software Foundation.

   Checkbox is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with Checkbox.  If not, see <http://www.gnu.org/licenses/>.
*/
import QtQuick 2.0

Rectangle{
    width: 400
    height: 400
    focus: true
    Keys.onEscapePressed: {console.log("ESC pressed, let's quit"); Qt.quit()}
    PinchArea {
        anchors.fill: parent
        onPinchUpdated: {
            rotatable.scale = pinch.scale
             if ( (rotatable.height * rotatable.scale) >= goalsize.height){
                rotatable.color = "green"
            }
            else{
                rotatable.color = "blue"
            }
        }
        onPinchFinished:{
            rotatable.height = rotatable.height * rotatable.scale
            rotatable.width = rotatable.width * rotatable.scale
            rotatable.scale = 1.0
            if ( (rotatable.height ) >= goalsize.height){
                console.log("SUCCESS!")
                timer.running = false
                Qt.quit()
            }
        }
    }
    Rectangle{
        height: 90
        width: 380
        x:10
        y:10
        color: "#aaaaaa"
        radius: 10
    }

    Text {
        id: text
        width: 360
        x:20
        y:20
        property var timeout: 30
        text: "Using two fingers, scale the blue rectangle so it is larger than the red outline. " +
              "Press ESC to cancel the test at any time. <b>Test will exit automatically in " +
              timeout + " seconds </b>"
        wrapMode: Text.Wrap
    }

    Timer {
        id: timer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            text.timeout = text.timeout - 1
            if (text.timeout <= 0) {
                console.log("LETS EXIT")
                running = false
                Qt.quit()
            }
        }
    }

    Rectangle{
        id: goalsize
        width: 300
        height: 210
        x: 50 
        y: 150
        border.color: "red"
        border.width: 4
    }

    Rectangle{
        id: rotatable
        width: goalsize.width * 0.25
        height: goalsize.height * 0.25
        anchors.horizontalCenter: goalsize.horizontalCenter
        anchors.verticalCenter: goalsize.verticalCenter
        color: "blue"
    }
}

