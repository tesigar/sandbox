$ = jQuery

class Gakugaku

  shake:(obj) =>
    xpos = (Math.random()-0.5) * @xdepth
    ypos = (Math.random()-0.5) * @ydepth
    r = (Math.random()-0.5) * @tilt
    
    obj.transition
      rotate: r + 'deg',
      x: xpos + 'px',
      y: ypos + 'px'

  constructor: () ->
    vars = getUrlVars()
    if "m" not of vars
      $("#divBase").hide()
      return false
    
    $("#divForm").hide()

    @msg = decodeURIComponent(vars["m"])
    @size = vars["s"] + "px"
    @spacing = parseFloat(vars["p"])
    @fgcolor = decodeURIComponent(vars["c"])
    @bgcolor = decodeURIComponent(vars["b"])
    @xdepth = parseFloat(vars["x"])
    @ydepth = parseFloat(vars["y"])
    @tilt = parseFloat(vars["r"])
    @frequency = parseFloat(vars["f"]) * 1000

    msgary = @msg.split("")
    
    base = $("#divBase")
    #$(document.body).css "background-color",@bgcolor
    base.css "background-color",@bgcolor
    base.css "color",@fgcolor
    base.css "font-size",@size
    
    container = $("#divContainer")
    $.each msgary,(idx,str) =>
      span = $("<span>" + str + "</span>")
      container.append span
      
    spans = container.find("span")
    spans.css "margin-right",@spacing+"px"

    spans.each (idx,obj) =>
      setInterval () => 
        @shake($(obj))
      ,@frequency

$ ->
  $.fx.speeds._default = 0;
  Gakugaku = new Gakugaku
