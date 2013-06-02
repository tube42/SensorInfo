import QtQuick 1.0

// N950 Harmattan theme
Item {
    id: theme
    property int defaultMargin: 18

    property string font1 : "Nokia Pure Text"
    property string font2 : "Nokia Pure Text Light"

    property string listTextFont: font1
    property int listTextFontSize : 32
    property string listTextColor: "#404080"

    property string listDescriptionFont : font1
    property int listDescriptionFontSize : 22
    property string listDescriptionColor : "#000000"


    property string pageTitleFont: font1
    property int pageTitleFontSize : 30
    property string pageTitleColor : "#CCD000"
    property string pageTitleAreaColor: "#56160b"
    property int  pageTitleAreaHeight: pageTitleFontSize + 2 * defaultMargin

    property string splashFont:  font1
    property string splashColor: "brown"
    property int splashFontSize:  58

    property string sectionFontFamily : font1
    property int  sectionFontSize: 30
    property string sectionFontColor: "white"
    property string sectionAreaColor:  "darkGray"

    property string itemFontFamily: font1
    property int itemFontSize: 22
    property string itemFontColor: "black";


    property string listItemBorderImage: "image://theme/meegotouch-list-background-pressed-center"
//    property string listImageArrow: "image://theme/icon-m-common-drilldown-arrow-inverse"
    property string listImageArrow: "image://theme/icon-m-common-drilldown-arrow"


    // fix for meego name missmatch
    property bool inverted: false
}
