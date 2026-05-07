{ pkgs, ... }:
let
  pythonEnv = pkgs.python3.withPackages (ps: with ps; [ dbus-python pygobject3 ]);

  script = pkgs.writeText "yazi-filemanager.py" ''
    import dbus
    import dbus.service
    import dbus.mainloop.glib
    from gi.repository import GLib
    import os
    from subprocess import Popen

    def open_yazi(uri, select=False):
        path = str(uri)
        if path.startswith('file://'):
            path = path[7:]
        if select:
            path = os.path.dirname(path)
        if os.fork() == 0:
            Popen(['kitty', 'yazi', path])
            os._exit(0)
        else:
            os.wait()

    class FileManager(dbus.service.Object):
        @dbus.service.method("org.freedesktop.FileManager1", in_signature='ass', out_signature=''')
        def ShowFolders(self, uris, startupId):
            for uri in uris:
                open_yazi(uri)

        @dbus.service.method("org.freedesktop.FileManager1", in_signature='ass', out_signature=''')
        def ShowItems(self, uris, startupId):
            for uri in uris:
                open_yazi(uri, select=True)

        @dbus.service.method("org.freedesktop.FileManager1", in_signature='ass', out_signature=''')
        def ShowItemProperties(self, uris, startupId):
            for uri in uris:
                open_yazi(uri, select=True)

    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
    session_bus = dbus.SessionBus()
    dbus.service.BusName("org.freedesktop.FileManager1", session_bus)
    FileManager(session_bus, '/org/freedesktop/FileManager1')
    GLib.MainLoop().run()
  '';

  daemon = pkgs.writeShellScript "yazi-filemanager" ''
    exec ${pythonEnv}/bin/python3 ${script}
  '';
in
{
  xdg.dataFile."dbus-1/services/org.freedesktop.FileManager1.service".text = ''
    [D-BUS Service]
    Name=org.freedesktop.FileManager1
    Exec=${daemon}
  '';
}
