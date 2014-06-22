/*
 * Facebox (for jQuery)
 * version: 1.3
 * @requires jQuery v1.2 or later
 * @homepage https://github.com/defunkt/facebox
 *
 * Licensed under the MIT:
 *   http://www.opensource.org/licenses/mit-license.php
 *
 * Copyright Forever Chris Wanstrath, Kyle Neath
 *
 * Usage:
 *
 *  jQuery(document).ready(function() {
 *    jQuery('a[rel*=facebox]').facebox()
 *  })
 *
 *  <a href="#terms" rel="facebox">Terms</a>
 *    Loads the #terms div in the box
 *
 *  <a href="terms.html" rel="facebox">Terms</a>
 *    Loads the terms.html page in the box
 *
 *  <a href="terms.png" rel="facebox">Terms</a>
 *    Loads the terms.png image in the box
 *
 *
 *  You can also use it programmatically:
 *
 *    jQuery.facebox('some html')
 *    jQuery.facebox('some html', 'my-groovy-style')
 *
 *  The above will open a facebox with "some html" as the content.
 *
 *    jQuery.facebox(function($) {
 *      $.get('blah.html', function(data) { $.facebox(data) })
 *    })
 *
 *  The above will show a loading screen before the passed function is called,
 *  allowing for a better ajaxy experience.
 *
 *  The facebox function can also display an ajax page, an image, or the contents of a div:
 *
 *    jQuery.facebox({ ajax: 'remote.html' })
 *    jQuery.facebox({ ajax: 'remote.html' }, 'my-groovy-style')
 *    jQuery.facebox({ image: 'stairs.jpg' })
 *    jQuery.facebox({ image: 'stairs.jpg' }, 'my-groovy-style')
 *    jQuery.facebox({ div: '#box' })
 *    jQuery.facebox({ div: '#box' }, 'my-groovy-style')
 *
 *  Want to close the facebox?  Trigger the 'close.facebox' document event:
 *
 *    jQuery(document).trigger('close.facebox')
 *
 *  Facebox also has a bunch of other hooks:
 *
 *    loading.facebox
 *    beforeReveal.facebox
 *    reveal.facebox (aliased as 'afterReveal.facebox')
 *    init.facebox
 *    afterClose.facebox
 *
 *  Simply bind a function to any of these hooks:
 *
 *   $(document).bind('reveal.facebox', function() { ...stuff to do after the facebox and contents are revealed... })
 *
 */
(function(a){function b(b){if(a.facebox.settings.inited)return!0;a.facebox.settings.inited=!0,a(document).trigger("init.facebox"),e();var c=a.facebox.settings.imageTypes.join("|");a.facebox.settings.imageTypesRegexp=new RegExp("\\.("+c+")(\\?.*)?$","i"),b&&a.extend(a.facebox.settings,b),a("body").append(a.facebox.settings.faceboxHtml);var d=[new Image,new Image];d[0].src=a.facebox.settings.closeImage,d[1].src=a.facebox.settings.loadingImage,a("#facebox").find(".b:first, .bl").each(function(){d.push(new Image),d.slice(-1).src=a(this).css("background-image").replace(/url\((.+)\)/,"$1")}),a("#facebox .close").click(a.facebox.close).append('<img src="'+a.facebox.settings.closeImage+'" class="close_image" title="close">')}function c(){var a,b;return self.pageYOffset?(b=self.pageYOffset,a=self.pageXOffset):document.documentElement&&document.documentElement.scrollTop?(b=document.documentElement.scrollTop,a=document.documentElement.scrollLeft):document.body&&(b=document.body.scrollTop,a=document.body.scrollLeft),[a,b]}function d(){var a;return self.innerHeight?a=self.innerHeight:document.documentElement&&document.documentElement.clientHeight?a=document.documentElement.clientHeight:document.body&&(a=document.body.clientHeight),a}function e(){var b=a.facebox.settings;b.loadingImage=b.loading_image||b.loadingImage,b.closeImage=b.close_image||b.closeImage,b.imageTypes=b.image_types||b.imageTypes,b.faceboxHtml=b.facebox_html||b.faceboxHtml}function f(b,c){if(b.match(/#/)){var d=window.location.href.split("#")[0],e=b.replace(d,"");if(e=="#")return;a.facebox.reveal(a(e).html(),c)}else b.match(a.facebox.settings.imageTypesRegexp)?g(b,c):h(b,c)}function g(b,c){var d=new Image;d.onload=function(){a.facebox.reveal('<div class="image"><img src="'+d.src+'" /></div>',c)},d.src=b}function h(b,c){a.get(b,function(b){a.facebox.reveal(b,c)})}function i(){return a.facebox.settings.overlay==!1||a.facebox.settings.opacity===null}function j(){if(i())return;return a("#facebox_overlay").length==0&&a("body").append('<div id="facebox_overlay" class="facebox_hide"></div>'),a("#facebox_overlay").hide().addClass("facebox_overlayBG").css("opacity",a.facebox.settings.opacity).click(function(){a(document).trigger("close.facebox")}).fadeIn(200),!1}function k(){if(i())return;return a("#facebox_overlay").fadeOut(200,function(){a("#facebox_overlay").removeClass("facebox_overlayBG"),a("#facebox_overlay").addClass("facebox_hide"),a("#facebox_overlay").remove()}),!1}a.facebox=function(b,c){a.facebox.loading(),b.ajax?h(b.ajax,c):b.image?g(b.image,c):b.div?f(b.div,c):a.isFunction(b)?b.call(a):a.facebox.reveal(b,c)},a.extend(a.facebox,{settings:{opacity:.2,overlay:!0,loadingImage:"/assets/facebox/loading.gif",closeImage:"/assets/facebox/closelabel.png",imageTypes:["png","jpg","jpeg","gif"],faceboxHtml:'    <div id="facebox" style="display:none;">       <div class="popup">         <div class="content">         </div>         <a href="#" class="close"></a>       </div>     </div>'},loading:function(){b();if(a("#facebox .loading").length==1)return!0;j(),a("#facebox .content").empty().append('<div class="loading"><img src="'+a.facebox.settings.loadingImage+'"/></div>'),a("#facebox").show().css({top:c()[1]+d()/10,left:a(window).width()/2-a("#facebox .popup").outerWidth()/2}),a(document).bind("keydown.facebox",function(b){return b.keyCode==27&&a.facebox.close(),!0}),a(document).trigger("loading.facebox")},reveal:function(b,c){a(document).trigger("beforeReveal.facebox"),c&&a("#facebox .content").addClass(c),a("#facebox .content").empty().append(b),a("#facebox .popup").children().fadeIn("normal"),a("#facebox").css("left",a(window).width()/2-a("#facebox .popup").outerWidth()/2),a(document).trigger("reveal.facebox").trigger("afterReveal.facebox")},close:function(){return a(document).trigger("close.facebox"),!1}}),a.fn.facebox=function(c){function d(){a.facebox.loading(!0);var b=this.rel.match(/facebox\[?\.(\w+)\]?/);return b&&(b=b[1]),f(this.href,b),!1}if(a(this).length==0)return;return b(c),this.bind("click.facebox",d)},a(document).bind("close.facebox",function(){a(document).unbind("keydown.facebox"),a("#facebox").fadeOut(function(){a("#facebox .content").removeClass().addClass("content"),a("#facebox .loading").remove(),a(document).trigger("afterClose.facebox")}),k()})})(jQuery)