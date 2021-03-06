Ventilation
===========

Ventilation makes developing with ESI a snap.

ESI helps scale your website by allowing you to break it down into fragments
which can be cached independently and reconstructed on the fly. This allows
your server to spend the majority of its time creating the truly dynamic
sections of your site and the rest to be reused and mixed in at the edge.

Using ESI means you need to develop behind varnish or something capable of
composing the response.  Ventilation however, removes this dependecny which
means you can develop with esi using nothing more the script/server. There is
no need to run a local varnish server (you still can if you want to).
Ventilation will automatically compose the page as if it was run through
varnish while you are in development.  When you move out of development or put
your ventilation powered application behind varnish the composed content will
be replaced with esi tags allowing varnish to work it's magic.

WARNING: Using Varnish without Ventilation may result in death!

Example
=======

Include from a content delivery network.

    <%= esi "http://cdn.megadomain.com/network_nav" %>

Include from somewhere else within your application.

    <%= esi :header %>
    <%= esi :header, :controller => :site %>

Copyright (c) 2010 Agora Games, released under the MIT license

Installation
============
    gem install ventilation

Resources
=========
  * [Ventilation GitHub Page](http://github.com/agoragames/ventilation)
  * [Ventilation Documentation on RubyDoc.info](http://rubydoc.info/github/agoragames/ventilation/master/frames)
  * [Ventilation on GemCutter](https://rubygems.org/gems/ventilation)
  * [ESI Language Specification 1.0](http://www.w3.org/TR/esi-lang)
  * [Edge Side Includes - Wikipedia](http://en.wikipedia.org/wiki/Edge_Side_Includes)
