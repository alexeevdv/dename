#!/bin/bash

function detect_gnome()
{
    ps -e | grep gnome-session > /dev/null
    if [ $? -ne 1 ];
    then
        VERSION=`gnome-session --version | awk '{print $2}'`
        DESKTOP="GNOME $VERSION"
    else
        DESKTOP="UNKNOWN"
    fi
}

function detect_kde()
{
    ps -e | grep kdm > /dev/null
    if [ $? -ne 1 ];
    then
        VERSION=`kded4 --version | grep Platform | awk '{print $4}'`
        DESKTOP="KDE $VERSION"
    else
        DESKTOP="UNKNOWN"
    fi
}

function detect_unity()
{
    ps -e | grep unity-panel > /dev/null
    if [ $? -ne 1 ];
    then
	VERSION=`unity --version | awk '{print $2}'`
	DESKTOP="UNITY $VERSION"
    else
	DESKTOP="UNKNOWN"
    fi
}

function detect_xfce()
{
    ps -e | grep xfce4-session > /dev/null
    if [ $? -ne 1 ];
    then
	VERSION=`xfce4-session --version | grep xfce4-session | awk '{print $2}'`
	DESKTOP="XFCE $VERSION"
    else
	DESKTOP="UNKNOWN"
    fi
}

function detect_cinnamon()
{
    ps -e | grep cinnamon > /dev/null
    if [ $? -ne 1 ];
    then
	VERSION=`cinnamon --version | awk '{print $2}'`
	DESKTOP="CINNAMON $VERSION"
    else
	DESKTOP="UNKNOWN"
    fi
}

function detect_mate()
{
    ps -e | grep mate-panel > /dev/null
    if [ $? -ne 1 ];
    then
	VERSION=`mate-about --version | awk '{print $4}'`
	DESKTOP="MATE $VERSION"
    else
	DESKTOP="UNKNOWN"
    fi
}

detect_gnome
if [ "$DESKTOP" == "UNKNOWN" ];
then
    detect_kde
    if [ "$DESKTOP" == "UNKNOWN" ];
    then
        detect_unity
	if [ "$DESKTOP" == "UNKNOWN" ];
	then
	    detect_xfce
	    if [ "$DESKTOP" == "UNKNOWN" ];
	    then
		detect_cinnamon
		if [ "$DESKTOP" == "UNKNOWN" ];
		then
		    detect_mate
		    if [ "$DESKTOP" == "UNKNOWN" ];
		    then
			echo $DESKTOP > /dev/null
		    fi
		fi
	    fi
	fi
    fi
fi

echo $DESKTOP
