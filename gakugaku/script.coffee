$ = jQuery

class Gakugaku

  shake:(obj) =>
    xpos = (Math.random()-0.5) * @xdepth
    ypos = (Math.random()-0.5) * @ydepth
    r = (Math.random()-0.5) * @tilt
    
    obj.transition
      x: xpos + 'px',
      y: ypos + 'px'
    obj.find("span.tilt").transition
      rotate: r + 'deg'

  constructor: () ->
    vars = getUrlVars()
    if "m" not of vars
      $("#divBase").hide()
      return false
    
    $("#divForm").hide()

    @msg = decodeURIComponent(vars["m"])
    @mode = vars["t"]
    @size = parseFloat(vars["s"])
    @spacing = parseFloat(vars["p"])
    @lspacing = parseFloat(vars["l"])
    @fgcolor = decodeURIComponent(vars["c"])
    @bgcolor = decodeURIComponent(vars["b"])
    @xdepth = parseFloat(vars["x"])
    @ydepth = parseFloat(vars["y"])
    @tilt = parseFloat(vars["r"])
    @frequency = parseFloat(vars["f"])

    f = $("#divForm").find("form")
    f.find("textarea[name='m']").text @msg
    f.find("input[name='t'][value='" + @mode + "']").attr "checked","checked"
    f.find("input[name='s']").val @size
    f.find("input[name='p']").val @spacing
    f.find("input[name='l']").val @lspacing
    f.find("input[name='c']").val @fgcolor
    f.find("input[name='b']").val @bgcolor
    f.find("input[name='x']").val @xdepth
    f.find("input[name='y']").val @ydepth
    f.find("input[name='r']").val @tilt
    f.find("input[name='f']").val @frequency
    
    @frequency *= 1000
    
    switch @mode
      when "w"
        msgary = [@msg.replace(/\n/g,"<BR>")]
      when "l"
        msgary = @msg.split("\n")
        msgary = $.map msgary,(node,index) =>
          return [node,"\n"]
      else
        msgary = @msg.split("")
    
    base = $("#divBase")
    #$(document.body).css "background-color",@bgcolor
    base.css "background-color",@bgcolor
    base.css "color",@fgcolor
    base.css "font-size",@size + "px"
    
    container = $("#divContainer")
    $.each msgary,(idx,str) =>
      if str == "\n"
        span = $("<br />")
      else
        span = $("<span class='pos'><span class='tilt'>" + str + "</span></span>")
      container.append span
      
    spans = container.find("span.pos")
    spans.css "margin-right",@spacing+"px"
    container.css "line-height",(@size + @lspacing)+"px"

    spans.each (idx,obj) =>
      setInterval () => 
        @shake($(obj))
      ,@frequency

    $("#divBase").bind "dblclick",() =>
      $("#divBase").hide()
      $("#divForm").show()

$ ->
  $.fx.speeds._default = 0;
  Gakugaku = new Gakugaku
