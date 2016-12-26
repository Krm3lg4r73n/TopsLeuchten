<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="javax.jdo.Query" %>
<%@ page import="topsleuchten.*" %>

<%
	int offset = 0;
	try
	{
		offset = Integer.parseInt(request.getParameter("offset"));
	}
	catch(NumberFormatException ex) {}
	
	Long view = -1l;
	try
	{
		view = Long.parseLong(request.getParameter("view"));
	}
	catch(NumberFormatException ex) {}
	
	Long id = 0l;
	try
	{
		id = Long.parseLong(request.getParameter("id"));
	}
	catch(NumberFormatException ex)
	{
		response.sendRedirect("/");
		return;
	}
	if(id <= 0)
	{
		response.sendRedirect("/");
		return;
	}
	
	boolean makingOf = (id >= 1000l);
	if (makingOf)
		id -= 1000l;
	int art = (int)(Math.floor((float)id / 100.0f) - 1);
	
	List<Leuchte> leuchten = new ArrayList<Leuchte>();
	PersistenceManager pm = PMFactory.get().getPersistenceManager();
	Query query = pm.newQuery(	"SELECT FROM " + Leuchte.class.getName() + 
								" WHERE id == " + id );
	leuchten = (List<Leuchte>) query.execute();
	
	Leuchte leuchte = null;
	if(leuchten.isEmpty())
	{
		response.sendRedirect("/");
		return;
	}
	else
		leuchte = leuchten.get(0);

	String urlId = "?id=" + request.getParameter("id");
	String urlOffset = "&offset=" + offset;
	String urlView = "&view=" + view;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="keywords" content="topsleuchten, czaplinski, tops, leuchten, lampen, peter" />
	<meta name="author" content="Czaplinski, David" />
	
	<link rel="stylesheet" type="text/css" media="screen" href="{{ site.baseurl }}topsleuchten_style.css">
	<style type="text/css">
		div#content_top
		{
			margin: 0px;
			padding: 0px;
			width: 775px;
			height: 100%;
		}
		
		div#content_top_left
		{
			float: left;
			width: 350px;
			height: 100%;
			text-align: center;
		}
		
		a#title
		{
			background: url({{ site.baseurl }}img/title_small.png) no-repeat;
      		text-decoration: none;
      		display: block;
			width: 100%;
			height: 59px;
		}
		
		div#content_top_right
		{
			margin-left: 30px;
			float: left;
			width: 395px;
			height: 100%;
			text-align: left;
		}	
		
		img#leuchte_haupt
		{
			margin-top: 10px;
			border: 1px solid #AAAAAA;
		}
		
		span#name
		{
			color: #CCCCCC;
			font-size: 30px;
		}
		
		span#desc
		{
			color: #AAAAAA;
			font-size: 20px;
		}
		
		div#content_bottom
		{
			margin: 0px;
			padding: 0px;
			width: 775px;
			height: 100%;
		}
		
		div#content_bottom_select
		{
			width: 775px;
			height: 100px;
			text-align: center;
		}
	
		a.thumb
		{
      		text-decoration: none;
      		display: block;
			float: left;
			width: 100px;
			height: 100px;
			text-align: center;
		}
	
		a#left
		{
			background: url({{ site.baseurl }}img/arrow_left_full.png) no-repeat;
      		text-decoration: none;
      		display: block;
			float: left;
			width: 38px;
			height: 100px;
		}
		
		div#left
		{
			background: url({{ site.baseurl }}img/arrow_left_half.png) no-repeat;
			float: left;
			width: 38px;
			height: 100px;
		}
		
	
		a#right
		{
			background: url({{ site.baseurl }}img/arrow_right_full.png) no-repeat;
      		text-decoration: none;
      		display: block;
      		position: relative;
			left: 738px;
			top: 0px; 
			width: 38px;
			height: 100px;
		}
		
		div#right
		{
			background: url({{ site.baseurl }}img/arrow_right_half.png) no-repeat;
      		position: relative;
			left: 738px;
			top: 0px; 
			width: 38px;
			height: 100px;
		}
		
		div.thumb
		{
			margin-top: 5px;
			margin-bottom: 2px;
			margin-left: auto;
			margin-right: auto;
			border: 1px solid #AAAAAA;
			background-color: #000000;
			width: 75px;
			height: 75px;
		}
		
		div.thumb_img
		{
			margin: 0px;
			padding: 0px;
  			background-repeat: no-repeat;
  			background-position: center;
			width: 75px;
			height: 75px; 
		}
		
		span.thumb
		{
			color: #AAAAAA;
			font-size: 12px;
		}
		
		div#content_bottom_view
		{
			border: 1px solid #AAAAAA;
			background-color: #000000;
			width: 775px;
			height: 775px;
			text-align: center;   
		}
		
		div#content_bottom_img
		{  
  			background-repeat: no-repeat;
  			background-position: center;
			width: 775px;
			height: 775px;
			text-align: center;   
		}
	</style>
	
    <title>TopsLeuchten - <%= leuchte.getName() %></title>
</head>

