#!/bin/bash
dbus-send --session --dest=org.xfce.SessionManager --print-reply /org/xfce/SessionManager org.xfce.Session.Manager.Checkpoint string:""
shutdown now