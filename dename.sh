#!/bin/bash

function detect_gnome()
{
    ps -e | grep -E '^.* gnome-session$' > /dev/null
    if [ $? -ne 0 ];
    then
	return 0
    fi
    VERSION=`gnome-session --version | awk '{print $2}'`
    DESKTOP="GNOME $VERSION"
    return 1
}

function detect_kde()
{
    ps -e | grep -E '^.* kdm$' > /dev/null
    if [ $? -ne 0 ];
    then
	return 0
    fi
    VERSION=`kded4 --version | grep Platform | awk '{print $4}'`
    DESKTOP="KDE $VERSION"
    return 1
}

function detect_unity()
{
    ps -e | grep -E '^.* unity-panel$' > /dev/null
    if [ $? -ne 0 ];
    then
	return 0
    fi
    VERSION=`unity --version | awk '{print $2}'`
    DESKTOP="UNITY $VERSION"
    return 1
}

function detect_xfce()
{
    ps -e | grep -E '^.* xfce4-session$' > /dev/null
    if [ $? -ne 0 ];
    then
	return 0
    fi
    VERSION=`xfce4-session --version | grep xfce4-session | awk '{print $2}'`
    DESKTOP="XFCE $VERSION"
    return 1
}

function detect_cinnamon()
{
    ps -e | grep -E '^.* cinnamon$' > /dev/null
    if [ $? -ne 0 ];
    then
	return 0
    fi
    VERSION=`cinnamon --version | awk '{print $2}'`
    DESKTOP="CINNAMON $VERSION"
    return 1
}

function detect_mate()
{
    ps -e | grep -E '^.* mate-panel$' > /dev/null
    if [ $? -ne 0 ];
    then
	return 0
    fi
    VERSION=`mate-about --version | awk '{print $4}'`
    DESKTOP="MATE $VERSION"
    return 1
}

function detect_lxde()
{
    ps -e | grep -E '^.* lxsession$' > /dev/null
    if [ $? -ne 0 ];
    then
	return 0
    fi

    which apt-cache > /dev/null 2> /dev/null

    if [ $? -ne 0 ];
    then
	which yum > /dev/null 2> /dev/null
	if [ $? -ne 0 ];
	then
	    VERSION='UNKNOWN'
	else
	    # For Fedora
	    VERSION=`yum list lxde-common | grep lxde-common | awk '{print $2}' | awk -F '-' '{print $1}'`
	fi
    else    
	# For Lubuntu and Knoppix
	VERSION=`apt-cache show lxde-common /| grep 'Version:' | awk '{print $2}' | awk -F '-' '{print $1}'`
    fi
    DESKTOP="LXDE $VERSION"
    return 1
}

DESKTOP="UNKNOWN"
if detect_gnome;
then
    if detect_kde;
    then
	if detect_unity;
	then
	    if detect_xfce;
	    then
		if detect_cinnamon;
		then
		    if detect_mate;
		    then
			detect_lxde
		    fi
		fi
	    fi
	fi
    fi
fi

echo $DESKTOP