<body>

	<div id="main">				
		<div id="content">
			<div class="filler_50"></div>
			
			<div id="content_top">
			
				<div id="content_top_left">
					<a id="title" href="{{ site.baseurl }}/leuchte_auswahl.jsp?art=<%= art %>"></a>
					<img id="leuchte_haupt" src="<%= leuchte.getImgurl({{ site.baseurl }}) %>main.jpg" width="300" height="225" /> <br/>
				</div>
				
				<div id="content_top_middle"></div>
				
				<div id="content_top_right">
					<h3><span id="name"><%= leuchte.getName() %></span></h3>
					<span id="desc"><%= leuchte.getDesc() %></span>
				</div>
				
			</div><!-- content_top -->
			
			<div class="filler_50"></div>
			
			<div id="content_bottom">
				<div id="content_bottom_select">
					<%					
						//write left arrow
						if(offset <= 0)
							out.println("<div id='left'></div>");
						else
							out.println("<a id='left' href='" + urlId + "&offset=" + (offset-1) + urlView + "'></a>");
						
						List<LeuchteDetail> details = new ArrayList<LeuchteDetail>();
						
						if(makingOf)
							query = pm.newQuery("SELECT FROM " + LeuchteDetail.class.getName() + 
												" WHERE leuchteId == " + (leuchte.getId() + 1000l) +
												" ORDER BY date ASC");
						else
							query = pm.newQuery(	"SELECT FROM " + LeuchteDetail.class.getName() + 
									" WHERE leuchteId == " + leuchte.getId() +
									" ORDER BY date ASC");
						
						query.setRange(offset*7, Long.MAX_VALUE);
						details = (List<LeuchteDetail>) query.execute();
						int count = details.size();
						
						if(makingOf)
							count++; //add the making-of/return link
						
						query.setRange(offset*7, (offset*7)+7);
						details = (List<LeuchteDetail>) query.execute();
						
						if (!details.isEmpty())
						{
							for (LeuchteDetail detail : details)
							{
								out.println("<a class='thumb' href='#' onclick='setImage(\"" + 
											leuchte.getImgurl({{ site.baseurl }}) + detail.getImg() + "\"); return false;'>");
								out.println("<div class='thumb'><div class='thumb_img' style='background-image: url({{ site.baseurl }}" + 
											leuchte.getImgurl({{ site.baseurl }}) + "thumb_" + detail.getImg() + 
											");'></div></div>" );
								out.println("<span class='thumb'>" + detail.getName() + "</span>");
								out.println("</a>");
							}
						}

						//write making of link and right arrow
						if(count > 7)
						{
							out.println("<a id='right' href='" + urlId + "&offset=" + (offset+1) + urlView + "'></a>");
						}
						else
						{
							if(leuchte.hasMakingOf())
							{
								if (makingOf)
								{
									out.println("<a class='thumb' href='" + "?id=" + id + "'>");
									out.println("<div class='thumb'><div class='thumb_img' style='background-image: url({{ site.baseurl }}" + 
												"/img/return.png" +
												");'></div></div>" );
									out.println("<span class='thumb'>Zurück</span>");
									out.println("</a>");
								}
								else
								{
									out.println("<a class='thumb' href='" + "?id=" + (id+1000l) + "'>");
									out.println("<div class='thumb'><div class='thumb_img' style='background-image: url({{ site.baseurl }}" + 
												"/img/making_of.png" +
												");'></div></div>" );
									out.println("<span class='thumb'>Making Of</span>");
									out.println("</a>");
								}
							}
							out.println("<div id='right'></div>");
						}
					%>
				</div>
				
				<div class="filler_25"></div>
			
				<div id="content_bottom_view">					
					<%				
						List<LeuchteDetail> viewDetailList = new ArrayList<LeuchteDetail>();
						
						if (view > 0)
						{
							query = pm.newQuery("SELECT FROM " + LeuchteDetail.class.getName() + 
												" WHERE id == " + view );
						}
						else if (makingOf)
						{
							query = pm.newQuery("SELECT FROM " + LeuchteDetail.class.getName() + 
												" WHERE leuchteId == " + (leuchte.getId()+1000l) +
												" ORDER BY date ASC");
						}
						else
						{
							query = pm.newQuery("SELECT FROM " + LeuchteDetail.class.getName() + 
									" WHERE leuchteId == " + leuchte.getId() +
									" ORDER BY date ASC");
						}
						query.setRange(0, 1);
						viewDetailList = (List<LeuchteDetail>) query.execute();
						
						if(!viewDetailList.isEmpty())
						{
							LeuchteDetail viewDetail = viewDetailList.get(0);
							out.println("<div id='content_bottom_img' style='background-image: url({{ site.baseurl }}" + 
										leuchte.getImgurl({{ site.baseurl }}) + viewDetail.getImg() + 
										");'></div>" );
						}
					%>
				</div>
			</div>
			
			<div class="filler_50"></div>
			
			<div id="footer">
				<span id="footer">&copy; TopsLeuchten 2011 - <a id="kontakt" href="{{ site.baseurl }}/kontakt.jsp">Kontakt &amp; Gästebuch</a></span><br/>
				<hr style="background-color:#777777; height:1px; width:700px; text-align:center; margin-bottom:0px; margin-top:10px;" />
				<span id="footer" style="font-size:8pt;">Webseitengestaltung &amp; -entwicklung: D. Czaplinski.&nbsp;&nbsp;&nbsp;Für den Inhalt der Seite sind die Betreiber verantwortlich.</span>
			</div>
		</div><!-- content -->
		
	</div><!-- main -->
	
	<script src="ajax.js"></script>
</body>

</html>

<%
	pm.close();
%>