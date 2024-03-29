<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="ViewBase.html.xsl"/>

<!--************* Main template ******************** -->		
<xsl:template match="/document">
<html>
	<head>
		<xsl:call-template name="initHead"/>
		
		<title>rustent</title>
		
		<script>		
			function beforeUnload(e){
				if (window.m_childForms){
					for(var fid in window.m_childForms){
						if (window.m_childForms[fid]){
							window.m_childForms[fid].close();
						}
					}
				}
				
				if (window.onClose){					
					window.onClose();
				}
				/*
				if (window.getApp){
					var view = window.getApp().m_view;
					if (view &amp;&amp; view.getModified &amp;&amp; view.getModified()){
					
						var mes = "Вы уверены что хотите закрыть окно и отказаться от записи?";
						if(e)e.returnValue = mes;						
						return mes;						
					}
				}
				*/
				return;
				
			}
			<xsl:call-template name="modelFromTemplate"/>
			function pageLoad(){
				var application;
				if (window.getApp){
					application = window.getApp();
					<xsl:call-template name="initAppWin"/>
					
				}
				else{
					<xsl:call-template name="initApp"/>
				}
				window.isChild = true;
				<xsl:call-template name="checkForError"/>
				if (window.opener &amp;&amp; !window["getParam"] &amp;&amp; !window.opener["paramsSet"]&amp;&amp; !window.opener["getChildParam"]){
					//ie hack wait for params to appear
					window.view_shown = false;
					var param_check = setInterval(function(){
						if (window["getParam"] || window.opener["paramsSet"]){
							clearInterval(param_check);
							showView();
						}
					},500);
				}
				else{
					//ie hack
					if (window.opener &amp;&amp; !window["getParam"] &amp;&amp; window.opener["getChildParam"]){
						window["getParam"] = window.opener["getChildParam"];
					}
					showView();
				}
			}
		</script>
	</head>
	
	<body onload="pageLoad();" onbeforeunload="return beforeUnload();">
	
		<!-- Page container -->
		<div class="page-container">

			<!-- Page content -->
			<div class="page-content">

				<!-- Main content -->
				<div class="content-wrapper">

					<!-- Content area -->
					<div class="content">
						<div class="row">
							<div id="windowData" class="col-lg-12">
								<xsl:apply-templates select="model[@htmlTemplate='TRUE']"/>
							</div>

							<div class="windowMessage hidden">
							</div>
							<!--waiting  -->
							<div id="waiting">
								<div>Обработка...</div>
								<img src="img/loading.gif"/>
							</div>
							
						</div>
						
						<!-- Footer -->
						<div class="footer text-muted text-center">
							2019. <a href="#">Катрэн+</a>
						</div>
						<!-- /footer -->

					</div>
					<!-- /content area -->

				</div>
				<!-- /main content -->

			</div>
			<!-- /page content -->

		</div>
		<!-- /page container -->
	    
		<xsl:call-template name="initJS"/>
		<!--
		<script>
			window.onload=pageLoad;
		</script>
		-->
	</body>
</html>		
</xsl:template>

</xsl:stylesheet>
