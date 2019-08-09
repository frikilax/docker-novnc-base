# docker-novnc
This Docker's goal is to provide a base image for people willing to build a graphical application on servers, headless machines or local hosts.
This docker image uses [phusion/base-image](https://hub.docker.com/r/phusion/baseimage) as base, and adds the necessary components to have an application up and running in a graphical environment accessed through a web page.

This image comes with no application bundled to launch at startup, but installing and running one is made easy with the steps already done here: simply use it as base, then install your application and write a simple [service script](https://github.com/phusion/baseimage-docker#adding_additional_daemons) for it during image build, and you're done !

## The technologies used here
- [TigerVNC (v1.9.0)](https://tigervnc.org/) for the VNC server and X server handling
- [noVNC (v1.1.0)](https://novnc.com/info.html) for the VNC client over a web page
- [ratpoison (v1.4.8)](https://nongnu.org/ratpoison/) as a lightweight windows manager

## Things you should know
- **port 6080** should be opened to access noVNC interface
- **dynamic rescaling** is supported (just make sure your noVNC client has "remote resizing" scaling mode)
- This **SHOULD NOT** be used in production environments or publicly available servers, as it **IS NOT SECURE**
- This could be used to run several applications in a split view, using ratpoison to display them side-by-side (although it goes against docker's philosophy)

## Next steps
- integrate **password authentication**
- use **SSL/TLS** connection
- **shrink** the image size

## Additional informations
This is an image I play with to bundle and run applications on headless servers, this is not an extensive project.
you can find the current image on [docker hub](https://hub.docker.com/r/frikilax/novnc-base) if you want the image.
Feel free to contact me if you think I could use other technologies, make improvements, correct mistakes or if you simply think this image was helpful ! :)
