# CLAW-WX

Experimental partial bindings to [wxWidgets](https://github.com/wxWidgets/wxWidgets) GUI library.

## Build wxWidgets

#### Linux
```sh
cd src/lib/ && ./build.sh desktop
```

## Example
Link `claw-wx` into quicklisp's local-projects.
And once wxWidgets is built:
```common-lisp
(ql:quickload :claw-wx/example)
(wx.example:run)
```
